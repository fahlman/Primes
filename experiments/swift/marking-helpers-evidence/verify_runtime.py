from pathlib import Path
import argparse, hashlib, json, platform, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, snapshot, utc

p = argparse.ArgumentParser()
p.add_argument('--repo', type=Path, required=True)
p.add_argument('--candidate', required=True)
p.add_argument('--tag', required=True)
a = p.parse_args()
repo = a.repo.resolve(); root = repo / 'experiments/swift'
evidence = root / (a.tag + '-evidence'); evidence.mkdir(exist_ok=True)
build = root / '.build' / (a.tag + '-verify'); build.mkdir(parents=True, exist_ok=True)
output = evidence / ('verification-' + a.candidate[:7] + '.json')
assert not output.exists(), 'Preserve prior attempts'
control = '1d0522115846d8c6487d49a9bf0e60b18b9d8599'
harness = '25402d46ba991b39451724d3873d326626981e3f'
prior_root = Path('/Users/ryan/Developer/Primes-compact-dense-loops/experiments/swift/compact-loop-evidence')
prior = json.loads((prior_root / 'verification-1a259a8.json').read_text())
record = {'candidate': a.candidate, 'control': control, 'harness': harness,
          'started_at_utc': utc(), 'commands': [], 'status': 'running', 'platform': platform.platform(),
          'reused_control_assembly_evidence_commit': '8bb522faaed43acaeeacd168af898753dc481bb3'}

def git(*args): return subprocess.check_output(['git', '-C', str(repo), *args])
def sha(data): return hashlib.sha256(data).hexdigest()
def save(): output.write_text(json.dumps(record, indent=2) + '\n')
def checked(command, cwd=root):
    r = run(list(map(str, command)), cwd); record['commands'].append(r); save()
    assert r['exit_code'] == 0, f'Command failed: {command}'
    return r

try:
    assert git('rev-parse', 'HEAD').decode().strip() == a.candidate
    assert git('diff', 'HEAD', '--', 'experiments/swift') == b''
    tracked = git('ls-files', 'experiments/swift').decode().splitlines()
    selected = [f for f in tracked if f.endswith('.swift') and '/reports/' not in f]
    record['source_files'] = {f: sha((repo/f).read_bytes()) for f in selected}
    source = git('show', f'{a.candidate}:experiments/swift/PrimeSieve.swift')
    record['candidate_source_sha256'] = sha(source)
    control_source = git('show', f'{control}:experiments/swift/PrimeSieve.swift')
    assert sha(control_source) == prior['control_source_sha256']
    record['control_source_sha256'] = sha(control_source)
    record['before'] = snapshot()
    with TimingLock(f'Codex {a.tag} source/codegen/correctness {a.candidate}'):
        version = checked(['swiftc', '--version'])
        assert version['combined_stdout_stderr'] == prior['commands'][0]['combined_stdout_stderr'], 'Compiler changed; rebuild control'
        observer = git('show', f'{harness}:experiments/swift/BenchmarkObserver.swift')
        runner = git('show', f'{harness}:experiments/swift/Benchmark.swift')
        record['runner_sha256'] = sha(runner); record['observer_sha256'] = sha(observer)
        assert record['runner_sha256'] == prior['runner_sha256']
        assert record['observer_sha256'] == prior['observer_sha256']
        (build/'BenchmarkObserver.swift').write_bytes(observer)
        (build/'PrimeSieve.swift').write_bytes(source)
        (build/'Benchmark.swift').write_bytes(runner)
        checked(['swiftc', '-O', '-parse-as-library', '-module-name', 'BenchmarkObserver',
                 '-emit-module', '-emit-module-path', build/'BenchmarkObserver.swiftmodule',
                 '-emit-object', build/'BenchmarkObserver.swift', '-o', build/'BenchmarkObserver.o'])
        assembly = evidence / ('candidate-' + a.candidate[:7] + '.s')
        checked(['swiftc', '-O', '-whole-module-optimization', '-module-name', 'PrimeSwift', '-I', build,
                 build/'PrimeSieve.swift', build/'Benchmark.swift', '-S', '-o', assembly])
        asm = assembly.read_bytes(); old = (prior_root/'control-1a259a8.s').read_bytes()
        assert sha(old) == '8a8ec1e81bf8f5095e4d09b65b5e8ecfaf407f253b90cdeb6264ec8d5c8ffe8f'
        assert b'bl\t_$s17BenchmarkObserver7observe' in asm, 'Missing opaque observer call'
        record['assembly_sha256'] = sha(asm); record['control_assembly_sha256'] = sha(old)
        record['whole_assembly_byte_identical'] = asm == old
        checked(['swift', 'tools/generate-dense-128.swift', '--check', 'PrimeSieve.swift'])
        for name, files in [
            ('verify', ['PrimeSieve.swift','Verify.swift']),
            ('extra', ['PrimeSieve.swift','ExtraVerify.swift']),
            ('phase', ['PrimeSieve.swift','tools/phase-split/PhaseSieve.swift','tools/phase-split/PhaseVerify.swift'])
        ]:
            for config, flags in [('asan',['-sanitize=address']),('wmo',['-whole-module-optimization'])]:
                binary = build/(name+'-'+config)
                checked(['swiftc','-O',*flags,*files,'-o',binary]); checked([binary])
        assert git('rev-parse','HEAD').decode().strip() == a.candidate
        assert git('diff','HEAD','--','experiments/swift') == b''
        assert record['source_files'] == {f:sha((repo/f).read_bytes()) for f in selected}
        record['status'] = 'passed'
except BaseException as error:
    record['status']='failed';record['error']=f'{type(error).__name__}: {error}';raise
finally:
    record['after']=snapshot();record['finished_at_utc']=utc()
    record['lock_absent_after']=not TimingLock.path.exists();save()
