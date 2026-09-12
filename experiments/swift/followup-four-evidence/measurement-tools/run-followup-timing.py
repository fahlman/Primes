"""Run one already-reviewed, fixed comparison; no source/harness modifications."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys
from primes_run_support import TimingLock, check_conditions, run, sha, snapshot, utc

pkg = Path('/Users/ryan/Developer/Primes-followup-four-review/experiments/swift')
repo = pkg.parent.parent
review_path = pkg / 'followup-four-review.json'
review = json.loads(review_path.read_text())
sessions = {
    'cutoff-sweep': [('development63', 'f6b5c5b'), ('cutoff79', '7f26170'),
                     ('cutoff95', '2dc1d42'), ('cutoff111', '099e35a'), ('cutoff127', 'bd3858c')],
    'sparse-discovery-atomic': [('baseline127', 'bd3858c'), ('sparse32', 'af83aa1'),
                              ('discovery', '76d82c2'), ('atomic', 'e889cd6')],
}
assert len(sys.argv) in (2, 3) and sys.argv[1] in sessions, 'Specify one registered session and optional attempt label'
session = sys.argv[1]
attempt = sys.argv[2] if len(sys.argv) == 3 else 'initial'
assert attempt and all(c in 'abcdefghijklmnopqrstuvwxyz0123456789-' for c in attempt)
suffix = '' if attempt == 'initial' else '-' + attempt
variants = sessions[session]
assert review['status'] == 'source_review_complete'
for item in review['variants']:
    assert item['source_review'] == 'admitted' and not item['blocking_findings']
    assert not item['targeted_correctness_check_required']
    assert item['prior_correctness'] == 'reported_pass'
    assert item['pre_timing_review_comment'].startswith('https://github.com/fahlman/Primes/pull/')
    blob = subprocess.check_output(['git', 'show', item['revision'] + ':experiments/swift/PrimeSieve.swift'], cwd=repo)
    assert hashlib.sha256(blob).hexdigest() == item['source_sha256']

head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=repo, text=True).strip()
assert head == '4f6862f5aa1bf5af7183e88fc88baee80a5451a1'
expected = subprocess.check_output(['git', 'show', head + ':experiments/swift/compare_optimizations.py'], cwd=repo)
assert (pkg / 'compare_optimizations.py').read_bytes() == expected
resolved = [(name, subprocess.check_output(['git', 'rev-parse', rev + '^{commit}'], cwd=repo, text=True).strip())
            for name, rev in variants]
approved_revisions = {item['name']: item['revision'] for item in review['variants']}
approved_revisions.update(development63='f6b5c5b794de7c040c85ab3d88ca524961525f27',
                          cutoff127='bd3858cac9a306aa3b8d4729cf059959a7c70885',
                          baseline127='bd3858cac9a306aa3b8d4729cf059959a7c70885')
assert all(revision == approved_revisions[name] for name, revision in resolved)
compiler = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc'
shim = Path(__file__).parent / 'compiler-timing-bin' / 'swiftc'
assert shim.is_file() and os.access(shim, os.X_OK)
out = pkg / (session + '-results-20260912' + suffix + '.json')
record = pkg / (session + '-execution-20260912' + suffix + '.json')
compiler_log = pkg / (session + '-compiler-20260912' + suffix + '.jsonl')
assert all(not p.exists() for p in (out, record, compiler_log)), 'Preserve existing evidence'
entry = {'session': session, 'attempt': attempt, 'started_at_utc': utc(), 'review_record_sha256': sha(review_path),
         'review_record': review_path.name, 'variants': dict(resolved),
         'unique_output': out.name, 'compiler_log': compiler_log.name,
         'harness_sha256': sha(pkg / 'compare_optimizations.py'),
         'wrapper_sha256': sha(__file__), 'shim_sha256': sha(shim),
         'support_sha256': sha(Path(__file__).parent / 'primes_run_support.py'),
         'conditions_scope': 'Snapshots before compilation and after comparison; no continuous monitoring.',
         'exclusive_lock_before_compilation': True}
owned_record = False
try:
    with TimingLock('Codex PR16-19 ' + session + ': compile then three rotated five-second rounds; unique output.'):
        assert all(not p.exists() for p in (out, record, compiler_log)), 'Preserve existing evidence'
        with record.open('x') as f:
            f.write(json.dumps(dict(entry, status='reserved')) + '\n')
        owned_record = True
        command_failed = False
        try:
            entry['before'] = snapshot()
            check_conditions(entry['before'])
            version = subprocess.check_output([compiler, '--version'], text=True).strip()
            assert 'Swift version 6.3.3' in version and 'arm64-apple-macosx' in version, version
            entry['swift_version_before'] = version
            command = [sys.executable, '-u', 'compare_optimizations.py']
            for name, revision in resolved:
                command += ['--variant', name + '=' + revision]
            command += ['--output', str(out)]
            os.environ['PRIMES_REAL_SWIFTC'] = compiler
            os.environ['PRIMES_COMPILER_LOG'] = str(compiler_log)
            os.environ['PATH'] = str(shim.parent) + os.pathsep + os.environ['PATH']
            entry['command'] = run(command, pkg)
            if out.exists():
                entry['raw_sha256'] = sha(out)
            assert entry['command']['exit_code'] == 0 and 'error' not in entry['command']
            assert (pkg / 'compare_optimizations.py').read_bytes() == expected
            assert sha(review_path) == entry['review_record_sha256']
            entry['executable_sha256'] = {name: sha(pkg / '.build/optimization-comparison' / name / 'benchmark')
                                          for name, revision in resolved}
            entry['compiler_log_sha256'] = sha(compiler_log)
            entry['status'] = 'completed'
        except BaseException:
            command_failed = True
            raise
        finally:
            try:
                entry['after'] = snapshot()
                check_conditions(entry['after'])
            except BaseException as error:
                entry['post_conditions_error'] = type(error).__name__ + ': ' + str(error)
                if not command_failed:
                    raise
except BaseException as error:
    entry.update(status='failed_or_requires_condition_review', error=type(error).__name__ + ': ' + str(error))
    raise
finally:
    if owned_record:
        entry.update(finished_at_utc=utc(), lock_absent_after=not TimingLock.path.exists())
        record.write_text(json.dumps(entry, indent=2) + '\n')
