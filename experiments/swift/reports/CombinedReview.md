# Review and timing of the combined candidate

Codex reviewed **B `e8ba7346615e79b65bba2e4aef57af9aaf8ea180`**, including parent **A `f43c436e94fb9271a1d18c85c61540ef79891e63`**, for [PR #4](https://github.com/fahlman/Primes/pull/4) on 2026-09-11. **Pass: no blocking findings for either revision.** The review follows the shared AGENTS.md and contributing rules at baseline `0d0a1422df12f66b0047393f9ae40ed233061a8a`.

The [review was posted before timing](https://github.com/fahlman/Primes/pull/4#pullrequestreview-5184442108). Both exact candidates then completed the required rotated comparison against that baseline. B was fastest in every trial. It is the preferred candidate among these three in this session; integration remains pending, and nothing was merged or promoted to Current best.

## Traceability and correctness

Independent source comparisons confirmed:

- A's parent is the baseline, and B's parent is A.
- A's factor-5 and factor-7 cases match `62e5a59` exactly; its cases for 9, 11 and 13 match `7b63048` exactly.
- B's six wrapping-arithmetic lines match `de38d53` exactly. Its comment now distinguishes byte indices from the bit index `start`.
- Benchmark.swift, BenchmarkObserver.swift and Verify.swift are unchanged from the baseline. ExtraVerify.swift in both A and B matches experiment 2's expanded version.

Combining the handlers preserves their invariants. Runtime discovery still checks each odd candidate in order. Factor 3 uses the byte handler; every odd value 5 through 13 has a word case, including 9, which is excluded by the runtime composite test. No factor is skipped by dispatch. Each handler begins at p² and individually marks the prefix until a word boundary. At word position j, the first bit is `(-64*j) mod p`; p complete words cover exactly 64 successive multiples. The scalar tail resumes at the next multiple. OR operations preserve all marks made by earlier factors.

Complete-word guards keep each eight-byte raw access within initialized storage. Unaligned raw loads/stores and the little-endian conversions are unchanged from the [reviewed word implementations](https://github.com/fahlman/Primes/blob/20c68f593222cf2551685815072df8ea053c75c0/experiments/swift/reports/WordDenseReview.md); they neither rebind the UInt8 storage nor require an aligned UInt64 pointer. Partial words are handled with bounded byte operations.

B changes only the larger-factor stream additions and their explanatory comment. The unrolled guard makes all four store indices less than `end`; each advancing byte cursor stays below `end + p`. The bit cursor is at most `(p*p - 3)/2 + 8*p`, reaching equality only after its final unused increment. Since `p*p <= limit` and the buffer size is approximately `limit/16`, these additions fit Int without overflow on supported 32- and 64-bit widths. Actual execution was tested on arm64 only.

Both candidates retain individual single-bit source OR operations, complete fresh class-owned runtime-sized storage for every pass, and one thread. No wheel, presieving, multi-bit source mask, cached table, restored prime, or state reuse is added. The project's source-based `algorithm=base,faithful=yes,bits=1` classification remains supported. Compiler merging of those individual source operations does not change that source-based assessment.

## Independent verification

Both exact revisions passed each required configuration, with all build and execution commands exiting 0:

- Verify.swift under AddressSanitizer.
- Verify.swift with `-O -whole-module-optimization`.
- ExtraVerify.swift under AddressSanitizer.

These checks compare complete prime arrays at every limit -2 through 2048, larger prime-square boundaries, 1M and 10M; every limit 2,049 through 20,000; 500 seeded random limits; and 1,561 limits around prime squares through 2M. Prefix/group/tail transitions for all combined factors are covered. No sanitizer errors were reported.

Both candidates were also compiled to arm64 assembly with `-O -whole-module-optimization` and a separately compiled observer. Both retain vector OR operations for word groups and factor 3's `st3.16b` byte loop. No markWord call or variable 64-bit shift remains in runSieve. The observer remains a real `bl` call. Overflow branches in runSieve decrease from **16 in A to 10 in B**.

[Verification evidence](../combined-verification-e8ba734.json) records the exact commands, exit codes, output, tested-file hashes, assembly checks and traceability comparisons. Tests and assembly compilation completed before timing. Review artifacts use a separate `swift/combined-review` worktree; implementation branches were not edited.

## One shared timing session

The process created `/tmp/primes-timing.lock` exclusively before building the comparison, held it through all measured runs, and removed it in `finally`. No competing compiler, test, or benchmark was detected before launch. All three variants were compiled before any measured trial. The comparison process exited 0, and an explicit new output path preserved earlier results.

```sh
python3 experiments/swift/compare_optimizations.py \
  --variant current=0d0a1422df12f66b0047393f9ae40ed233061a8a \
  --variant combined-a=f43c436e94fb9271a1d18c85c61540ef79891e63 \
  --variant combined-b=e8ba7346615e79b65bba2e4aef57af9aaf8ea180 \
  --output experiments/swift/combined-results-e8ba734.json
```

Apple M4 Pro, Swift 6.3.3, macOS 26.6.2, arm64; identical `-O -whole-module-optimization` flags. Both the frozen runner and separate opaque observer are from `25402d46ba991b39451724d3873d326626981e3f`. Each pass includes allocation, initialization, sieving, observation and release. Validation and enumeration remain outside timing. Limit 1,000,000, one thread; all nine runs lasted at least five seconds and validated 78,498 primes.

Run order: baseline/A/B; A/B/baseline; B/baseline/A.

| Variant | Trial 1 ms/pass | Trial 2 ms/pass | Trial 3 ms/pass | Median ms/pass | Throughput vs baseline |
| --- | ---: | ---: | ---: | ---: | ---: |
| Baseline | 0.080924 | 0.081543 | 0.082716 | 0.081543 | +0.00% |
| A: combined words | 0.063671 | 0.064351 | 0.066156 | 0.064351 | +26.72% |
| B: A plus wrapping | 0.057613 | 0.062043 | 0.058781 | 0.058781 | +38.72% |

Relative to A, B delivered **9.48% higher median throughput**, or **8.66% less time per pass**. This directly measures wrapping on top of the combined handlers in this session; it does not add percentages from separate experiments. A's gain over baseline is 26.72%; B's is 38.72%.

The ordering is consistent even across all samples: B's slowest trial (0.062043 ms) beats A's fastest (0.063671 ms), and A's slowest beats the baseline's fastest. B nevertheless has a wider timing range: 0.057613–0.062043 ms/pass (7.69% from minimum to maximum), versus 3.90% for A and 2.21% for baseline. No trial was discarded.

Environment qualification: no competing build/test/benchmark or playback assertion was observed before timing, but the desktop was active. WindowServer was around 40% of one CPU in both snapshots; app rendering and indexing were active before the run, and Weather was around 67% in the afterward snapshot. These observations do not identify the cause of any particular sample. The run supports B over A and both over baseline, but the exact 9.48% incremental figure is provisional and should be confirmed on a quiet machine before being treated as stable. This review does not attribute the larger-than-earlier wrapping gain solely to the removed branch instructions; compiler layout, optimization interactions and system activity were not isolated.

[Raw timing JSON with full revisions, source hashes, outputs and run order](../combined-results-e8ba734.json). Docker/Linux and big-endian execution remain untested. This session did not compare the three original upstream Swift implementations. No merge or adoption action was performed.
