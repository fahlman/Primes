# Fork-only Linux and Docker validation

This workflow validates the committed Swift Dockerfile and existing correctness
checks on native Linux amd64 and arm64. It uses Docker already installed on the
GitHub-hosted `ubuntu-24.04` and `ubuntu-24.04-arm` runners; no Docker installation
on the Mac is needed. It does not publish images or measure a performance gain.

The workflow is `.github/workflows/swift-linux-docker-validation.yml`. It runs
only for pushes to `swift/linux-docker-validation` that change that workflow or
`validate.py`, and only in `fahlman/Primes`. The two native jobs run serially.
The current trigger requests the full six-check
suite on amd64 and arm64 for cutoff 111 before integrating PR #16. The job limit
is 60 minutes, providing room beyond the earlier 45-minute cutoff127 timeout;
individual command limits remain 20 minutes. Repository permissions are read-only.
Its unchanged concurrency group serializes
runs without cancelling an active run.
The inherited broad CI jobs skip this fork branch and pull requests from its
head; other branches and the upstream repository retain their existing behavior.
Do not include these files or the inherited-CI guard in an upstream submission.

The current cutoff111 [run34702902662](https://github.com/fahlman/Primes/actions/runs/34702902662) passed both native jobs, with all six checks and the unchanged Docker runtime on each. See [the exact-cutoff report](../../reports/Cutoff111LinuxValidation.md); prior cutoff127 evidence remains preserved separately.

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
An exclusive `/tmp/primes-timing.lock` protects this runner's work and is removed
in `finally`. An existing lock stops the job. It cannot synchronize with the Mac;
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
