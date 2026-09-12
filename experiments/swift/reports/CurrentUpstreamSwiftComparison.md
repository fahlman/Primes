# Current Swift candidate versus upstream

Codex; September 12, 2026. Independent evidence audit by a separate Codex subagent.

Candidate **`bd3858c` delivered 5.31254 times the throughput** of **`PrimeSwift_1bitStriped_u8` at upstream `22bfea9`**, the fastest of the three upstream Swift entries in this session. Median time per pass was **39.00034 µs versus 207.19085 µs**. Every candidate trial was faster than every upstream trial. This is a direct comparison on Apple M4 Pro using the common adapted runner; desktop activity and incomplete position balancing limit the precision and generality of the ratio.

This report measures the exact candidate below. It does not adopt that candidate or infer a gain over a development control. Earlier upstream and development comparisons remain separate records.

## Exact inputs and evidence

- Candidate and checkout: [`bd3858cac9a306aa3b8d4729cf059959a7c70885`](https://github.com/fahlman/Primes/tree/bd3858cac9a306aa3b8d4729cf059959a7c70885/experiments/swift). This combines the adopted sixteen-write sparse loop with 128-bit handlers for odd factors 65–127 and the proven-safe wrapping chunk-offset multiplication.
- Upstream: [`22bfea9c7122c46dcda799020fccf5ae83fe667f`](https://github.com/PlummersSoftwareLLC/Primes/tree/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeSwift/solution_1). The execution record states that the live upstream head matched this pin before the run.
- [Raw trials](../upstream-current-bd3858c.json) contain every result line, pass count, elapsed time, validation message, median and throughput ratio.
- [Verification and provenance](../upstream-current-bd3858c-verification.json) identify the candidate, upstream sources, compiler, hardware, source/adapter/executable hashes, command outcome, activity snapshots and independent audit.

The audit recomputed the raw-data hash and checked all four recorded source hashes against the checkout and exact candidate commit. The runner, observer and comparison script match the previous independently reviewed upstream comparison byte-for-byte. All six generated source/runner adapters and all three upstream source hashes also match that earlier record. The four executable hashes match the retained build artifacts. The tracked historical `all-swift-results.json` was restored unchanged.

## Results

Microseconds per pass; lower is better. Each trial is its implementation's sample from the corresponding serial round. Throughput ratios divide the upstream median time by the candidate median time.

| Implementation | Round 1 | Round 2 | Round 3 | Median | Candidate throughput ratio |
|---|---:|---:|---:|---:|---:|
| Upstream Bool (`bits=8`) | 290.05471 | 289.80920 | 291.59864 | 290.05471 | 7.43724× |
| Upstream packed UInt8 (`bits=1`) | 349.41909 | 348.74415 | 351.92560 | 349.41909 | 8.95939× |
| Upstream striped UInt8 (`bits=1`), project baseline | 207.19085 | 207.17979 | 208.17837 | 207.19085 | **5.31254×** |
| Candidate `bd3858c` (`bits=1`) | 38.91584 | 39.00034 | 39.22390 | **39.00034** | — |

All 12 executions completed successfully, ran for at least five seconds and passed the pre-timing check for 78,498 primes at limit 1,000,000. The recorded durations range from 5.000023417 to 5.000293625 seconds. All outputs report one thread and `algorithm=base,faithful=yes`; Bool correctly retains `bits=8`, and the other entries use `bits=1`. These executions validate the count at the benchmark limit, not complete prime arrays over other limits. The observation checksums depend on each representation and pass count and are not cross-implementation equality checks.

## Common runner and adapter scope

The reference machine was Apple M4 Pro, arm64, macOS 26.6.2 (25G83), with Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3`, clang 2100.1.1.101). Each benchmark used `-O -whole-module-optimization`; the shared opaque observer was compiled separately with `-O -parse-as-library`, without cross-module optimization. All four builds finished before the serial timing loop. Python built and launched the executables; Swift performed the timed work.

Every timed pass creates fresh sieve state, allocates and initializes its buffer, performs sieving, calls the opaque byte observer, and releases the instance and storage. Compilation, preflight validation, enumeration and printing are outside timing. The observer's byte offsets remain in bounds: 500,000 bytes for Bool and 62,500 for each one-bit implementation.

The unchanged adapters retain the upstream marking kernels while removing CLI/printing code and `ArgumentParser`, adding storage access and enumeration for validation, and aliasing `Sieve` to the common runner's class name. Packed and striped retain their eight-entry single-bit mask table. Its initialization moves into a global closure compatible with `@main`; validation initializes it before timing, and process-exit cleanup is omitted. This preserves one-time table setup rather than moving sieve state outside a pass. The adapter change is not evidence of an upstream lifetime bug.

This comparison is qualified only at the even limit 1,000,000. Upstream enumeration excludes the limit while candidate enumeration includes it; those conventions agree here. These are adapted kernel timings under a common boundary, not timings of the original submission CLIs, their shared Docker toolchain or the official leaderboard runner. The candidate's `base,faithful=yes,bits=1` classification rests on its source: sequential runtime factor discovery, p² starts, fresh class-owned flags and individual single-bit marks. Compiler merging of those marks does not change that source description.

## Order and conditions

The unchanged script ran three rotations:

1. Bool, packed, striped, candidate.
2. Packed, striped, candidate, Bool.
3. Striped, candidate, Bool, packed.

With four variants, three rotations do **not** balance all four execution positions. The candidate occupied positions 4, 3 and 2 and never ran first. This order reduces some order dependence but cannot remove it. There were no additional timing brackets.

The recorded command ran from 12:42:13 to 12:45:16 UTC, including compilation. The execution record reports an exclusive timing lock from before compilation through completion and its removal afterward. The before-compilation snapshot showed substantial Spotlight activity: `mds` at 34.4% CPU and several `mdworker_shared` processes at 17–33% each. Codex Renderer was at 22.0%. After the comparison, Spotlight did not appear among the recorded top processes; WindowServer was at 10.9%. No competing build, test, benchmark or audio assertion was recorded in either snapshot.

These are two endpoint snapshots, not continuous monitoring. They cannot establish how much background work overlapped the timed interval or isolate its effect. Treat **5.31254× as this session's measured ratio**. The separation in every trial supports the conclusion that this candidate beats all three adapted upstream entries on this Mac; it does not establish an exact universal speedup. Nothing here predicts Threadripper PRO 9995WX, Linux, Docker or leaderboard performance. Linux/Docker validation is separate work; no Linux result is part of this timing session. Do not multiply this ratio by gains from other sessions or attribute the entire upstream advantage to the latest offset change.

## Reproduction

Check out exact candidate `bd3858cac9a306aa3b8d4729cf059959a7c70885` and use `experiments/swift/compare_all.py` with the recorded Swift toolchain on the reference machine. It downloads the pinned upstream sources and performs all builds before timing. Acquire `/tmp/primes-timing.lock` exclusively before running `python3 -u compare_all.py`; preserve the tracked `all-swift-results.json`, save new output under a fresh unique name, and restore the earlier file and release the lock in `finally`. Capture candidate/upstream revisions, hashes, run order, validation and conditions as in the linked provenance. A rerun produces new evidence and must not overwrite this session's files.
