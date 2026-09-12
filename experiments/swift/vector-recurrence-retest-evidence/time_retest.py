"""One user-requested repeat of PR #25; no sieve or benchmark changes."""
from pathlib import Path
import hashlib
import json
import math
import subprocess
import sys
import threading

ROOT = Path(__file__).resolve().parents[1]
REPO = ROOT.parents[1]
EVIDENCE = Path(__file__).resolve().parent
PRIOR = ROOT / 'vector-recurrence-evidence'
sys.path.insert(0, str(PRIOR))
from primes_run_support import TimingLock, run, snapshot, check_conditions, utc

CANDIDATE = '616d0bdc184dd91c1dd30be0c7883f2880e057ce'
CONTROL = '1d0522115846d8c6487d49a9bf0e60b18b9d8599'
HARNESS = '25402d46ba991b39451724d3873d326626981e3f'
NAMES = {'control-111': CONTROL, 'vector-recurrence': CANDIDATE}
STAMP = utc().replace(':', '').replace('+0000', 'Z')
OUTPUT = EVIDENCE / ('timing-' + STAMP + '.json')
PROVENANCE = EVIDENCE / ('provenance-' + STAMP + '.json')
assert not OUTPUT.exists() and not PROVENANCE.exists()

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def git_source(revision, name):
    return subprocess.check_output(['git', '-C', str(REPO), 'show',
                                    revision + ':experiments/swift/' + name])

def backup_status():
    result = subprocess.run(['tmutil', 'status'], capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError('Unable to establish Time Machine status: ' + result.stderr)
    return result.stdout

def require_backup_idle(status):
    if 'Running = 0;' not in status:
        raise RuntimeError('Time Machine is active or its status is unrecognized')

verification = json.loads((PRIOR / 'verification-616d0bd.json').read_text())
admission = json.loads((PRIOR / 'review-admission-616d0bd.json').read_text())
assert verification['status'] == 'passed'
assert admission['candidate'] == CANDIDATE and admission['control'] == CONTROL
assert admission['admitted_for_timing'] is True
for key, revision in [('candidate', CANDIDATE), ('control', CONTROL)]:
    assert hashlib.sha256(git_source(revision, 'PrimeSieve.swift')).hexdigest() == verification[key + '_source_sha256']
assert (ROOT / 'compare_optimizations.py').read_bytes() == git_source(CONTROL, 'compare_optimizations.py')
assert subprocess.check_output(['git', '-C', str(REPO), 'rev-parse', 'swift/dense-small-factors'], text=True).strip() == CONTROL

record = {
    'status': 'running', 'started_at_utc': utc(),
    'candidate': CANDIDATE, 'control': CONTROL,
    'reason': 'User explicitly requested rerunning PR25 after discussing the original 2.04-times duration result. The original session had substantial backup/desktop activity before compilation; its exact impact is unknown.',
    'scope': 'One fresh six-run AB/BA/AB session; rebuild both; preserve both sessions separately; no source changes, pooled statistics, best-of selection or further repeat.',
    'review_reused': 'Exact inputs unchanged; prior correctness, source and assembly admission independently rechecked by Codex review agent before this repeat.',
    'prior_record_sha256': {name: sha(PRIOR / name) for name in [
        'verification-616d0bd.json', 'review-admission-616d0bd.json',
        'timing-616d0bd.json', 'timing-provenance-616d0bd.json', 'primes_run_support.py']},
    'wrapper_sha256': sha(Path(__file__).resolve()),
    'compare_script_sha256': sha(ROOT / 'compare_optimizations.py'),
    'monitor_interval_seconds': 5, 'monitor_samples': [],
    'monitor_limit': 'Periodic process/audio snapshots, not continuous tracing or proof that no human used the desktop. The same lightweight sampler spans both variants.',
}

def save():
    PROVENANCE.write_text(json.dumps(record, indent=2) + '\n')

stop = threading.Event()
monitor = None

def sample_conditions():
    while not stop.wait(5):
        try:
            sample = snapshot()
            sample['backup_status'] = backup_status()
            process_table = {}
            for line in subprocess.check_output(['ps', '-axo', 'pid=,ppid=,pgid=,comm='], text=True).splitlines():
                fields = line.strip().split(None, 3)
                if len(fields) == 4:
                    pid, ppid, pgid = map(int, fields[:3])
                    process_table[pid] = {'pid': pid, 'parent_pid': ppid, 'process_group': pgid, 'executable': Path(fields[3]).name}
            for process in sample['competing_build_test_benchmark']:
                ancestry = []
                pid = process['pid']
                while pid in process_table and pid not in {x['pid'] for x in ancestry}:
                    ancestor = process_table[pid]
                    ancestry.append(ancestor)
                    pid = ancestor['parent_pid']
                process['ancestry'] = ancestry
            record['monitor_samples'].append(sample)
        except Exception as error:
            record.setdefault('monitor_errors', []).append(str(error))

try:
    record['backup_before'] = backup_status()
    require_backup_idle(record['backup_before'])
    with TimingLock('Codex user-requested PR25 repeat: control111 vs vector recurrence; one six-run session'):
        record['before'] = snapshot()
        check_conditions(record['before'])
        record['swift_version'] = subprocess.check_output(['swiftc', '--version'], text=True).strip()
        assert record['swift_version'] == json.loads((PRIOR / 'timing-616d0bd.json').read_text())['swift_version']
        record['cpu'] = subprocess.check_output(['sysctl', '-n', 'machdep.cpu.brand_string'], text=True).strip()
        assert record['cpu'] == 'Apple M4 Pro'
        monitor = threading.Thread(target=sample_conditions, daemon=True)
        monitor.start()
        command = ['python3', str(ROOT / 'compare_optimizations.py'), '--repo', str(REPO)]
        for name, revision in NAMES.items():
            command.extend(['--variant', name + '=' + revision])
        command.extend(['--output', str(OUTPUT)])
        save()
        record['command'] = run(command, ROOT)
        stop.set()
        monitor.join()
        assert record['command']['exit_code'] == 0
        result = json.loads(OUTPUT.read_text())
        assert result['harness_revision'] == HARNESS
        assert result['swift_version'] == record['swift_version']
        assert result['flags'] == ['-O', '-whole-module-optimization']
        assert result['run_order'] == [['control-111', 'vector-recurrence'], ['vector-recurrence', 'control-111'], ['control-111', 'vector-recurrence']]
        for kind in ['runner', 'observer']:
            assert result[kind + '_sha256'] == verification[kind + '_sha256']
        record['binary_sha256'] = {}
        for name, revision in NAMES.items():
            assert result['variants'][name]['revision'] == revision
            expected = verification[('control' if name == 'control-111' else 'candidate') + '_source_sha256']
            assert result['variants'][name]['source_sha256'] == expected
            assert len(result['samples'][name]) == 3
            for item in result['samples'][name]:
                assert item['passes'] > 0 and math.isfinite(item['seconds']) and item['seconds'] >= 5
                assert item['threads'] == 1 and item['tags'] == 'algorithm=base,faithful=yes,bits=1'
                assert item['validation'].startswith('Validated: 78498 primes; checksum: ')
            record['binary_sha256'][name] = sha(ROOT / '.build/optimization-comparison' / name / 'benchmark')
        record['after'] = snapshot()
        record['backup_after'] = backup_status()
        record['result_sha256'] = sha(OUTPUT)
        check_conditions(record['after'])
        require_backup_idle(record['backup_after'])
        assert not record.get('monitor_errors'), 'Condition sampler failed'
        for sample in record['monitor_samples']:
            assert not sample['audio_assertions'], 'Audio activity sampled during session'
            require_backup_idle(sample['backup_status'])
            for process in sample['competing_build_test_benchmark']:
                assert record['command']['owned_process_group'] in {x['pid'] for x in process['ancestry']}, 'Unowned or unclassified build/test/benchmark sampled'
        record['sampled_conditions_passed'] = True
        record['status'] = 'passed'
except BaseException as error:
    record['status'] = 'failed'
    record['error'] = type(error).__name__ + ': ' + str(error)
    raise
finally:
    stop.set()
    if monitor is not None:
        monitor.join()
    record['finished_at_utc'] = utc()
    record['lock_absent_after'] = not TimingLock.path.exists()
    save()
    print('Provenance: ' + str(PROVENANCE), flush=True)
