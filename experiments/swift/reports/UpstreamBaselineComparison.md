# Upstream Swift baseline comparison

Codex, September 11, 2026 (local time; session began September 12 at 00:47 UTC).

The project baseline is **`PrimeSwift_1bitStriped_u8` at upstream `22bfea9`**, the fastest of the three upstream Swift entries in this session. Our adopted candidate `e8ba734` delivered **3.50 times its throughput** (71.44% less time per pass). This measures the upstream sieve kernels with our common adapted runner on the reference Mac. Background activity limits the precision of the ratio.

Earlier versions of our own implementation are development controls. The previously reported 38.72% gain was against our development control `0d0a142`, not against upstream. Those measurements remain valid for that comparison and are preserved.

## Exact inputs

- Upstream: [`22bfea9c7122c46dcda799020fccf5ae83fe667f`](https://github.com/PlummersSoftwareLLC/Primes/tree/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeSwift/solution_1), verified as the live `drag-race` head immediately before the run.
- Candidate: [`e8ba7346615e79b65bba2e4aef57af9aaf8ea180`](https://github.com/fahlman/Primes/commit/e8ba7346615e79b65bba2e4aef57af9aaf8ea180), adopted through [PR #4](https://github.com/fahlman/Primes/pull/4).
- Checkout and unchanged harness: [`5f1a3e8a32af96aa3196f1cfed155310ba8c4b6d`](https://github.com/fahlman/Primes/tree/5f1a3e8a32af96aa3196f1cfed155310ba8c4b6d/experiments/swift). The measured `PrimeSieve.swift` was checked byte-for-byte against `e8ba734` before compiling.
- [Raw results and provenance](../upstream-baseline-e8ba734.json): every execution's output, validation and time, candidate/upstream revisions, source and generated-adapter SHA-256 hashes, environment, order, and activity snapshots.

## Results

Milliseconds per pass; lower is better. Each trial ran for at least five seconds.

| Implementation | Trial 1 | Trial 2 | Trial 3 | Median |
|---|---:|---:|---:|---:|
| Upstream Bool (`bits=8`) | 0.292883 | 0.295470 | 0.296069 | 0.295470 |
| Upstream packed UInt8 (`bits=1`) | 0.343166 | 0.347904 | 0.353932 | 0.347904 |
| Upstream striped UInt8 (`bits=1`), project baseline | 0.203963 | 0.207650 | 0.208699 | 0.207650 |
| Adopted Swift candidate (`bits=1`) | 0.058968 | 0.059299 | 0.059693 | 0.059299 |

All 12 executions exited successfully and validated 78,498 primes at limit 1,000,000. All reported one thread and `algorithm=base,faithful=yes`; Bool reported `bits=8`, the others `bits=1`. Our slowest trial was faster than the fastest trial of any upstream entry. The candidate's median throughput was 4.98x Bool, 5.87x packed UInt8, and 3.50x striped UInt8.

## Timing and adapter review

Apple M4 Pro, arm64, macOS 26.6.2 (25G83), Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3`, clang 2100.1.1.101). All four benchmarks used `-O -whole-module-optimization`. The common observer was compiled separately with `-O -parse-as-library`, without cross-module optimization. Python only built and launched executables; all timed work was Swift.

The unchanged `compare_all.py` ran three serial rounds:

1. Bool, packed, striped, candidate.
2. Packed, striped, candidate, Bool.
3. Striped, candidate, Bool, packed.

Every pass includes fresh instance allocation, buffer allocation and initialization, sieving, one opaque byte observation, and release. Validation, enumeration, compilation, and output are outside timing. The observer visits valid byte offsets in 500,000 bytes for Bool and 62,500 bytes for the other implementations. This compares the upstream kernels under a common timing boundary, not untouched submission executables.

Codex reviewed the existing adapters before timing; a separate Codex reviewer found no kernel or lifetime blocker at this limit. Extraction removes upstream CLI/printing code and `ArgumentParser`, adds storage access and prime enumeration for validation, and aliases `Sieve` to the runner's class name. For packed/striped, the existing eight-entry single-bit mask table is initialized in a global closure so the extracted code can use `@main`; its process-exit cleanup is omitted. Validation initializes that table before timing, preserving upstream's one-time setup. This adapts the extracted file, not an upstream lifetime defect. The Bool runner uses its correct byte count and storage tag. The marking kernels are retained.

Upstream enumeration excludes the limit while our enumeration includes it; they agree at the even limit 1,000,000. These adapters are only qualified for that benchmark limit. The candidate's earlier complete-array/ASan checks and source-based classification review are in the [combined review](https://github.com/fahlman/Primes/blob/8d773810e9d250076f332904169b3d540b7863db/experiments/swift/reports/CombinedReview.md). No sieve, runner, observer, or comparison-script code changed for this session, so those checks were not repeated; all four variants performed the shared 78,498-prime check before each timed execution.

## Reproduction and limitations

Use the harness and candidate checkout at `5f1a3e8`. Acquire `/tmp/primes-timing.lock` exclusively before invoking `python3 -u compare_all.py`, write a one-line run description, and release it in a `finally` block. Copy the tracked `all-swift-results.json` first. On success, save the newly generated results to a unique file; restore the previous file in `finally`. This session used exactly that procedure, and retained its fuller provenance with the new results. The old `all-swift-results.json` is unchanged.

No competing build, test, benchmark, or media playback was observed. The desktop was active: the pre-run snapshot showed Time Machine `backupd` at 138.5% CPU and WindowServer at 45.6%; after the run WindowServer was at 35.9%. These snapshots do not continuously measure interference. Three rounds also do not balance all four execution positions. Treat **3.50x as this session's measured ratio**, not a universal or precisely isolated speedup. The large separation in every trial supports the conclusion that the adopted candidate beats all three upstream entries on this Mac under this common runner. Docker/Linux execution remains untested.

Use the fastest upstream entry as the project baseline in future goal comparisons, and pin its revision. Use our current development version as an additional control when measuring a new optimization. Do not derive new upstream gains by multiplying ratios from different sessions.
