"""Two full-file generator checks for the accepted storage-layout integration."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
sys.path.insert(0, '/Users/ryan/Documents/Codex/2026-09-11/wa/work')
from primes_run_support import TimingLock, run, sha, snapshot, utc

REPO = Path('/Users/ryan/Developer/Primes-storage-layout')
ROOT = REPO / 'experiments/swift'
CANDIDATE = '5cbc25e1c41d55e1a48db4737721e589e046b08e'
AUTHORING = '5661fa4'
SWIFT = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift'
EVIDENCE = ROOT / 'storage-layout-evidence/template-integration'
VERIFY = ROOT / 'storage-layout-evidence/5cbc25e/verification.json'
FILES = ['PrimeSieve.swift', 'Benchmark.swift', 'BenchmarkObserver.swift', 'Verify.swift', 'ExtraVerify.swift',
         'tools/PrimeSieve.swift.in', 'tools/generate-dense.swift', 'tools/generate-dense-128.swift']


def git(*args):
    return subprocess.check_output(['git', '-C', str(REPO), *args])


def main():
    record = {'started_at_utc': utc(), 'status': 'running', 'source_candidate': CANDIDATE,
              'scope': 'Canonical and compatibility full-file check only; no sieve build, correctness rerun or benchmark.',
              'commands': [], 'wrapper_sha256': sha(Path(__file__))}
    owned = False
    def save():
        if owned:
            (EVIDENCE / 'verification.json').write_text(json.dumps(record, indent=2) + '\n')
    try:
        record['integration_head'] = git('rev-parse', 'HEAD').decode().strip()
        record['authoring_head'] = git('rev-parse', AUTHORING).decode().strip()
        git('merge-base', '--is-ancestor', CANDIDATE, 'HEAD')
        git('merge-base', '--is-ancestor', AUTHORING, 'HEAD')
        if git('diff', 'HEAD', '--', 'experiments/swift'):
            raise RuntimeError('Tracked integration changes are not committed')
        prior = json.loads(VERIFY.read_text())
        if prior['status'] != 'passed_correctness_and_assembly_identity' or not prior['existing_function_identity_gate_passed']:
            raise RuntimeError('Final source verification has not passed')
        record['prior_verification_sha256'] = sha(VERIFY)
        record['source_sha256_before'] = {name: sha(ROOT / name) for name in FILES}
        for name in FILES[:5]:
            if (ROOT / name).read_bytes() != git('show', CANDIDATE + ':experiments/swift/' + name):
                raise RuntimeError('Tested source or dependency changed in integration')
        with TimingLock('Codex accepted storage-layout integration: two full-file generator checks'):
            if EVIDENCE.exists():
                raise RuntimeError('Preserve earlier integration evidence')
            EVIDENCE.mkdir(parents=True)
            owned = True
            record['exclusive_lock_before_checks'] = True
            save()
            failed = False
            try:
                record['before'] = snapshot()
                if record['before']['competing_build_test_benchmark']:
                    raise RuntimeError('Competing build/test/benchmark activity')
                record['swift_driver_sha256'] = sha(Path(SWIFT))
                for tool in ['generate-dense.swift', 'generate-dense-128.swift']:
                    result = run([SWIFT, 'tools/' + tool, '--check', 'PrimeSieve.swift'], ROOT)
                    record['commands'].append(result)
                    save()
                    if result.get('exit_code') != 0 or 'error' in result:
                        raise RuntimeError('Generator check failed')
                    if 'Complete source and generated' not in result['combined_stdout_stderr']:
                        raise RuntimeError('Missing complete-file check confirmation')
                record['source_sha256_after'] = {name: sha(ROOT / name) for name in FILES}
                if record['source_sha256_after'] != record['source_sha256_before'] or git('diff', 'HEAD', '--', 'experiments/swift'):
                    raise RuntimeError('Integration source changed during checks')
                if git('rev-parse', 'HEAD').decode().strip() != record['integration_head']:
                    raise RuntimeError('Integration revision changed during checks')
                record['source_unchanged_after'] = True
                record['status'] = 'passed'
            except BaseException:
                failed = True
                raise
            finally:
                try:
                    record['after'] = snapshot()
                    if record['after']['competing_build_test_benchmark']:
                        raise RuntimeError('Competing build/test/benchmark activity')
                except BaseException as error:
                    record['post_conditions_error'] = f'{type(error).__name__}: {error}'
                    if not failed:
                        raise
                save()
    except BaseException as error:
        record.update(status='failed_or_requires_review', error=f'{type(error).__name__}: {error}')
        raise
    finally:
        if owned:
            record.update(finished_at_utc=utc(), lock_absent_after=not TimingLock.path.exists())
            save()
            (EVIDENCE / 'sha256.json').write_text(json.dumps({'verification.json': sha(EVIDENCE / 'verification.json')}, indent=2) + '\n')


if __name__ == '__main__':
    main()
