# Fork-only Linux and Docker validation

This workflow validates the committed Swift Dockerfile and existing correctness
checks on native Linux amd64 and arm64. It uses Docker already installed on the
GitHub-hosted `ubuntu-24.04` and `ubuntu-24.04-arm` runners; no Docker installation
on the Mac is needed. It does not publish images or measure a performance gain.

The workflow is `.github/workflows/swift-linux-docker-validation.yml`. It runs
only for pushes to `swift/linux-docker-validation` that change that workflow or
`validate.py`, and only in `fahlman/Primes`. Its two matrix jobs run serially,
with a 45-minute limit per architecture and read-only repository permissions.
The inherited broad CI jobs skip this fork branch and pull requests from its
head; other branches and the upstream repository retain their existing behavior.
Do not include these files or the inherited-CI guard in an upstream submission.

## Selecting exactly what is checked

`SOLUTION_REVISION` in the workflow is pinned to the selected 128-bit
wrapping-offset candidate, `bd3858cac9a306aa3b8d4729cf059959a7c70885`.
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

The build-stage image then compiles and runs Verify, ExtraVerify and PhaseVerify
under both `-O -sanitize=address` and `-O -whole-module-optimization`. The entire
source mount is read-only. A separate writable temporary mount contains only the
new check executables. Every compile and execution has a separate recorded exit
status and stdout/stderr log. A failing command stops that architecture's job;
the other architecture still runs. Failures are preserved and require diagnosis;
the script does not weaken checks, retry, or change the source automatically.

## Evidence and execution status

Each architecture uploads a 30-day artifact containing `validation.json`, image
IDs and command logs, including failure evidence when available. The record
identifies the workflow and solution commits, hashes, runner/compiler/Docker
metadata, base and built images, smoke output validation, every command and exit
status, and start/finish times. Compiled test executables are not uploaded.
Copy the completed artifacts and Actions run URLs into the fork's permanent
review/report record before artifact expiration.

Implementation and static review do not establish Linux support. No successful
execution is claimed until both native jobs complete and their evidence is
reviewed. Push the branch only after the authorized local timing sessions finish.
There is no manual-dispatch trigger or requirement to merge this workflow into
the default branch to run it.

References: [hosted runner labels](https://docs.github.com/en/actions/reference/runners/github-hosted-runners),
[amd64 image software](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md),
[arm64 image software](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Arm64-Readme.md),
and [push triggers on unmerged workflows](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#push).
