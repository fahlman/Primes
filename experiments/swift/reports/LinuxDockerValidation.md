# Native Linux and Docker validation

Validation is in progress. The original native amd64 job built and ran the
unchanged Docker image and passed five correctness checks, but its 45-minute
limit interrupted compilation of the final PhaseVerify WMO check. The original
arm64 job is still running. One reviewed follow-up requests only the missing
amd64 check. No complete Linux validation or Linux performance gain is claimed.

The solution is exactly `bd3858cac9a306aa3b8d4729cf059959a7c70885`, the 128-bit
wrapping-offset candidate in [PR #14](https://github.com/fahlman/Primes/pull/14).
The validation workflow is fork-only [PR #15](https://github.com/fahlman/Primes/pull/15).
This report does not adopt or merge either PR.

| Run | Workflow revision | Scope | Recorded result |
|---|---|---|---|
| [34694761283](https://github.com/fahlman/Primes/actions/runs/34694761283) | `dc5ef6aef662d37c9ae7495272b1b0b945929428` | Native amd64 and arm64, six checks each, serial | amd64 timed out during final compile; arm64 running |
| [34697204142](https://github.com/fahlman/Primes/actions/runs/34697204142) | `5867ca7033d938c5977749fdf4f019e2696c6e2b` | Native amd64, PhaseVerify WMO only | Pending behind original run |

The target checkout is separate from the workflow checkout. The Dockerfile,
sieve, runner, observer and verification sources all come from the same pinned
solution commit. Tests use a read-only source mount, a separate writable build
directory and the compiler stage of the unchanged Dockerfile. Every selected
run builds the image, checks native host/daemon/image architecture and Swift
6.3.3, and validates a normal runtime smoke before its requested checks. The
45-minute job and 20-minute command limits are unchanged in the focused follow-up.

## Original amd64 evidence

[Job 103556227050](https://github.com/fahlman/Primes/actions/runs/34694761283/job/103556227050)
ran from 12:50:17 to 13:35:34 UTC on 2026-09-12 and ended `cancelled` because of
the 45-minute job cap. GitHub's preserved [check-run annotation](../linux-docker-validation/run-34694761283/github/check-run-103556227050-annotations.json)
explicitly states, "The job has exceeded the maximum execution time of 45m0s".
The native runner exposed four x86_64 CPUs, identified as
AMD EPYC 9V74, on the `ubuntu-24.04` image `20260907.300.1`. The container reported
Swift 6.3.3 (`swift-6.3.3-RELEASE`), target `x86_64-unknown-linux-gnu`.

| Command | Elapsed seconds | Result |
|---|---:|---|
| Docker compiler-stage build, including benchmark compilation | 474.428 | Exit 0 |
| Docker final-runtime build | 0.415 | Exit 0; compiler stage cached |
| Verify ASAN compile / run | 315.926 / 0.365 | Both exit 0 |
| ExtraVerify ASAN compile / run | 333.677 / 9.489 | Both exit 0 |
| PhaseVerify ASAN compile / run | 481.111 / 3.523 | Both exit 0 |
| Verify WMO compile / run | 379.034 / 0.266 | Both exit 0 |
| ExtraVerify WMO compile / run | 339.053 / 3.775 | Both exit 0 |
| PhaseVerify WMO compile | 328.833 observed before cancellation | No completion or exit code |
| PhaseVerify WMO run | — | Never started |

The five completed verifier compilations took 1,848.799 seconds; their actual
check executions took 17.417 seconds. The last compile started at
13:30:01.822112 UTC. The Actions log recorded cancellation at
13:35:30.654928 UTC. Its stdout and stderr were empty. This establishes an
incomplete job caused by the aggregate time limit, not a reported compiler error
or failed correctness assertion. The per-command limit was not reached.

Verify checked complete prime arrays for every limit -2 through 2,048, larger
square boundaries, one million and ten million. ExtraVerify checked every limit
2,049 through 30,000, 11,382 deduplicated 128-bit alignment/group/tail limits,
500 random limits up to two million, 1,561 prime-square boundary limits and
3,654 sparse double-group/cleanup boundary limits. PhaseVerify ASAN passed
53,015 partial/full flag checks across 2,305 limits, allocation-zeroing checks
and complete raw-buffer equality. Every completed verifier had empty stderr.

The final runtime image exited 0 with 78,498 validated primes, checksum 9,553,509,
one thread, exact `algorithm=base,faithful=yes,bits=1` tags and an elapsed value of
5.000053083 seconds. This is runtime compatibility evidence only; its pass count
is retained in the raw log and is not used as performance evidence.

All eight initial source hashes and both workflow hashes match independent
hashes of the exact local Git objects. The sieve SHA256 is
`d6368487ee284c955781fe6944c0d94bc35c265e5b40fc4e19cba21d66f6590d`;
the unchanged Dockerfile SHA256 is
`078e05af738c017dfaf6bfc53b83c6c308f72349980991eae227804a63d34ed3`.
The full mapping is in [expected-source-hashes.json](../linux-docker-validation/run-34694761283/expected-source-hashes.json).
The original checkpoint still says `running`: cancellation prevented final
source rehash, final status and the recorded lock-release marker. Those missing
fields are not converted into successful results.

| Original amd64 image | Immutable identity |
|---|---|
| `swift:6.3.3` base repository digest | `sha256:dd115b20969a2acf74c8dcf6da7c4aeda086053c27453dad59052a65bafc8d0c` |
| `swift:6.3.3-slim` base repository digest | `sha256:d20e340aeaf7109919b2a15c95569470070cca4d34dae40dfa58339a2aa734df` |
| Built compiler-stage image ID | `sha256:0c693d957640618ed21cf1a2cf54ece6f7d23e9591b4d8c8075323932a5ba8bd` |
| Built runtime image ID | `sha256:63aa0263638988d63a521f96697bec9a00bd304f706fbf710fd3449d75c3337f` |

The base and built image inspections all report native `linux/amd64`. Built
images were not published, so their immutable local IDs are recorded rather
than invented repository digests. The original [artifact 10299186009](https://github.com/fahlman/Primes/actions/runs/34694761283/artifacts/10299186009)
was downloaded as a ZIP and its SHA256 matched GitHub's advertised digest:
`78680dbfcae62d8c297b218704e8748347b41a7583fe214fe648e3233a5d7afc`.
The ZIP, extracted [validation.json](../linux-docker-validation/run-34694761283/amd64/validation.json),
unmodified command logs, raw job log and API metadata are preserved under
`linux-docker-validation/run-34694761283/`. A separate
[derived audit](../linux-docker-validation/run-34694761283/amd64-audit.json)
records the timeout and durations without rewriting the raw checkpoint.
An independent Codex subagent reconciled the hashes, successful checks,
timestamps and incomplete final-check status with no evidence inconsistency.

## Remaining coverage and limits

The focused follow-up was independently reviewed before publication. Its
validator defaults to all six checks; explicit `--checks phase-verify-wmo`
selects only the missing check and records requested, completed and unrequested
checks. A successful selected run uses `passed_targeted`, not full-suite
`passed`. The final record must reconcile the original five successful amd64
checks and the targeted final check against the same source hashes, and compare
the base-image digests across runs. The full native arm64 result is separate.

[Claude's independent review](https://github.com/fahlman/Primes/pull/14#issuecomment-5646170915)
also reported substantial M4 compilation cost. That is separate context;
the Linux duration conclusions above come from this job's own command timestamps.
No hosted runtime sample establishes an M4 or Threadripper speed advantage.

## Other CI statuses

The validation branch's inherited broad CI correctly skipped both jobs for its
original push [34694761338](https://github.com/fahlman/Primes/actions/runs/34694761338)
and PR [34694784801](https://github.com/fahlman/Primes/actions/runs/34694784801).
The follow-up's inherited push [34697204146](https://github.com/fahlman/Primes/actions/runs/34697204146)
and PR [34697206317](https://github.com/fahlman/Primes/actions/runs/34697206317)
also skipped.

Other report/documentation branch pushes triggered unrelated inherited
all-language CI. Run [34694772323](https://github.com/fahlman/Primes/actions/runs/34694772323)
failed in `PrimeCrystal/solution_2` and `PrimeMojo/solution_1`; those are not this
Swift validation. The root agent cancelled
[34694984042](https://github.com/fahlman/Primes/actions/runs/34694984042),
[34694876158](https://github.com/fahlman/Primes/actions/runs/34694876158) and
[34694873964](https://github.com/fahlman/Primes/actions/runs/34694873964)
to stop further broad CI work. The dedicated validation run was left intact.
The raw completed run/job metadata, including pagination for all 180 jobs where
applicable, is preserved alongside the validation evidence.

Remaining evidence-only publication uses `[skip ci]` to avoid unrelated push/PR
work, following [GitHub's documented skip behavior](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/skip-workflow-runs).
The functional retry commit deliberately did not use that marker. No workflow
settings were globally changed, checks weakened or required checks bypassed.
