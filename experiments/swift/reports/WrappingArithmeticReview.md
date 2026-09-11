# Review and timing of wrapping index arithmetic

Codex reviewed `de38d53b03bf64afa02263c4180a3692d0e2f704` on 2026-09-11 against `experiments/swift/AGENTS.md` and the repository's `CONTRIBUTING.md` at that commit. **Pass: no blocking correctness or category findings.** Independent correctness checks passed, and the candidate completed the requested timing comparison.

The candidate delivered **3.25% higher median throughput (3.15% less time per pass)** than `swift/dense-small-factors` in this session. This is a modest measured improvement, subject to the environment qualification below. The candidate has not been merged or designated the current best by this review.

## Exact revisions and scope

- Candidate: `de38d53b03bf64afa02263c4180a3692d0e2f704`, `swift/wrapping-index-arithmetic`.
- Comparison: `7220ad9c0dfbbe1af250145147b4b2abd56c487d`, the current `swift/dense-small-factors` head (sieve source unchanged from `b45c0c1`).
- Candidate diff: six additions/increments use wrapping arithmetic in the existing byte-stream path, plus a comment. Dense handlers, prime discovery, allocation, enumeration, benchmark, and observer are unchanged.
- Review and checks used a separate worktree; neither implementation branch was edited.

## Correctness and classification

The unrolled loop executes only when `byte < end - 3*p`, so all four stores are within the buffer. After advancing by `4*p`, the byte cursor remains below `end + p`; the tail preserves that bound. Since `p*p <= limit`, and `end` is approximately `limit/16`, these additions cannot overflow a supported 32- or 64-bit `Int`.

The source comment discusses byte indices, but `start &+= p` uses a bit index. Its separate bound is `start <= (p*p - 3)/2 + 8*p`, also below `Int.max` on those integer widths. This is a nonblocking documentation clarification, not a discovered overflow. Small and negative limits do not enter the changed path.

The same individual composites are marked in the same order. Factors are still discovered by sequential odd-candidate tests. Every timed pass creates fresh class-owned, dynamically allocated storage, computes the complete flags, observes them, and releases them. No wheel, cached state, multi-bit source masks, or additional threads are introduced. The change preserves the project's source-based `algorithm=base,faithful=yes,bits=1` classification. Compiler combination of individual source operations remains distinct from writing composite-pattern masks in source.

## Independent verification

All six commands below exited 0, using the exact candidate source:

```sh
swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify-asan
.build/verify-asan
swiftc -O -whole-module-optimization PrimeSieve.swift Verify.swift -o .build/verify
.build/verify
swiftc -O -sanitize=address PrimeSieve.swift ExtraVerify.swift -o .build/extra-verify-asan
.build/extra-verify-asan
```

`Verify.swift` compared complete prime arrays for every limit from -2 through 2048, larger square boundaries, 1,000,000, and 10,000,000. `ExtraVerify.swift` passed 500 seeded random limits and 1,561 limits within three of every prime square through 2,000,000. AddressSanitizer reported no errors.

Independent arm64 assembly inspection with `-O -whole-module-optimization` confirmed:

- `runSieve` overflow branches: 15 in current, 9 in wrapping.
- Repeated four-store loop: 23 instructions in current, 16 in wrapping.
- The separately compiled opaque observer remains a real `bl` call in both versions.

Docker/Linux execution and 32-bit execution were not tested.

## Timing

The timing process created `/tmp/primes-timing.lock` exclusively before compiling the comparison, held it through all runs, and removed it in `finally`. No other build or test process was detected before the run. All compilation completed before the serial measured runs. The comparison process exited 0.

```sh
python3 experiments/swift/compare_optimizations.py \
  --variant current=7220ad9c0dfbbe1af250145147b4b2abd56c487d \
  --variant wrapping=de38d53b03bf64afa02263c4180a3692d0e2f704 \
  --output experiments/swift/wrapping-results-de38d53.json
```

Reference machine: Apple M4 Pro, Swift 6.3.3, macOS 26.6.2, arm64. Both variants used `-O -whole-module-optimization`, the frozen runner and separate observer from `25402d46ba991b39451724d3873d326626981e3f`, a 1,000,000 limit, and one thread. Each run lasted at least five seconds and validated 78,498 primes. Run order was current/wrapping, wrapping/current, current/wrapping.

| Variant | Trial 1 ms/pass | Trial 2 ms/pass | Trial 3 ms/pass | Median ms/pass |
| --- | ---: | ---: | ---: | ---: |
| Current dense | 0.081468 | 0.082353 | 0.082581 | 0.082353 |
| Wrapping | 0.079696 | 0.079761 | 0.080867 | 0.079761 |

Every wrapping sample was faster than every current sample. Median throughput ratio: **1.032495x**. These are same-session comparisons; prior historical runs were not substituted for the control.

Environment qualification: Time Machine and cloud synchronization were active during preparation. Their CPU activity had subsided by the timing launch (cloud processes approximately 5–6% each; backupd absent from the top 12), but WindowServer and the desktop apps remained active. No playback assertion or concurrent compiler/test process was observed. The host was not a fully quiescent benchmark environment, and process snapshots do not prove it stayed quiet throughout. Treat this as evidence of a modest improvement in this session, not a precise guaranteed speedup; confirm under a quiet host before relying on the percentage for a performance claim.

[Raw results, including all outputs, revisions, and source hashes](../wrapping-results-de38d53.json). Existing historical result files were preserved. This comparison did not rerun the three upstream Swift entries or promote the candidate.
