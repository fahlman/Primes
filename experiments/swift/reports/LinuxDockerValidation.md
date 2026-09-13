# Native Linux and Docker validation

Native Linux/Docker validation is complete for the pinned source below. The
unchanged Docker image built and ran successfully on amd64 and arm64, and all
six correctness checks have successful evidence on each architecture. The amd64
coverage combines five checks from the original job with the final PhaseVerify
WMO check from one focused follow-up. The original 45-minute timeout is retained
as a cancelled run. Hosted smoke runs are compatibility evidence only.

The solution is exactly `bd3858cac9a306aa3b8d4729cf059959a7c70885`, the 128-bit
wrapping-offset candidate in [PR #14](https://github.com/fahlman/Primes/pull/14).
The validation workflow is fork-only [PR #15](https://github.com/fahlman/Primes/pull/15).
This report does not adopt or merge either PR.

| Run | Workflow revision | Scope | Recorded result |
|---|---|---|---|
| [34694761283](https://github.com/fahlman/Primes/actions/runs/34694761283) | `dc5ef6aef662d37c9ae7495272b1b0b945929428` | Native amd64 and arm64, six checks each, serial | amd64 timed out during final compile; arm64 passed all six |
| [34697204142](https://github.com/fahlman/Primes/actions/runs/34697204142) | `5867ca7033d938c5977749fdf4f019e2696c6e2b` | Native amd64, PhaseVerify WMO only | Passed targeted check; completes aggregate amd64 coverage |

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
the 45-minute job cap. GitHub's preserved [check-run annotation](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34694761283/github/check-run-103556227050-annotations.json)
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
The full mapping is in [expected-source-hashes.json](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34694761283/expected-source-hashes.json).
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
The ZIP, extracted [validation.json](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34694761283/amd64/validation.json),
unmodified command logs, raw job log and API metadata are preserved under
`linux-docker-validation/run-34694761283/`. A separate
[derived audit](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34694761283/amd64-audit.json)
records the timeout and durations without rewriting the raw checkpoint.
An independent Codex subagent reconciled the hashes, successful checks,
timestamps and incomplete final-check status with no evidence inconsistency.

## Native arm64 evidence

[Job 103556226966](https://github.com/fahlman/Primes/actions/runs/34694761283/job/103556226966)
ran from 13:35:39 to 14:07:07 UTC and passed in 31 minutes 28 seconds. Its native
`ubuntu-24.04-arm` runner exposed four Neoverse-N2 cores, reported `aarch64`,
and used runner image `20260907.118.1`. Docker and all images reported native
`linux/arm64`; Swift 6.3.3 reported target `aarch64-unknown-linux-gnu`.

All 29 commands exited 0. Verify, ExtraVerify and PhaseVerify passed in both
ASAN and WMO modes with the same coverage described above; both PhaseVerify
modes passed 53,015 flag checks across 2,305 limits. All six verification
executions had empty stderr. Initial solution/workflow identities and all
source hashes matched the exact pinned Git objects, final source hashes matched
the initial hashes, and the record confirms removal of the runner-local lock.

| Arm64 command | Elapsed seconds |
|---|---:|
| Docker compiler-stage build | 285.180 |
| Verify ASAN compile / run | 252.991 / 0.316 |
| ExtraVerify ASAN compile / run | 231.866 / 6.479 |
| PhaseVerify ASAN compile / run | 264.074 / 2.620 |
| Verify WMO compile / run | 285.779 / 0.215 |
| ExtraVerify WMO compile / run | 255.915 / 3.122 |
| PhaseVerify WMO compile / run | 253.817 / 1.270 |

The six verifier compilations took 1,544.442 seconds and their executions took
14.023 seconds. The runtime smoke validated 78,498 primes, one thread and exact
tags after 5.000095772 seconds. The two base-image repository digests match the
original amd64 run's manifest digests, with native arm64 image IDs recorded
separately. The built compiler image ID is
`sha256:fe452512398deaad851ea435114f3726dfda65b42be37a8637e899afd34c7f38`;
the runtime image ID is
`sha256:d1dbcdd19ed6c03a4b5d9c3ae4c4a0fc1110cef8c88158ac53bf65bbc5d248cc`.

The [arm64 artifact 10299213736](https://github.com/fahlman/Primes/actions/runs/34694761283/artifacts/10299213736)
ZIP SHA256 matched GitHub's advertised digest,
`98a996e48194702ff68ae6bb1d82ec5b64a71c7a1235202c9cb628ad23872fbe`,
and every extracted file matched its archived bytes. The original
[validation.json](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34694761283/arm64/validation.json),
command/job logs and metadata are preserved alongside a separate
[derived audit](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34694761283/arm64-audit.json).
An independent Codex subagent reconciled the complete arm64 evidence with no
blocking findings.

## Focused amd64 completion and aggregate coverage

The focused follow-up was independently reviewed before publication. Its
validator defaults to all six checks; explicit `--checks phase-verify-wmo`
selects only the missing check and records requested, completed and unrequested
checks. A successful selected run uses `passed_targeted`, not full-suite
`passed`.

[Job 103565585644](https://github.com/fahlman/Primes/actions/runs/34697204142/job/103565585644)
ran from 14:07:12 to 14:18:32 UTC and passed in 11 minutes 20 seconds, after the
original arm64 job had completed. The native amd64 runner exposed four x86_64
CPUs identified as AMD EPYC 7763, with the same Ubuntu runner-image version and
Swift 6.3.3 x86_64 target as the original amd64 job. All 19 commands exited 0.
The compiler-stage Docker build took 309.973 seconds; PhaseVerify WMO compilation
took 321.246 seconds and its execution took 1.619 seconds. The check reported
53,015 flag checks across 2,305 limits with empty stderr. The runtime smoke
validated 78,498 primes, one thread and exact tags after 5.000087686 seconds.

The record says `passed_targeted`, with requested and completed checks exactly
`[phase-verify-wmo]`; the other five are explicitly unrequested. All eight source
hashes match the original amd64 and arm64 records and the exact `bd3858c` Git
objects. The focused workflow hashes match `5867ca7`. Final source hashes match,
and lock removal is recorded. The final PhaseVerify WMO compile command matches
the original interrupted command, including flags, sources and read-only mount.
Both base-image IDs and repository digests exactly match the original amd64 run.

The focused compiler image ID is
`sha256:4c6e36a34cc07a7c1333b6917987e270e27454739e890ce1822e71355b6ec0e1`;
the runtime image ID is
`sha256:da46c924688060da886cb100c7e2fb5489bdef1cd90bdb1c0977ef36fb543e65`.
Both report `linux/amd64`. The [focused artifact 10299771414](https://github.com/fahlman/Primes/actions/runs/34697204142/artifacts/10299771414)
ZIP matched GitHub's advertised SHA256,
`02f19ae48f81eca8469193ecf36e288281aeabdb13a93bcbcf2787f4122348c2`,
and every extracted byte matched the archive. Its original
[validation.json](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34697204142/amd64-phase-verify-wmo/validation.json),
logs, job/run metadata and separate
[derived audit](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/run-34697204142/amd64-targeted-audit.json)
are preserved. An independent Codex subagent audited the original-five plus
focused-one amd64 coverage with no blocking findings.

| Successful check | Native amd64 run | Native arm64 run |
|---|---|---|
| Verify ASAN | 34694761283 | 34694761283 |
| ExtraVerify ASAN | 34694761283 | 34694761283 |
| PhaseVerify ASAN | 34694761283 | 34694761283 |
| Verify WMO | 34694761283 | 34694761283 |
| ExtraVerify WMO | 34694761283 | 34694761283 |
| PhaseVerify WMO | 34697204142 | 34694761283 |

The [aggregate coverage record](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/aggregate-coverage.json)
maps all 12 successful native verifier executions to the two runs. This is
source-specific compatibility/correctness coverage across jobs. The original
amd64 job remains cancelled, with its unfinished compile exit code `null` and
absent final rehash/cleanup fields preserved. The original matrix therefore
remains `cancelled` despite successful aggregate completion. The
[evidence manifest](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/linux-docker-validation/evidence-manifest.json) records
SHA256 hashes for the preserved files.

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
