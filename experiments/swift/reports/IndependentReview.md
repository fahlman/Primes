# Independent review of commit 5833376

Reviewed September 11, 2026, by Claude (Claude Code), at `58333768b78ac35d0d028a0ca54abf514dcfcdad` on `swift/dense-small-factors`. The review changed no sieve or benchmark code. Measurements used the same Mac and toolchain as [OptimizationResults.md](OptimizationResults.md): Apple M4 Pro, Swift 6.3.3, `-O -whole-module-optimization`.

## Summary

No correctness or memory-safety defects were found, and `algorithm=base,faithful=yes,bits=1` is defensible. Two things need attention. The classification argument has to be stated at the source level, because the compiler merges the single-bit ORs into multi-bit SIMD operations. And the current code has not been timed against the upstream Swift entries in the same session. On performance, 87% of each pass is now spent in the byte-stream loops for factors 11 and up.

## Method

- Read the sieve, runner, observer, verification, build scripts, reports, and results; `CONTRIBUTING.md`; the three upstream Swift entries; and the cited Rust, Nim, Julia, and Chapel code, all unchanged since `22bfea9`.
- Built the benchmark exactly as `run.sh` does and inspected the arm64 assembly.
- Ran `Verify.swift` and [ExtraVerify.swift](../ExtraVerify.swift) under AddressSanitizer.
- Timed each stage of a pass with [tools/phase-split](../tools/phase-split), using the same observer and allocation-to-release boundary. Stages were timed cumulatively and subtracted.
- Rebuilt the upstream entries as `compare_all.py` adapts them, and inspected their assembly.

## Measured

`Verify.swift` passes under AddressSanitizer. So does `ExtraVerify.swift`: 500 seeded random limits from 2,049 to 2,000,000, and 1,561 limits within 3 of every prime square up to 2,000,000.

Time per pass, as the median of three rotated two-second rounds per workload:

| Workload or stage | Median | Range | Share |
|---|---:|---:|---:|
| Full pass, `PrimeSieve` | 82.3 µs | 81.9–83.1 | |
| Copied full loop (control) | 83.0 µs | 82.9–83.0 | |
| Allocation, zeroing, and release | 0.76 µs | 0.75–0.76 | 1% |
| Dense marking of 3, 5, and 7 | 10.1 µs | derived | 12% |
| Byte streams, factors 11–61 | 38.8 µs | derived | 47% |
| Byte streams, factors 67–997 | 33.3 µs | derived | 40% |

The full pass reproduces the recorded 0.0824 ms. The control, which runs the copied sieve code, is within 0.8% of the real pass. Derived rows subtract cumulative workloads: allocation only (0.76 µs), through factor 7 (10.9 µs), through factor 63 (49.7 µs), and the full copied loop (83.0 µs).

Arithmetic, not measured: factors 11–61 make about 269,000 marks per pass, about 0.144 ns each; factors 67–997 about 204,000, about 0.163 ns each; and 3, 5, and 7 about 338,000.

## Observed in compiled code (arm64)

- `completedPass` creates the instance on the stack (`swift_initStackObject`). `init` calls `malloc` and `bzero`. Then come `runSieve`, a real call to `BenchmarkObserver.observe`, and `swift_release`, which runs `deinit` and frees the buffer. All of it is inside the timed loop.
- Factor 3 is vectorized into 48-byte NEON blocks ORed with 0x49, 0x92, and 0x24 (`tbl` and `st3.16b`).
- Factors 5 and 7 become one 4-byte vector OR plus single-byte ORs per group.
- The four-write byte-stream loop takes 23 instructions per four marks, including four overflow-check branches (`b.vs`) from checked additions.

## Findings

1. **Classification is sound at the source level only.** In source, each composite gets its own single-bit OR ([PrimeSieve.swift:86](../PrimeSieve.swift#L86)), only after the runtime bit test ([:29](../PrimeSieve.swift#L29)), starting at p² ([:68](../PrimeSieve.swift#L68)). In compiled code, those ORs become multi-bit masks applied in bulk, including an ARM vector path for factor 3. That is how [OtherLanguageOptimizationReview.md](OtherLanguageOptimizationReview.md#L48) describes C++ solution 5 when excluding it, so the distinction rests entirely on the source. That is also where the maintainers drew the line, according to [Chapel's README](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeChapel/solution_1/README.md#L95): clearing a word with one mask was rejected, and bit-by-bit operations in source were accepted. Recommendation: qualify "no … classification issue" in [OptimizationResults.md](OptimizationResults.md#L25), and state in the [README](../README.md#L3) that the claim concerns source-level operations, which the compiler merges ([CONTRIBUTING.md:208](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/CONTRIBUTING.md#L208)).

2. **The upstream claim is not measured for the current code, and rerunning it erases the record.** The current implementation has not been timed against the three upstream entries in one session ([README.md](../README.md#L56)). Multiplying the ratios from two separate sessions (1.73× and 1.45×) is not a measurement. `compare_all.py` overwrites `all-swift-results.json` ([compare_all.py:113](../compare_all.py#L113)), the historical record the README cites. Add an `--output` option like [compare_optimizations.py](../compare_optimizations.py#L24), or copy the file first.

3. **The upstream adaptation is fair.** [compare_all.py:37](../compare_all.py#L37) turns upstream's `bitMasks` script global into a lazily initialized global. In both 1-bit entries, the one-time initialization check sits at the start of `runSieve`, and the marking loop is unaffected. Upstream's own [Dockerfile](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeSwift/solution_1/Dockerfile#L7) builds with `-c release -Xswiftc -O`, so identical flags don't handicap it.

4. **The timing boundary and observer are as documented.** Every pass creates the instance, allocates and zeroes the buffer, sieves, calls the observer, and releases, all inside the timed loop ([Benchmark.swift:7](../Benchmark.swift#L7)). The compiler places the instance itself on the stack; only the flag buffer is heap-allocated. That satisfies the fresh-instance rule ([CONTRIBUTING.md:299](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/CONTRIBUTING.md#L299)) and applies equally to the upstream entries under this runner. It also means the ManagedBuffer idea ([OtherLanguageOptimizationReview.md](OtherLanguageOptimizationReview.md#L41)) would likely add a heap allocation rather than remove one.

5. **The precedent argument holds, with caveats.** [Rust](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeRust/solution_1/helper-macros/src/lib.rs#L229), [Nim](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeNim/solution_3/Primes.nim#L110), [Julia](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeJulia/solution_4/primes.jl#L94), and [Chapel](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeChapel/solution_1/primes.chpl#L115) each load a word, apply one single-bit OR per composite to a local copy, and store once. Each reports `base,faithful=yes,bits=1`. All four use 64-bit words, with handlers for every odd value up to 129 (Rust, Nim), 63 (Chapel), or 13 (Julia). The byte-level Swift version up to 7 is narrower than any of them. Rust's version marks the prime itself and then restores it ([lib.rs:216](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeRust/solution_1/helper-macros/src/lib.rs#L216)); the Swift p² start avoids that and should stay. These labels are self-reported, and being merged is evidence, not proof.

6. **Submission path.** The current characteristics match upstream's striped and packed entries: base, faithful, 1 bit, 1 thread ([striped entry](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8/Sources/PrimeSieveSwift/main.swift#L174)). In that case [CONTRIBUTING.md](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/CONTRIBUTING.md#L40) expects an improvement to the existing solution rather than a new one, so a separate entry needs a stated justification.

7. **Minor.** The byte streams can set padding bits past the last candidate ([PrimeSieve.swift:55](../PrimeSieve.swift#L55)), while dense marking stops at it ([:168](../PrimeSieve.swift#L168)). That is harmless, because `primes()` masks the padding ([:179](../PrimeSieve.swift#L179)), but `withStorage` exposes those bits. The factor-3 vector path is arm64-specific, so these timings won't carry over to x86-64 Linux.

## Recommended experiments

1. **Wrapping index arithmetic in the byte-stream loops.** Low risk, possibly a large gain.
   - Observed: the four-write loop spends four of its 23 instructions per four marks on overflow-check branches from the checked additions at [PrimeSieve.swift:50–53](../PrimeSieve.swift#L50). The tail loop ([:57](../PrimeSieve.swift#L57)) and the stream step ([:59](../PrimeSieve.swift#L59)) have them too. All three upstream entries use `&+` for this arithmetic ([example](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8/Sources/PrimeSieveSwift/main.swift#L64)).
   - Measured: these loops take 72 µs (87%) of each pass, about 0.15 ns or roughly 0.7 cycles per mark.
   - Hypothesis: the loop is limited by instruction count rather than by stores. Without the checks, the compiler can fold the offsets into the loads and stores. If the core handles about two stores per cycle, the floor is about 0.5 cycles per mark, so this could save up to about 20 µs. It saves nothing if the loop is already store-bound.
   - Rules: the same marks, in the same order, to the same storage. Only Swift's overflow trap goes away, and indices stay below `byteCount + 3p`.
   - Smallest experiment: change only those lines to `&+` and `&+=`, confirm no `b.vs` remains in the loop, run the done checklist in [AGENTS.md](../AGENTS.md), and compare against the current branch in one `compare_optimizations.py` run.

2. **64-bit dense marking for odd factors 9–31, later up to 63.** The biggest target, at moderate risk.
   - Measured: factors 11–61 cost 38.8 µs (47%).
   - Arithmetic: those factors make about 269,000 single-byte updates per pass. Word-dense marking needs about 7,800 word updates per factor regardless of p. That's about 55,000 for factors 11–31, which account for about 195,000 of those marks.
   - Hypothesis: this saves about 15–20 µs (18–25%) if a word update costs 1–1.5 times a byte update. Most of the gain comes from factors up to 31.
   - Rules: the same mechanism as the current dense path and all four precedents. Dispatch only after the runtime bit test. Provide a handler for every odd value in range, including 9, 15, 21, and the rest that are never reached. Start at p², with individual marks up to the first 64-bit boundary. Keep one single-bit OR per composite in source, with no mask tables. Storage stays one bit per candidate; access words with `loadUnaligned` and `storeBytes` rather than rebinding the `UInt8` memory, and assert little-endian.
   - Risk: Swift has no convenient code generation, so this needs either a generated source file or an `@inline(__always)` handler that relies on the compiler to unroll and merge, confirmed in the assembly. It also adds alignment and tail cases, more code, and closer reviewer scrutiny.
   - Smallest experiment: handlers for odd values 9–13 only. Factors 11 and 13 account for about 84,000 marks and about 12 µs today, so a working mechanism should save about 9–10 µs. If experiment 1 lands first, re-measure, because it shrinks this target.

3. **64-bit words for the 5 and 7 handlers.** A small gain, best folded into experiment 2.
   - Measured: factors 3, 5, and 7 together cost 10.1 µs. Observed: factor 3 is already fully vectorized; 5 and 7 are only partly.
   - Hypothesis: 3–5 µs at most.
   - Rules and risk: as for today's dense path.
   - Smallest experiment: port factor 7 alone to a seven-word group of 64 marks.

Suggested order: fix the overwrite in `compare_all.py` and rerun the upstream comparison, so the goal has direct evidence. Then experiment 1, then experiment 2, each on its own branch.

## Not checked

- Five-second contract runs. The stage timings used two-second rounds.
- Docker, Linux, and x86-64 code generation.
- A fresh comparison with the upstream entries.
