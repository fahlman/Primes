# PR #15: Docker timeout and cancellation cleanup

The Docker cleanup fix passed local focused tests and the complete native amd64/arm64 validation in [run 34726948107](https://github.com/fahlman/Primes/actions/runs/34726948107). Both architectures passed all six Swift checks, the normal runtime smoke, 13 Python tests and four real-Docker lifecycle probes. This report establishes correctness, compatibility and the exercised cleanup behavior, with no performance result.

The workflow under review is `028125534a516a9adca0cd8f7419bd74d2b51975`; the implementation and tests were committed at `f6256fd862ddfdd85f8c02d191fbf84822310798`. Both native jobs validate unchanged cutoff-111 solution `099e35afa8a2f01d79ef11f805d760e81d1d983a`. The solution files, Dockerfile, benchmark, observer, existing verifiers, source/action pins and previous reports remain unchanged.

## Bug and fix

Previously, a timeout stopped the `docker run` client without establishing that its container had stopped. The validator could then release `/tmp/primes-timing.lock` while compilation or another owned workload continued inside Docker. Cancellation could also interrupt the script without recording a completed cleanup.

The validator now assigns each container a unique invocation label and name, creates it first, verifies its full ID, name and ownership label, and starts that exact ID with attached output. It inspects the container's own stopped state and exit code before accepting success; the client's exit status alone is insufficient.

Normal completion, failure, timeout, SIGINT and SIGTERM enter cleanup. On interruption, the validator terminates the client's process group and reaps the client before container cleanup. It verifies ownership, force-removes the owned container and confirms its absence by full ID once that ID is known. A renamed container cannot be mistaken for one that disappeared. No unrelated containers or images are removed.

If creation or cleanup remains unconfirmed, the run fails and retains its owned timing lock. An uncertain create is never started. Cleanup commands, inspected states, errors and lock disposition are recorded. Further SIGINT/SIGTERM signals during cleanup are recorded and deferred so they do not abandon removal.

## Local verification

At exact implementation `f6256fd862ddfdd85f8c02d191fbf84822310798`, Python syntax parsing and all **13 focused regression tests** passed under the exclusive timing lock. Both recorded commands exited zero, and the lock was released. Tests cover normal completion, timeout, interruption, partial logs and client reaping, failed cleanup or lookup, uncertain creation, unrelated ownership, renamed containers, lock-inode protection and a nonzero container exit despite client success.

Evidence is preserved in `experiments/swift/linux-cleanup-evidence/local-f6256fd/`, including `local-verification.json`, the test results/log and a SHA256 manifest. The local record's SHA256 is `fb2e2623ece71be81b9ab20af2d3e12e9fe4b39589682ef3ada31b953b4321ae`. Docker was not installed locally; no local Docker or Swift checks ran for this fix.

## Completed native validation

The existing native amd64/arm64 workflow adds a focused lifecycle step before its unchanged six-check Swift suite. Each architecture passed the 13 Python tests and a small `busybox:1.37.0` Docker probe: normal completion, rejection of exit code 7, timeout and SIGTERM handling. Both interrupted workloads emitted retained start markers before interruption; all four owned containers were confirmed removed and the probe lock released. Image identities and raw command logs are preserved.

Each full validation has `status=passed`, all six requested checks completed, no unrequested checks, and all 127 recorded commands exiting zero. Verify, ExtraVerify and PhaseVerify passed under both ASAN and WMO, with the expected raw passing output and empty execution stderr. The unchanged runtime image validated 78,498 primes after at least five seconds with exact `algorithm=base,faithful=yes,bits=1` tags and one thread. All 14 validation containers were confirmed removed before lock release.

| Architecture | Lifecycle probe and 13 tests | Full six-check suite and runtime smoke | Job duration | Original artifact |
|---|---|---|---|---|
| Native amd64 | Passed | Passed | 16m30s | `10308780568` |
| Native arm64 | Passed | Passed | 14m59s | `10308147054` |

The final API conclusion is `success`, attempt 1, at the exact workflow revision above. This was one serial two-architecture run; no Swift check or workflow was repeated. Swift 6.3.3 targets `x86_64-unknown-linux-gnu` and `aarch64-unknown-linux-gnu` respectively. Native host, Docker-daemon and image architectures agree. All eight solution-file hashes match the exact source before and after execution; all three workflow/tool hashes match the tested workflow commit. No hosted timing is used as speed evidence.

## Permanent evidence

Each original ZIP matches GitHub's advertised SHA256 digest. The collector retains the original ZIP, every extracted byte, job logs, API metadata, command logs and a separate derived audit. Archive validation rejects unsafe member paths and file types. The original successful and cancelled historical records remain unchanged.

- **amd64:** [job](https://github.com/fahlman/Primes/actions/runs/34726948107/job/103642628242), [validation](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/amd64-collection/amd64/artifact/swift-linux-docker-evidence/validation.json), [probe](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/amd64-collection/amd64/artifact/swift-linux-docker-lifecycle/docker-probe/probe.json), [ZIP](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/amd64-collection/amd64/artifact.zip), [audit](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/amd64-collection/amd64/audit.json). ZIP SHA256: `83de1e7306b1ec38864cc9903055d56dad97a7578b71bf571fb6691e5675d93e`.
- **arm64:** [job](https://github.com/fahlman/Primes/actions/runs/34726948107/job/103642628344), [validation](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/arm64-collection/arm64/artifact/swift-linux-docker-evidence/validation.json), [probe](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/arm64-collection/arm64/artifact/swift-linux-docker-lifecycle/docker-probe/probe.json), [ZIP](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/arm64-collection/arm64/artifact.zip), [audit](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/arm64-collection/arm64/audit.json). ZIP SHA256: `13f0656fff4115ebbe12a7133b5a4bac976e0a6303dc5134eafb79b4d26676e2`.

An independent Codex subagent reviewed the source fix and local evidence before the run, then separately audited both native artifacts with no blockers: [amd64 review](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/independent-amd64-audit.json), [arm64 review](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/independent-arm64-audit.json), [aggregate](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-cleanup-evidence/run-34726948107/aggregate.json). Each ZIP's 322 extracted files and each collection's 342 manifest entries matched. Crucially, the timeout and SIGTERM probes retained evidence that their containers were still running after the client exited; subsequent owned-container removal and full-ID absence checks established cleanup before lock release. Expected exit-7 and interruption errors remain recorded rather than relabelled as successes.

## Integration

Evidence was published at `a0bea49c699c53d6c3375fd1d9872e17d4b9a151`. After the completed checks and independent review, the user-authorized [PR #15](https://github.com/fahlman/Primes/pull/15) merged that exact head into `swift/dense-small-factors` with merge commit `f639c15f3fe7f837e775f9883c939db878133d23`. The branch is preserved. Production sieve, benchmark, observer, Dockerfile and existing verifiers match pre-merge development `3d996eb` byte for byte; the separately tested workflow and Python tools match `0281255`.

Publication and merge also triggered inherited all-language CI runs `34728508747` and `34728572690`; they were intentionally cancelled because that matrix enumerates `Prime*/Dockerfile` and does not test `experiments/swift`. The required dedicated Swift Linux run `34726948107` completed successfully and was not cancelled. The upstream submission remains paused.

## Limits

Python cannot handle SIGKILL or loss of the runner. In those cases it cannot guarantee a final evidence write or container removal, and it does not deliberately release its timing lock. A retained lock requires an operator to establish that owned work has stopped before removing it. The lock protects one runner, not other hosts.

The earlier cancelled run and all previous successful evidence remain preserved as recorded. These successful native checks establish correctness, compatibility and the exercised cleanup behavior for the exact revisions above. They do not establish a speedup, Linux benchmark ranking or immunity to every infrastructure failure.
