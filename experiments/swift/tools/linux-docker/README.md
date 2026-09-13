# Fork-only Linux and Docker validation

The validator and its lifecycle tests are one Swift script,
`linux-validation.swift`, with the subcommands `validate` and `test-lifecycle`; it
runs on the runner host, whose Ubuntu images ship Swift 6.3.3. It is a port of the
earlier Python pair, keeping the same commands, checks, evidence record and
cleanup rules; the Python versions remain in Git history and in the evidence they
produced.

This workflow validates the committed Swift Dockerfile and existing correctness
checks on native Linux amd64 and arm64. It uses Docker already installed on the
GitHub-hosted `ubuntu-24.04` and `ubuntu-24.04-arm` runners; no Docker installation
on the Mac is needed. It does not publish images or measure a performance gain.

The workflow is `.github/workflows/swift-linux-docker-validation.yml`. It runs
only for pushes to `swift/linux-docker-validation` that change that workflow,
`linux-validation.swift`, and only in `fahlman/Primes`. The two native jobs run serially.
The current trigger requests the full six-check
suite on amd64 and arm64 for the adopted cutoff 111. The job limit
is 60 minutes, providing room beyond the earlier 45-minute cutoff127 timeout;
individual command limits remain 20 minutes. Repository permissions are read-only.
Its unchanged concurrency group serializes
runs without cancelling an active run.
The inherited broad CI jobs skip this fork branch and pull requests from its
head; other branches and the upstream repository retain their existing behavior.
Do not include these files or the inherited-CI guard in an upstream submission.

The cleanup-fix [run 34726948107](https://github.com/fahlman/Primes/actions/runs/34726948107) passed both native jobs, including all six Swift checks, the unchanged Docker runtime, 13 lifecycle tests and four real-Docker probes per architecture. See [the cleanup report and permanent evidence](../../reports/LinuxContainerCleanup.md). Earlier cutoff111 [run 34702902662](https://github.com/fahlman/Primes/actions/runs/34702902662) and its [exact-cutoff report](../../reports/Cutoff111LinuxValidation.md) remain unchanged; prior cutoff127 evidence is preserved separately.

## Selecting exactly what is checked

`SOLUTION_REVISION` in the workflow is pinned to the reviewed and timed cutoff111
candidate, `099e35afa8a2f01d79ef11f805d760e81d1d983a` (PR #16).
This selects the source for Linux validation; it does not adopt or merge it.
Change the pin explicitly when a different reviewed solution is selected.
The workflow and solution are checked out into
separate directories. The validator checks both revisions and requires a clean
solution checkout, then hashes the Dockerfile, sieve, runner, observer and every
verification source. All mounted test sources come from that same solution
commit. The solution files and Dockerfile are never rewritten by the validator.

The two official actions are pinned to commit SHAs. These refs were read from
their official GitHub repositories on 2026-09-12:

- `actions/checkout` v6: `d23441a48e516b6c34aea4fa41551a30e30af803`.
- `actions/upload-artifact` v7: `043fb46d1a93c77aae656e7c1c64a875d1fc6a0a`.

## One validation run

The script first verifies native runner and Docker-daemon architecture. It pulls
the Dockerfile's two versioned Swift 6.3.3 images once and records their immutable
repository digests. It builds both the existing `build` stage and final runtime
image with the unchanged Dockerfile and `--pull=false`. Plain build logs retain
the builder's base-image resolution; inspect records retain image IDs and digests.
An exclusive `/tmp/primes-timing.lock` protects this runner's work. It is removed
in `finally` only after owned-container cleanup is confirmed. An existing lock stops the job. It cannot synchronize with the Mac;
the root agent must still withhold the push until local timing is complete.

The final image runs once, with its normal entrypoint and no network. Success
requires one result line, a positive pass count, at least five seconds, one
thread, exact `algorithm=base,faithful=yes,bits=1` tags, and the runner's 78,498-prime
validation message. This five-second smoke run is compatibility evidence only.
Hosted hardware and its output must not be used for the project's M4 speed claims.

By default, the build-stage image compiles and runs Verify, ExtraVerify and
PhaseVerify under both `-O -sanitize=address` and `-O -whole-module-optimization`.
The optional `--checks` argument accepts one or more unique names from
`verify-asan`, `extra-verify-asan`, `phase-verify-asan`, `verify-wmo`,
`extra-verify-wmo`, and `phase-verify-wmo`. Omitting it retains all six checks.
The record lists requested, completed and unrequested checks, and explicitly
labels full-suite or targeted coverage. Full-suite success is `passed`;
targeted success is `passed_targeted` and does not establish unrequested checks.
Every selected run still builds the unchanged Dockerfile and validates its
runtime smoke output first. The entire source mount is read-only. A separate
writable temporary mount contains only the
new check executables. Every compile and execution has a separate recorded exit
status and stdout/stderr log. A failing command stops that architecture's job;
any other configured architecture still runs. Failures are preserved and require
diagnosis;
the script does not weaken checks, retry, or change the source automatically.

## Container lifetime and focused regression checks

Each container receives a unique invocation label and name. The validator creates
it first, verifies its full ID, name and ownership label, then starts that exact
ID with attached output. Successful validation also requires the inspected
container state to be stopped with exit code zero; Docker client success alone
does not establish command success. Normal completion, failure, timeout, SIGINT
and SIGTERM all enter cleanup. The client process group is stopped and reaped
before the owned container is force-removed and a successful daemon lookup
confirms its absence. No unrelated containers or images are removed.

Cleanup commands and inspected states are retained in `validation.json` and its
raw logs. SIGINT/SIGTERM received during cleanup are recorded and deferred so
they cannot abandon removal. An uncertain creation, failed inspection/removal or
failed client cleanup marks the run failed and retains its owned timing lock.
An uncertain create is never started. A later operator must establish that work
has stopped before removing a retained lock. SIGKILL or loss of the runner cannot
be handled by the validator; the lock is not deliberately released in those cases.
Historical evidence is unchanged, including the earlier cancelled run whose
record remained `running`.

The workflow first runs `linux-validation.swift test-lifecycle` with fake Docker
responses, real timed-out and interrupted processes, and a small real Docker probe. Unit coverage targets timeout/interruption, process cleanup,
container exit codes, failed cleanup and ownership. The explicit probe uses
`busybox:1.37.0`, records the inspected image identity, and checks normal exit,
nonzero exit, timeout and SIGTERM. The interrupted commands must emit a retained
start marker, establishing that their workload began, and every owned container
must be confirmed removed. The probe performs no Swift work, uses the same
exclusive timing lock, and writes separate evidence included in the existing
artifact upload. The unchanged six Swift checks then run once per native job.

For the fake-only tests, after acquiring the project timing lock, use:

```sh
swift experiments/swift/tools/linux-docker/linux-validation.swift test-lifecycle --output /tmp/new-lifecycle-test-evidence
```

The real probe requires Docker and an explicit `--docker-probe`; it acquires the
runner-local lock itself. At source `f6256fd862ddfdd85f8c02d191fbf84822310798`,
all 13 focused Python tests and syntax parsing passed under the exclusive lock
on the Mac; [local record](../../linux-cleanup-evidence/local-f6256fd/local-verification.json)
and [test log](../../linux-cleanup-evidence/local-f6256fd/unit-tests/unit-tests.log)
retain the commands, exits and source hashes. Docker was not installed locally.
The single native workflow run at `028125534a516a9adca0cd8f7419bd74d2b51975`
subsequently passed on amd64 and arm64. Each architecture passed the real probe,
all 13 unit tests and all six Swift checks; all 14 validation containers and four
probe containers were confirmed removed before lock release. The
[cleanup report](../../reports/LinuxContainerCleanup.md) links the original ZIPs,
raw logs, source hashes and audits. Prior successful Swift checks remain evidence
for their original exact revisions.

## Evidence and execution status

Each architecture uploads a 30-day artifact containing `validation.json`, image
IDs and command logs, including failure evidence when available. The record
identifies the workflow and solution commits, hashes, runner/compiler/Docker
metadata, base and built images, smoke output validation, every command and exit
status, and start/finish times. Compiled test executables are not uploaded.
Copy the completed artifacts and Actions run URLs into the fork's permanent
review/report record before artifact expiration.

The original run at workflow `dc5ef6aef662d37c9ae7495272b1b0b945929428`,
[34694761283](https://github.com/fahlman/Primes/actions/runs/34694761283), reached
the 45-minute amd64 job limit while compiling the last check, PhaseVerify WMO.
Its unchanged Dockerfile, runtime smoke, all three ASAN checks, Verify WMO and
ExtraVerify WMO had completed successfully. The original raw record remains
`running`, without a final command exit code or post-run source hashes, because
the job cancellation interrupted the process; the Actions job record establishes
the timeout. Its artifact and raw logs are preserved without modification.

The completed focused follow-up kept solution `bd3858c` and requested only
`--checks phase-verify-wmo` on native amd64. It rebuilt the same Dockerfile and
repeated the runtime smoke without rerunning the five completed checks. That
run retained the 20-minute per-command and 45-minute per-job limits.
[Run 34697204142](https://github.com/fahlman/Primes/actions/runs/34697204142),
workflow `5867ca7033d938c5977749fdf4f019e2696c6e2b`, completed successfully with
`passed_targeted`: only PhaseVerify WMO was requested and completed. Its source
hashes, compiler version and base-image IDs/digests match the original amd64
evidence. The original arm64 job also passed all six checks. Independent audits
confirm full six-check coverage on each native architecture for exact solution
`bd3858cac9a306aa3b8d4729cf059959a7c70885`, with amd64 coverage assembled across
the original five checks and the focused final check. The original timeout is
retained as a cancelled run. See the [complete report](../../reports/LinuxDockerValidation.md)
and [aggregate coverage record](../../linux-docker-validation/aggregate-coverage.json).

Implementation and static review do not establish Linux support. Full Linux
verification requires successful evidence for all six checks on each native
architecture, with matching source hashes for any split runs. Push the branch
only after the authorized local timing sessions finish.
There is no manual-dispatch trigger or requirement to merge this workflow into
the default branch to run it.

References: [hosted runner labels](https://docs.github.com/en/actions/reference/runners/github-hosted-runners),
[amd64 image software](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md),
[arm64 image software](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Arm64-Readme.md),
and [push triggers on unmerged workflows](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#push).
