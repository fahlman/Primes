"""Check the merged generator/phase tools without running a timing campaign."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys
from datetime import datetime, timezone

root = Path(__file__).resolve().parents[1]
repo = root.parents[1]
evidence = Path(__file__).resolve().parent
sys.path.insert(0, str(root / 'current-phase-evidence'))
from primes_run_support import run

def git(revision, name):
    return subprocess.check_output(['git', '-C', str(repo), 'show', revision + ':experiments/swift/' + name])

def sha(data):
    return hashlib.sha256(data).hexdigest()

output = evidence / 'checks-2ee7b3a.json'
assert not output.exists()
build = root / '.build/maintenance-integration'
assert not build.exists()
source = (root / 'PrimeSieve.swift').read_bytes()
assert source == git('882b115', 'PrimeSieve.swift')
stripped = b''.join(line for line in source.splitlines(keepends=True)
                    if b'// BEGIN GENERATED DENSE 64' not in line and b'// END GENERATED DENSE 64' not in line)
assert stripped == git('1d05221', 'PrimeSieve.swift')
for name in ['Benchmark.swift', 'BenchmarkObserver.swift', 'Verify.swift', 'ExtraVerify.swift',
             'tools/phase-split/PhaseSieve.swift', 'tools/phase-split/PhaseVerify.swift',
             'tools/phase-split/PhaseBench.swift', 'tools/phase-split/CurrentPhaseVerify.swift',
             'tools/phase-split/GenerateCurrentPhaseSieve.swift', 'tools/phase-split/PhaseSourceGuard.swift']:
    assert (root / name).read_bytes() == git('0c605a4', name), name
record = {'revision': subprocess.check_output(['git', '-C', str(repo), 'rev-parse', 'HEAD'], text=True).strip(),
          'status': 'running', 'commands': [], 'source_sha256': sha(source),
          'source_without_markers_sha256': sha(stripped),
          'prior_full_verification_reused': 'Source/reference/tooling bytes unchanged from reviewed commits; no new timing or full verifier campaign.',
          'started_at_utc': datetime.now(timezone.utc).isoformat()}
lock = Path('/tmp/primes-timing.lock')
fd = os.open(lock, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
inode = os.fstat(fd).st_ino
with os.fdopen(fd, 'w') as handle:
    handle.write('Codex PR21/24 integration: fresh phase build and short check only\n')
try:
    root.joinpath('.build').mkdir(exist_ok=True)
    for command in [['sh', 'tools/phase-split/build-current.sh', str(build)],
                    [str(build / 'phase-current'), '--check']]:
        result = run(command, root)
        record['commands'].append(result)
        assert result['exit_code'] == 0
    derived = (build / 'inputs/CurrentPhaseSieve.swift').read_bytes()
    restored = b''.join(derived.splitlines(keepends=True)[3:])
    for new, old in [(b'final class CurrentPhaseSieve {', b'final class PrimeSieve {'),
                     (b'    func runSieve(throughFactor cap: Int = .max) {', b'    func runSieve() {'),
                     (b'        while p <= limit / p && p <= cap {', b'        while p <= limit / p {')]:
        assert restored.count(new) == 1
        restored = restored.replace(new, old)
    assert restored == source
    assert (root / 'PrimeSieve.swift').read_bytes() == source
    record.update(status='passed', exact_reverse_transformation=True,
                  source_identity=json.loads((build / 'inputs/source-identity.json').read_text()),
                  binary_sha256=sha((build / 'phase-current').read_bytes()))
except BaseException as error:
    record.update(status='failed', error=type(error).__name__ + ': ' + str(error))
    raise
finally:
    if lock.exists() and lock.stat().st_ino == inode:
        lock.unlink()
    record.update(lock_absent_after=not lock.exists(), finished_at_utc=datetime.now(timezone.utc).isoformat())
    output.write_text(json.dumps(record, indent=2) + '\n')
