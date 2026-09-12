from pathlib import Path
import hashlib, json, subprocess, sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from primes_run_support import TimingLock, run, snapshot, check_conditions, utc

repo = Path('/Users/ryan/Developer/Primes-compact-dense-loops')
root = repo / 'experiments/swift'
evidence = root / 'compact-loop-evidence'
candidate = '1a259a84a892cc1008de179ef332d66bd1c514bf'
control = '1d0522115846d8c6487d49a9bf0e60b18b9d8599'
output = evidence / 'timing-1a259a8.json'
provenance = evidence / 'timing-provenance-1a259a8.json'
assert not output.exists() and not provenance.exists()
verification = json.loads((evidence / 'verification-1a259a8.json').read_text())
assert verification['status'] == 'passed'
admission = json.loads((evidence / 'review-admission-1a259a8.json').read_text())
assert admission['candidate'] == candidate and admission['admitted_for_timing'] is True
record = {'candidate': candidate, 'control': control, 'started_at_utc': utc(),
          'status': 'running', 'verification_sha256': hashlib.sha256((evidence / 'verification-1a259a8.json').read_bytes()).hexdigest(),
          'review_admission_sha256': hashlib.sha256((evidence / 'review-admission-1a259a8.json').read_bytes()).hexdigest()}

def save(): provenance.write_text(json.dumps(record, indent=2) + '\n')

try:
    record['before'] = snapshot(); check_conditions(record['before'])
    with TimingLock(f'Codex compact loops vs adopted111: three rotated trials each; {candidate}'):
        command = ['python3', str(root / 'compare_optimizations.py'), '--repo', str(repo),
                   '--variant', 'control-111=' + control, '--variant', 'compact-loops=' + candidate,
                   '--output', str(output)]
        record['command'] = run(command, root); save()
        assert record['command']['exit_code'] == 0
        result = json.loads(output.read_text())
        assert result['variants']['compact-loops']['source_sha256'] == verification['candidate_source_sha256']
        assert result['variants']['control-111']['source_sha256'] == verification['control_source_sha256']
        record['binary_sha256'] = {}
        for name in result['variants']:
            binary = root / '.build/optimization-comparison' / name / 'benchmark'
            record['binary_sha256'][name] = hashlib.sha256(binary.read_bytes()).hexdigest()
        record['status'] = 'passed'
except BaseException as error:
    record['status'] = 'failed'; record['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    record['after'] = snapshot(); record['finished_at_utc'] = utc()
    record['lock_absent_after'] = not TimingLock.path.exists(); save()
