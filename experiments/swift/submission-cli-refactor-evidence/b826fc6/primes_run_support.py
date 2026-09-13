from datetime import datetime, timezone
from pathlib import Path
import hashlib, os, signal, subprocess

def utc(): return datetime.now(timezone.utc).isoformat()
def sha(path): return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def snapshot():
    rows = []
    for line in subprocess.check_output(['ps', '-axo', 'pid=,pcpu=,comm='], text=True).splitlines():
        p = line.strip().split(None, 2)
        if len(p) == 3: rows.append({'pid': int(p[0]), 'cpu_percent': float(p[1]), 'executable': Path(p[2]).name})
    names = {'swiftc', 'swift-frontend', 'xcodebuild', 'clang', 'benchmark', 'verify', 'verify-asan', 'verify-wmo',
             'extra-verify-asan', 'extra-verify-wmo', 'phase-verify', 'phase-verify-asan', 'phase-verify-wmo',
             'phase-split', 'repository-bool', 'repository-packed', 'repository-striped', 'new'}
    audio = [line.strip() for line in subprocess.check_output(['pmset', '-g', 'assertions'], text=True).splitlines()
             if any(t in line.lower() for t in ['audio', 'playing', 'playback'])]
    return {'at_utc': utc(), 'top_processes': sorted(rows, key=lambda r: r['cpu_percent'], reverse=True)[:15],
            'competing_build_test_benchmark': [r for r in rows if r['executable'] in names],
            'audio_assertions': audio, 'caffeinate_pids': [r['pid'] for r in rows if r['executable'] == 'caffeinate']}
def check_conditions(s):
    assert not s['competing_build_test_benchmark'], 'Competing build/test/benchmark observed'
    assert not s['audio_assertions'], 'Audio activity observed'
def run(command, cwd):
    entry = {'command': command, 'cwd': str(cwd), 'started_at_utc': utc()}
    print('RUN ' + ' '.join(command), flush=True)
    lines = []; p = None
    try:
        p = subprocess.Popen(command, cwd=cwd, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, start_new_session=True)
        entry['owned_process_group'] = p.pid
        for line in p.stdout:
            lines.append(line); print(line, end='', flush=True)
        p.wait()
    except BaseException as error:
        entry['error'] = type(error).__name__ + ': ' + str(error)
        if p is not None:
            try: os.killpg(p.pid, signal.SIGTERM)
            except ProcessLookupError: pass
            try: p.wait(timeout=5)
            except subprocess.TimeoutExpired: pass
            # Reap the parent and stop any descendants that outlived it before
            # the caller can leave the timing lock's context.
            try: os.killpg(p.pid, signal.SIGKILL)
            except ProcessLookupError: pass
            p.wait()
            entry['owned_process_group_terminated_on_error'] = True
    finally:
        if p is not None and p.stdout is not None: p.stdout.close()
        entry.update(exit_code=p.returncode if p is not None else None,
                     combined_stdout_stderr=''.join(lines), finished_at_utc=utc())
    return entry
class TimingLock:
    path = Path('/tmp/primes-timing.lock')
    def __init__(self, description): self.description = description
    def __enter__(self):
        fd = os.open(self.path, os.O_CREAT | os.O_EXCL | os.O_WRONLY, 0o600)
        os.write(fd, (self.description + '\n').encode()); os.close(fd)
        self.inode = self.path.stat().st_ino
        return self
    def __exit__(self, *exception):
        if self.path.exists() and self.path.stat().st_ino == self.inode: self.path.unlink()
