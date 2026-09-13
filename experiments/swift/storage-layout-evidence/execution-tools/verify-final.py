"""One serial storage-layout maintenance verification; no benchmark execution."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

sys.path.insert(0, '/Users/ryan/Documents/Codex/2026-09-11/wa/work')
from primes_run_support import TimingLock, run, sha, snapshot, utc

REPO = Path('/Users/ryan/Developer/Primes-storage-layout')
BASE = '84d8a4fb0235ca4d5e8261a80877499e3b36b3ef'
CANDIDATE = '3d8477d3b171de164917184a74b0e1578907cefa'
ROOT = REPO / 'experiments/swift'
BUILD = ROOT / '.build/storage-layout-3d8477d'
EVIDENCE = ROOT / 'storage-layout-evidence/3d8477d'
PRIOR = ROOT / 'storage-layout-evidence/b992595-checks-2'
SWIFTC = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc'
FILES = ['PrimeSieve.swift', 'Benchmark.swift', 'BenchmarkObserver.swift', 'Verify.swift', 'ExtraVerify.swift']


def git(*args):
    return subprocess.check_output(['git', '-C', str(REPO), *args])


def functions(raw):
    result = {}
    for match in re.finditer(r'; -- Begin function ([^\n]+)', raw):
        end = raw.index('; -- End function', match.end())
        body = raw[match.end():end]
        # Only local compiler numbering is normalized. Keep block numbers,
        # instructions (including ret), operands, call targets and constant data.
        body = re.sub(r'\b(LBB|lCPI|lJTI)\d+_(\d+)\b', r'\1_\2', body)
        hints = {}
        body = re.sub(r'\bLloh\d+\b', lambda m: hints.setdefault(m[0], 'Lloh_' + str(len(hints))), body)
        result[match[1]] = '\n'.join(re.sub(r'\s+', ' ', line.split(';', 1)[0].strip())
                                    for line in body.splitlines() if line.split(';', 1)[0].strip())
    return result


def main():
    record = {'candidate': CANDIDATE, 'control': BASE, 'started_at_utc': utc(), 'status': 'running',
              'scope': 'Layout boundaries, Verify ASAN/WMO, ExtraVerify ASAN and actual-source assembly; no throughput timing.',
              'conditions_scope': 'Reject competing builds/tests/benchmarks; audio is recorded but does not invalidate correctness or assembly.',
              'commands': [], 'wrapper_sha256': sha(Path(__file__)),
              'support_sha256': sha(Path(__file__).resolve().parents[1] / 'primes_run_support.py')}
    owned = False
    def save():
        if owned:
            (EVIDENCE / 'verification.json').write_text(json.dumps(record, indent=2) + '\n')
    def checked(command, cwd=ROOT):
        result = run(list(map(str, command)), cwd)
        record['commands'].append(result)
        save()
        if result.get('exit_code') != 0 or 'error' in result:
            raise RuntimeError('Command failed; original evidence retained')
        return result['combined_stdout_stderr']
    try:
        if git('rev-parse', 'HEAD').decode().strip() != CANDIDATE or git('diff', 'HEAD', '--', 'experiments/swift'):
            raise RuntimeError('Candidate checkout is not the exact clean source revision')
        blobs = {label: {name: git('show', revision + ':experiments/swift/' + name) for name in FILES}
                 for label, revision in [('control', BASE), ('candidate', CANDIDATE)]}
        assert blobs['control']['PrimeSieve.swift'].split(b'    deinit {', 1)[1] == blobs['candidate']['PrimeSieve.swift'].split(b'    deinit {', 1)[1]
        assert blobs['control']['BenchmarkObserver.swift'] == blobs['candidate']['BenchmarkObserver.swift']
        assert blobs['control']['ExtraVerify.swift'] == blobs['candidate']['ExtraVerify.swift']
        record['source_sha256'] = {label: {name: hashlib.sha256(data).hexdigest() for name, data in files.items()}
                                   for label, files in blobs.items()}
        with TimingLock('Codex storage-layout 3d8477d serial assembly and correctness verification'):
            if BUILD.exists() or EVIDENCE.exists():
                raise RuntimeError('Preserve existing verification attempts')
            EVIDENCE.mkdir(parents=True)
            BUILD.mkdir(parents=True)
            owned = True
            record['exclusive_lock_before_compilation'] = True
            save()
            failed = False
            try:
                record['before'] = snapshot()
                if record['before']['competing_build_test_benchmark']:
                    raise RuntimeError('Competing build/test/benchmark activity')
                record['compiler_sha256'] = sha(Path(SWIFTC))
                checked([SWIFTC, '--version'])
                for label, files in blobs.items():
                    (BUILD / label).mkdir()
                    for name, data in files.items():
                        (BUILD / label / name).write_bytes(data)
                observer = BUILD / 'candidate/BenchmarkObserver.swift'
                checked([SWIFTC, '-O', '-parse-as-library', '-module-name', 'BenchmarkObserver', '-emit-module',
                         '-emit-module-path', BUILD / 'BenchmarkObserver.swiftmodule', '-emit-object', observer,
                         '-o', BUILD / 'BenchmarkObserver.o'])
                prior_record = json.loads((PRIOR / 'verification.json').read_text())
                assert prior_record['control'] == BASE
                assert prior_record['compiler_sha256'] == record['compiler_sha256']
                assert prior_record['source_sha256']['control'] == record['source_sha256']['control']
                assert prior_record['assembly_sha256']['control'] == sha(PRIOR / 'control.s')
                assert prior_record['status'] == 'passed_correctness_pending_assembly_review'
                record['reused_control_assembly'] = {
                    'record': str(PRIOR / 'verification.json'),
                    'record_sha256': sha(PRIOR / 'verification.json'),
                    'assembly_sha256': sha(PRIOR / 'control.s'),
                    'reason': 'Exact unchanged control source, real observer, compiler and flags already compiled in preserved prior session.'}
                (EVIDENCE / 'control.s').write_bytes((PRIOR / 'control.s').read_bytes())
                for label in ['candidate']:
                    checked([SWIFTC, '-O', '-whole-module-optimization', '-module-name', 'PrimeSwift', '-I', BUILD,
                             BUILD / label / 'PrimeSieve.swift', BUILD / label / 'Benchmark.swift', '-S',
                             '-o', EVIDENCE / (label + '.s')])
                inspected = checked(['/usr/bin/otool', '-tvV', BUILD / 'BenchmarkObserver.o'])
                (EVIDENCE / 'observer-disassembly.txt').write_text(inspected)
                parsed = {label: functions((EVIDENCE / (label + '.s')).read_text()) for label in blobs}
                names = sorted(set(parsed['control']) | set(parsed['candidate']))
                record['assembly_comparison'] = {
                    name: {'identical': parsed['control'].get(name) == parsed['candidate'].get(name),
                           'control_present': name in parsed['control'], 'candidate_present': name in parsed['candidate']}
                    for name in names}
                for label in blobs:
                    passes = [body for name, body in parsed[label].items() if '13completedPass' in name]
                    if len(passes) != 1 or 'bl _$s17BenchmarkObserver7observe' not in passes[0] or 'bl _swift_release' not in passes[0]:
                        raise RuntimeError('Actual completedPass lost its real observer/release boundary')
                record['assembly_sha256'] = {label: sha(EVIDENCE / (label + '.s')) for label in blobs}
                record['observer_object_sha256'] = sha(BUILD / 'BenchmarkObserver.o')
                save()
                if not all(item['identical'] for item in record['assembly_comparison'].values()):
                    raise RuntimeError('Assembly differs; stop before final-source correctness and report for review')
                record['assembly_identity_gate_passed'] = True
                save()
                for verifier, mode, flags in [('Verify', 'asan', ['-O', '-sanitize=address']),
                                               ('Verify', 'wmo', ['-O', '-whole-module-optimization']),
                                               ('ExtraVerify', 'asan', ['-O', '-sanitize=address'])]:
                    executable = BUILD / (verifier.lower() + '-' + mode)
                    checked([SWIFTC, *flags, BUILD / 'candidate/PrimeSieve.swift',
                             BUILD / 'candidate' / (verifier + '.swift'), '-o', executable])
                    checked([executable])
                for label, files in blobs.items():
                    for name, data in files.items():
                        if (BUILD / label / name).read_bytes() != data:
                            raise RuntimeError('Materialized source changed')
                if git('rev-parse', 'HEAD').decode().strip() != CANDIDATE or git('diff', 'HEAD', '--', 'experiments/swift'):
                    raise RuntimeError('Tracked source changed during verification')
                record['source_unchanged_after'] = True
                record['status'] = 'passed_correctness_and_assembly_identity'
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
            manifest = {str(path.relative_to(EVIDENCE)): sha(path) for path in sorted(EVIDENCE.rglob('*')) if path.is_file()}
            (EVIDENCE / 'sha256.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
