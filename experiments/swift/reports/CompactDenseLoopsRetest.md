# PR #20: user-requested timing repeat

Status: **repeat completed; retain rejection and keep PR #20 closed, unmerged**. All six benchmark runs validated, and every compact-loop trial was slower than every control trial. The monitoring wrapper exited 1 on a post-run compiler-process identification check; this failure is preserved and explained below. It does not erase the completed benchmark outputs.

The user requested this repeat after reporting that another user had been using the computer during the original test. The exact timing and amount of that earlier interference are unknown. The [original report](CompactDenseLoops.md), raw results and provenance remain unchanged apart from an appended link to this follow-up. Assess the sessions separately; no pooled or best-of result is used.

## Exact inputs and protocol

- Candidate: `1a259a84a892cc1008de179ef332d66bd1c514bf`.
- Development control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599`, still the current development head and adopted cutoff-111 sieve.
- Apple M4 Pro; Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3 clang-2100.1.1.101`); macOS 26.6.2.
- Unchanged `compare_optimizations.py`, frozen `25402d46ba991b39451724d3873d326626981e3f` runner and separate observer, `-O -whole-module-optimization`.
- One fresh six-run session, order control/candidate, candidate/control, control/candidate; at least five seconds per run, limit 1,000,000, one thread, `algorithm=base,faithful=yes,bits=1`.
- The exclusive `/tmp/primes-timing.lock` covered compilation and all trials; unique `--output`; lock released afterward. No sieve, runner, observer, generator or verifier changes, and no additional measured session.

The prior 17-command correctness/source/assembly admission was independently rechecked against unchanged inputs before this repeat. Both executables were freshly rebuilt and are **byte-identical to the original session's executables**: control SHA256 `31fd5e6de9f702f99f86fa54e14b6c8655abb2b057977be4fce4d08ebc391b4f`, compact SHA256 `173d4ba48cfabd689d7db53b464efec2cce80a97df85b00f72d412a11ed20064`. Correctness suites were not rerun solely because the background-use report concerned timing. Each new benchmark run independently validated 78,498 primes and the required output tags.

## New measurements

Session: September 12, 2026, approximately 23:32:06–23:33:26 UTC, including compilation.

| Variant | Median µs/sieve | Three-trial range µs/sieve | Median throughput, sieves/s |
|---|---:|---:|---:|
| Adopted cutoff 111 | 38.488941 | 38.353495–38.489687 | 25,981.49 |
| Compact loops | 366.526041 | 364.592041–370.442143 | 2,728.32 |

Compact loops took **9.522892 times as long**, delivered **89.498989% less throughput**, and added **328.037100 µs per sieve**. Every candidate trial lost to every control trial. The original session's medians were 38.298 and 362.478 µs; the newly reported computer use does not change the independently observed ordering in this repeat. These observations do not quantify the effect of earlier contention.

## Conditions and monitoring caveat

Time Machine was initially copying a backup. Before any intervention by Codex, `tmutil status` reported it idle, so no command was issued to interrupt or restart the backup. The initial permission question consequently required no action. Before/after checks and all 15 five-second samples reported backup idle and no audio assertions.

The comparison command itself exited 0. The monitoring wrapper subsequently exited 1 because it required every sampled compiler/benchmark process to share the comparison command's process group. During the nine compilation samples, `swift-frontend` PID 20937 had process group 20937, different from comparison group 20924. This is consistent with the fresh control compilation, but process-group data alone cannot retrospectively prove its parentage. The wrapper therefore retains `status: failed`; its gate is not relabeled as passing.

All six later samples showed only benchmark processes in the owned group 20924 among monitored build/test/benchmark names. No compiler appeared in those timed-run samples, and none was present in either endpoint check. No sampler errors occurred. Desktop/OS work continued: WindowServer was approximately 11–22% CPU in the timed-run samples, and Codex Renderer approximately 3–15%. Five-second snapshots are not continuous tracing, do not identify human desktop use, and cannot prove zero interference between samples. Three rotations of two variants also leave trial positions incompletely balanced.

The completed timings and their consistently separated ranges support retaining the rejection, with the process-identification caveat. This is not a claim of a perfectly idle machine or a passed full monitoring gate. No measured run was discarded or repeated to bypass that gate. No merge or additional package/Linux test was performed.

## Preserved evidence

All new files are in `../compact-loop-retest-evidence/`:

- `protocol.json`: user-authorized scope and preparation.
- `time_retest.py`: exact executed wrapper, SHA256 `05904850f762127b7fba8566062d2db83c015af3807dea2612b134b76dd186d3`.
- `timing-2026-09-12T233206.000568Z.json`: all six raw benchmark results.
- `provenance-2026-09-12T233206.000568Z.json`: original-input hashes, command exit 0, wrapper failure, binary hashes, all condition samples and lock cleanup.
- `audit.json`: independent review of the repeated measurements and the monitoring limitation.

The wrapper imports the unchanged, preserved `compact-loop-evidence/primes_run_support.py`; the original evidence files are not modified. This remains a development-control comparison on M4, with no new upstream or other-platform speed claim.
