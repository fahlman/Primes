from pathlib import Path
import hashlib, json, os, platform, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, snapshot, utc

repo = Path('/Users/ryan/Developer/Primes-compact-dense-loops')
root = repo / 'experiments/swift'
evidence = root / 'compact-loop-evidence'
build = root / '.build/compact-loop-probe'
candidate = '1a259a84a892cc1008de179ef332d66bd1c514bf'
control = '1d0522115846d8c6487d49a9bf0e60b18b9d8599'
harness = '25402d46ba991b39451724d3873d326626981e3f'
record = {'candidate': candidate, 'control': control, 'harness': harness,
          'started_at_utc': utc(), 'commands': [], 'status': 'running'}
evidence.mkdir(exist_ok=True); build.mkdir(parents=True, exist_ok=True)
output = evidence / 'verification-1a259a8.json'
assert not output.exists(), 'Preserve previous evidence'

def git(*args):
    return subprocess.check_output(['git', '-C', str(repo), *args])

def save(): output.write_text(json.dumps(record, indent=2) + '\n')

def checked(command, cwd=root):
    result = run(list(map(str, command)), cwd)
    record['commands'].append(result); save()
    assert result['exit_code'] == 0, f'Command failed: {command}'
    return result

try:
    assert git('rev-parse', 'HEAD').decode().strip() == candidate
    record['tracked_diff'] = git('diff', 'HEAD', '--', 'experiments/swift').decode()
    assert record['tracked_diff'] == ''
    record['platform'] = platform.platform()
    record['before'] = snapshot()
    with TimingLock(f'Codex compact dense-loop codegen and correctness {candidate}'):
        checked(['swiftc', '--version'])
        observer = build / 'BenchmarkObserver.swift'
        observer.write_bytes(git('show', f'{harness}:experiments/swift/BenchmarkObserver.swift'))
        runner = git('show', f'{harness}:experiments/swift/Benchmark.swift')
        record['runner_sha256'] = hashlib.sha256(runner).hexdigest()
        record['observer_sha256'] = hashlib.sha256(observer.read_bytes()).hexdigest()
        checked(['swiftc', '-O', '-parse-as-library', '-module-name', 'BenchmarkObserver',
                 '-emit-module', '-emit-module-path', build / 'BenchmarkObserver.swiftmodule',
                 '-emit-object', observer, '-o', build / 'BenchmarkObserver.o'])
        for name, revision in [('control', control), ('candidate', candidate)]:
            d = build / name; d.mkdir(exist_ok=True)
            source = git('show', f'{revision}:experiments/swift/PrimeSieve.swift')
            (d / 'PrimeSieve.swift').write_bytes(source)
            (d / 'Benchmark.swift').write_bytes(runner)
            record[f'{name}_source_sha256'] = hashlib.sha256(source).hexdigest()
            assembly = evidence / f'{name}-1a259a8.s'
            checked(['swiftc', '-O', '-whole-module-optimization', '-module-name', 'PrimeSwift',
                     '-I', build, d / 'PrimeSieve.swift', d / 'Benchmark.swift', '-S', '-o', assembly])
            asm = assembly.read_text()
            assert 'bl\t_$s17BenchmarkObserver7observe' in asm, 'Missing opaque observer call'
        checked(['swift', 'tools/generate-dense-128.swift', '--check', 'PrimeSieve.swift'])
        for name, files in [
            ('verify', ['PrimeSieve.swift', 'Verify.swift']),
            ('extra', ['PrimeSieve.swift', 'ExtraVerify.swift']),
            ('phase', ['PrimeSieve.swift', 'tools/phase-split/PhaseSieve.swift', 'tools/phase-split/PhaseVerify.swift'])
        ]:
            for config, flags in [('asan', ['-sanitize=address']), ('wmo', ['-whole-module-optimization'])]:
                binary = build / f'{name}-{config}'
                checked(['swiftc', '-O', *flags, *files, '-o', binary])
                checked([binary])
        assert git('rev-parse', 'HEAD').decode().strip() == candidate
        assert git('diff', 'HEAD', '--', 'experiments/swift').decode() == ''
        record['status'] = 'passed'
except BaseException as error:
    record['status'] = 'failed'; record['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    record['after'] = snapshot(); record['finished_at_utc'] = utc()
    record['lock_absent_after'] = not TimingLock.path.exists(); save()
