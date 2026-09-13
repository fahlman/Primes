"""Focused package validation; run only after the root grants the exclusive window."""
from pathlib import Path
import argparse
import contextlib
import hashlib
import json
import math
import os
import re
import shutil
import subprocess

from primes_run_support import TimingLock, run, sha, snapshot, utc

HERE = Path(__file__).resolve().parent
REPO = Path('/Users/ryan/Developer/Primes-submission-cli-refactor')
PACKAGE = REPO / 'PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8'
REVISION = 'b826fc6af66835d67494c7d0646fc7d596a2ccc8'
STORAGE = '5cbc25e1c41d55e1a48db4737721e589e046b08e'
BASE = '890909588f311f9314933d0517e07416310a7c7b'
BASE_RECORD = Path('/Users/ryan/Developer/Primes-swift-submission-review/experiments/swift/submission-evidence/local-verify-8909095.json')
BASE_BINARY = Path('/Users/ryan/Developer/Primes-swift-submission/PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8/.build/release/PrimeSieveSwift')
SOURCE_PROOF = HERE / 'integration-source-proof-b826fc6.json'
PROBE = HERE / 'DurationProbe.swift'
ROW_LABEL = 'yellowcub_striped_UInt8'
SMALL_LISTS = {0: '', 2: '', 3: '2', 7: '2, 3, 5',
               31: '2, 3, 5, 7, 11, 13, 17, 19, 23, 29'}


def git(*args):
    return subprocess.check_output(['git', *args], cwd=REPO)


def check_package_conditions(conditions):
    # This is a correctness/assembly run. Audio remains recorded but is not a
    # correctness gate; only competing compiler/test/benchmark work is rejected.
    assert not conditions['competing_build_test_benchmark'], 'Competing build/test/benchmark observed'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True,
                        help='New directory under this evidence folder; never overwritten.')
    parser.add_argument('--execute', action='store_true', required=True,
                        help='Use only after the root explicitly grants this build/test window.')
    args = parser.parse_args()
    output = args.output.resolve()
    assert output.parent == HERE, 'Keep all evidence in work/submission-cli-refactor'
    output.mkdir(exist_ok=False)
    record_path = output / 'verification.json'
    entry = {
        'status': 'in_progress', 'started_at_utc': utc(),
        'source_revision': REVISION, 'storage_reference_revision': STORAGE,
        'submission_base_revision': BASE,
        'scope': 'Actual striped release/ASan package, focused CLI regression, 19 direct conversion probes, canonical/shim integration and actual-binary observer/release gate. No throughput comparison or standalone full-sieve suite rerun.',
        'conditions_scope': 'Correctness/assembly only: reject competing builds/tests/benchmarks; record audio and other process activity without treating them as performance or correctness failures.',
        'reused_core_evidence': 'Final storage5cbc25e correctness/assembly record is supplied separately by root; package core and Verify.swift identities are checked here.',
        'commands': [], 'cli_checks': {}, 'generator_checks': {},
    }

    def save():
        record_path.write_text(json.dumps(entry, indent=2) + '\n')

    def command(label, argv, expected=0, cwd=PACKAGE):
        with open(os.devnull, 'w') as sink, contextlib.redirect_stdout(sink):
            result = run([str(value) for value in argv], cwd)
        text = result.pop('combined_stdout_stderr')
        log = output / f'{len(entry["commands"]) + 1:02d}-{label}.log'
        log.write_text(text)
        result.update(label=label, expected_exit_code=expected,
                      output_log=log.name, output_sha256=sha(log))
        entry['commands'].append(result)
        save()
        print(f'{label}: exit {result["exit_code"]} (expected {expected})', flush=True)
        assert 'error' not in result and result['exit_code'] == expected, label
        return text

    def cli_result(text, limit, expect_list=True):
        lines = text.splitlines()
        rows = [line.split(';') for line in lines if line.startswith(ROW_LABEL + ';')]
        assert len(rows) == 1, 'Expected one benchmark record'
        row = rows[0]
        assert len(row) == 5 and int(row[1]) == 1
        assert math.isfinite(float(row[2])) and float(row[2]) >= 0
        assert row[3:] == ['1', 'algorithm=base,faithful=yes,bits=1']
        diagnostic_indexes = [i for i, line in enumerate(lines) if line.startswith('Passes: ')]
        assert len(diagnostic_indexes) == 1
        index = diagnostic_indexes[0]
        count = 78_498 if limit == 1_000_000 else len(SMALL_LISTS[limit].split(', ')) if SMALL_LISTS[limit] else 0
        valid = 'true' if limit == 1_000_000 else 'unknown'
        assert f'Limit: {limit}, Count: {count}, Valid: {valid},' in lines[index]
        if not expect_list:
            return None
        assert index > 0, 'Missing list line, including the empty-list newline'
        listing = lines[index - 1]
        if limit in SMALL_LISTS:
            assert listing == SMALL_LISTS[limit], (limit, listing)
        else:
            fields = listing.split(', ')
            assert len(fields) == 78_498 and fields[0] == '2' and fields[-1] == '999983'
        return listing

    def verify_cli(binary, label, reference_list):
        for index, limit in enumerate([0, 2, 3, 7, 31, 1_000_000]):
            switches = (['--upper-limit', str(limit), '--time', '0', '--list-results', 'true']
                        if index % 2 == 0 else ['-n', str(limit), '-t', '0', '-l', 'true'])
            listing = cli_result(command(f'{label}-limit-{limit}', [binary, *switches]), limit)
            if limit == 1_000_000:
                assert listing == reference_list, 'Complete 1M CLI list differs from verified8909095'
        for index, switches in enumerate([
            ['--upper-limit=-1'], ['--time=-1'], ['--time=nan'],
            ['--time=inf'], ['--time=-inf'], ['--time=1e100'],
        ]):
            text = command(f'{label}-invalid-{index}', [binary, *switches], expected=64)
            assert ROW_LABEL + ';' not in text
            expected_error = ('The upper limit must be nonnegative.' if index == 0 else
                              'Time must be finite, nonnegative, and representable in nanoseconds.')
            assert expected_error in text
        for index, seconds in enumerate(['1e-10', '1.5e-9']):
            cli_result(command(f'{label}-fractional-{index}',
                               [binary, '-n', '31', '-t', seconds, '-l', 'true']), 31)
        entry['cli_checks'][label] = {'status': 'passed', 'cases': 14,
                                     'limits': [0, 2, 3, 7, 31, 1_000_000],
                                     'complete_1m_list_equals_verified_base': True}
        save()

    try:
        assert git('rev-parse', 'HEAD').decode().strip() == REVISION
        assert git('status', '--porcelain') == b'', 'Source worktree must be clean'
        files = git('ls-files', 'PrimeSwift/solution_1').decode().splitlines()
        manifest = {path: sha(REPO / path) for path in files}
        assert all((REPO / path).read_bytes() == git('show', REVISION + ':' + path) for path in files)
        source_proof = json.loads(SOURCE_PROOF.read_text())
        assert source_proof['source_revision'] == REVISION and all(source_proof['checks'].values())
        assert all(sha(REPO / path) == digest for path, digest in source_proof['source_sha256'].items())
        base_record = json.loads(BASE_RECORD.read_text())
        assert base_record['source_revision'] == BASE and base_record['status'] == 'passed'
        assert sha(BASE_BINARY) == base_record['release_binary_sha256']
        entry.update(source_sha256=manifest, wrapper_sha256=sha(__file__),
                     support_sha256=sha(HERE / 'primes_run_support.py'),
                     probe_source_sha256=sha(PROBE), source_proof_sha256=sha(SOURCE_PROOF),
                     base_record_sha256=sha(BASE_RECORD), base_binary_sha256=sha(BASE_BINARY))
        for name in ['verify_package.py', 'primes_run_support.py', 'DurationProbe.swift',
                     'integration-source-proof-b826fc6.json']:
            shutil.copyfile(HERE / name, output / name)
        save()
        with TimingLock('Codex package b826fc6: serial focused release/ASan CLI and generator checks; no throughput conclusions.'):
            entry['before'] = snapshot()
            save()
            check_package_conditions(entry['before'])
            try:
                version = command('swift-version', ['swiftc', '--version'])
                prior_version = next(item['combined_stdout_stderr'] for item in base_record['commands']
                                     if item['command'] == ['swiftc', '--version'])
                assert version == prior_version, 'Compiler differs from verified submission base'
                entry['compiler_version'] = version
                source = PACKAGE / 'Sources/PrimeSieveSwift/PrimeSieve.swift'
                template = PACKAGE / 'Tools/PrimeSieve.swift.in'
                for tool_name, label in [('generate-dense.swift', 'canonical'),
                                         ('generate-dense-128.swift', 'shim')]:
                    tool = PACKAGE / 'Tools' / tool_name
                    command(label + '-check', ['swift', tool, '--check', source])
                    copied = output / (label + '-output.swift')
                    shutil.copyfile(source, copied)
                    command(label + '-write-copy', ['swift', tool, '--write', copied, '--template', template])
                    assert copied.read_bytes() == source.read_bytes()
                    command(label + '-check-copy', ['swift', tool, '--check', copied])
                    entry['generator_checks'][label] = {'status': 'passed', 'output_sha256': sha(copied)}
                reference_list = cli_result(command('base-list-1m',
                    [BASE_BINARY, '-n', '1000000', '-t', '0', '-l', 'true']), 1_000_000)
                entry['base_1m_list_sha256'] = hashlib.sha256(reference_list.encode()).hexdigest()
                command('release-build', ['swift', 'build', '-v', '--configuration', 'release',
                    '-Xswiftc', '-O', '-Xswiftc', '-whole-module-optimization', '--package-path', PACKAGE])
                release_dir = PACKAGE / '.build/release'
                binary = release_dir / 'PrimeSieveSwift'
                entry['release_binary_sha256'] = sha(binary)
                verify_cli(binary, 'release', reference_list)

                assembly = command('release-disassembly', ['otool', '-tvV', binary])
                symbol = '_$s15PrimeSieveSwift13completedPass5limit6offsets6UInt64VSi_SitF:'
                lines = assembly.splitlines()
                start = lines.index(symbol)
                end = next((i for i in range(start + 1, len(lines)) if lines[i].startswith('_') and lines[i].endswith(':')), len(lines))
                body = '\n'.join(lines[start:end]) + '\n'
                checks = {
                    'initializer_call': bool(re.search(r'\bbl\s+_\$s15PrimeSieveSwift0aB0C5limit', body)),
                    'run_sieve_call': bool(re.search(r'\bbl\s+_\$s15PrimeSieveSwift0aB0C03runB0yyF', body)),
                    'opaque_observer_call': bool(re.search(r'\bbl\s+_\$s17BenchmarkObserver7observe', body)),
                    'release_call': bool(re.search(r'\bbl\s+[^\n]*_swift_release', body)),
                }
                (output / 'completedPass.txt').write_text(body)
                entry['actual_binary_gate'] = {'checks': checks,
                    'completedPass_sha256': sha(output / 'completedPass.txt'),
                    'scope': 'Required calls in the actual packaged completedPass; not a whole-binary assembly-identity or throughput claim.'}
                save()
                assert all(checks.values()), 'Actual packaged pass boundary needs review'

                objects = sorted(release_dir.glob('ArgumentParser*.build/*.o'))
                assert objects and (release_dir / 'Modules/ArgumentParser.swiftmodule').exists()
                probe_binary = output / 'duration-probe'
                entry['duration_probe_object_sha256'] = {str(path): sha(path) for path in objects}
                command('duration-probe-build', ['swiftc', '-O', '-whole-module-optimization',
                    '-I', release_dir / 'Modules', PACKAGE / 'Sources/PrimeSieveSwift/BenchmarkDuration.swift',
                    PROBE, *objects, '-o', probe_binary])
                probe_text = command('duration-probe', [probe_binary])
                assert 'Duration conversion passed 19 probes.' in probe_text
                entry['duration_probe'] = {'status': 'passed', 'cases': 19, 'binary_sha256': sha(probe_binary)}
                command('asan-build', ['swift', 'build', '-v', '--configuration', 'release',
                    '--sanitize', 'address', '--scratch-path', PACKAGE / '.build/asan',
                    '-Xswiftc', '-O', '-Xswiftc', '-whole-module-optimization', '--package-path', PACKAGE])
                asan_binary = PACKAGE / '.build/asan/release/PrimeSieveSwift'
                entry['asan_binary_sha256'] = sha(asan_binary)
                verify_cli(asan_binary, 'asan', reference_list)
                entry['source_sha256_after'] = {path: sha(REPO / path) for path in files}
                assert entry['source_sha256_after'] == manifest
                assert git('rev-parse', 'HEAD').decode().strip() == REVISION
                assert git('status', '--porcelain') == b'', 'Build changed tracked or untracked source'
                assert sha(BASE_BINARY) == entry['base_binary_sha256']
                assert sha(BASE_RECORD) == entry['base_record_sha256']
                entry['completed_checks'] = 'Canonical/shim source and write-copy identity; two package builds; 28 focused CLI cases; 19 direct conversion probes; actual packaged initializer/sieve/observer/release calls.'
            finally:
                entry['after'] = snapshot()
                save()
                check_package_conditions(entry['after'])
        entry['status'] = 'passed'
    except BaseException as error:
        entry.update(status='failed_or_requires_review', error=type(error).__name__ + ': ' + str(error))
        raise
    finally:
        entry.update(finished_at_utc=utc(), lock_absent_after=not TimingLock.path.exists())
        save()


if __name__ == '__main__':
    main()
