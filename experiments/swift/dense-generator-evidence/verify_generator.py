from pathlib import Path
import hashlib, json, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, snapshot, utc

repo = Path('/Users/ryan/Developer/Primes-dense-generator')
root = repo / 'experiments/swift'
candidate = 'ce33c7d021f464b4740dcaa46d9ae5bbf2fb065b'
control = '1d0522115846d8c6487d49a9bf0e60b18b9d8599'
probe = Path('/Users/ryan/Developer/Primes-compact-dense-loops/experiments/swift')
build = root / '.build/generator-proof'; build.mkdir(parents=True, exist_ok=True)
evidence = root / 'dense-generator-evidence'; evidence.mkdir(exist_ok=True)
output = evidence / 'verification-ce33c7d.json'; assert not output.exists()
record = {'candidate': candidate, 'control': control, 'started_at_utc': utc(), 'commands': [], 'status': 'running'}

def save(): output.write_text(json.dumps(record, indent=2) + '\n')

def checked(command, success=True):
    r = run(list(map(str, command)), root); record['commands'].append(r); save()
    assert (r['exit_code'] == 0) == success, f'Unexpected exit: {command}'
    return r

try:
    assert subprocess.check_output(['git', '-C', str(repo), 'rev-parse', 'HEAD'], text=True).strip() == candidate
    source = (root / 'PrimeSieve.swift').read_bytes()
    old = subprocess.check_output(['git', '-C', str(repo), 'show', f'{control}:experiments/swift/PrimeSieve.swift'])
    stripped = source.replace(b'        // BEGIN GENERATED DENSE 64\n', b'').replace(b'        // END GENERATED DENSE 64\n', b'')
    assert stripped == old
    record['runtime_source_identity_after_removing_two_markers'] = True
    record['source_sha256'] = hashlib.sha256(source).hexdigest()
    record['before'] = snapshot()
    with TimingLock(f'Codex unified dense generator checks and unchanged assembly proof {candidate}'):
        checked(['swift', 'tools/generate-dense.swift', '--check', 'PrimeSieve.swift'])
        checked(['swift', 'tools/generate-dense-128.swift', '--check', 'PrimeSieve.swift'])
        for width, old_call, new_call in [(64, 'first: 1, step: 5', 'first: 2, step: 5'),
                                          (128, 'first: 2, step: 65', 'first: 3, step: 65')]:
            p = build / f'corrupt-{width}.swift'
            assert old_call.encode() in source
            p.write_bytes(source.replace(old_call.encode(), new_call.encode(), 1))
            checked(['swift', 'tools/generate-dense.swift', '--check', p], success=False)
            checked(['swift', 'tools/generate-dense.swift', '--write', p])
            assert p.read_bytes() == source, 'Regeneration failed or changed text outside markers'
        p = build / 'missing-marker.swift'
        broken = source.replace(b'        // END GENERATED DENSE 128\n', b'')
        p.write_bytes(broken)
        checked(['swift', 'tools/generate-dense.swift', '--write', p], success=False)
        assert p.read_bytes() == broken, 'Failed write modified the file'
        d = build / 'context'; d.mkdir(exist_ok=True)
        (d / 'PrimeSieve.swift').write_bytes(source)
        (d / 'Benchmark.swift').write_bytes((probe / '.build/compact-loop-probe/control/Benchmark.swift').read_bytes())
        assembly = evidence / 'generator-ce33c7d.s'
        checked(['swiftc', '-O', '-whole-module-optimization', '-module-name', 'PrimeSwift',
                 '-I', probe / '.build/compact-loop-probe', d / 'PrimeSieve.swift', d / 'Benchmark.swift',
                 '-S', '-o', assembly])
        previous = probe / 'compact-loop-evidence/control-1a259a8.s'
        record['control_assembly_sha256'] = hashlib.sha256(previous.read_bytes()).hexdigest()
        record['candidate_assembly_sha256'] = hashlib.sha256(assembly.read_bytes()).hexdigest()
        record['whole_assembly_byte_identical'] = assembly.read_bytes() == previous.read_bytes()
        assert record['whole_assembly_byte_identical'], 'Assembly differs; inspect before claiming equivalence'
        assert (root / 'PrimeSieve.swift').read_bytes() == source
        record['status'] = 'passed'
except BaseException as error:
    record['status'] = 'failed'; record['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    record['finished_at_utc'] = utc(); record['lock_absent_after'] = not TimingLock.path.exists(); save()
