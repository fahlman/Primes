# Through-63 phase diagnostics

Production now uses fused sparse streams at `8f108f5`. This diagnostic still copies
`19aa38a` and must be refreshed and reviewed before profiling current production.
The recorded through-63 measurements remain historical evidence.

The [recorded through-63 breakdown](../../reports/PhaseBreakdownThrough63.md) includes
raw samples, source verification and measurement limits.

`PhaseSieve.swift` copies the adopted sieve at `19aa38a` (unchanged in development
commit `fac788e`). Only the class name, `runSieve` signature and its extra factor
cutoff differ. Normalize those three substitutions and remove the diagnostic
header to compare it with `PrimeSieve.swift` before using it after a source change.
The production sieve, submission runner and observer are unchanged.

The seven cumulative workloads are allocation only, through factor 3, through
factor 63, through factor 251, through factor 499, the copied full sieve, and the
production full sieve. All include fresh allocation/zeroing, opaque observation
and release. Partial workloads are diagnostics, not complete qualifying sieve
passes; their checksums are not prime counts. Subtract cumulative medians to
estimate factor 3, word factors 5–63, and the sparse factors in three bands.
Allocation also includes observation, release, the clock and runner overhead.
Each difference includes factor discovery and any effects of stopping early, so
these are approximate costs, not timers inside one pass.

At 1,000,000 the three sparse bands differ mainly in stream length. Counts of the
production loops' byte writes and streams (eight per factor):

| Band | Factors | Byte writes | Streams | Writes per stream |
|---|---:|---:|---:|---:|
| 67–251 | 36 | 132,120 | 288 | 459 |
| 257–499 | 41 | 48,828 | 328 | 149 |
| 503–997 | 73 | 23,431 | 584 | 40 |

Stride, address order and the share of tail writes also change between bands, so
band costs describe where time goes; they don't predict which loop change wins.

`PhaseVerify.swift` compares every valid odd flag against an independent Boolean
reference at each cutoff, checks full buffers including padding against
production, and checks allocation zeroing. It covers small limits, dense square
and group boundaries, the sparse transition, the band cutoffs at 251/257 and
499/503 with limits on both sides of their squares, varied limits, and 1,000,000.
Compile/run it with both `-O -sanitize=address` and `-O -whole-module-optimization`.

Use the timing lock in `../../AGENTS.md`; acquire it exclusively **before any
timing build**, and release it in a `finally`/trap. No concurrent builds, tests,
benchmarks or media. After verification and independent review, build from
`experiments/swift`:

```sh
mkdir -p .build
swiftc -O -parse-as-library -module-name BenchmarkObserver -emit-module \
  -emit-module-path .build/BenchmarkObserver.swiftmodule \
  -emit-object BenchmarkObserver.swift -o .build/BenchmarkObserver.o
swiftc -O -whole-module-optimization -I .build PrimeSieve.swift \
  tools/phase-split/PhaseSieve.swift tools/phase-split/PhaseBench.swift \
  .build/BenchmarkObserver.o -o .build/phase-split
.build/phase-split --output UNIQUE_RESULTS.json
```

Inspect assembly to confirm a real separately compiled observer call in every
wrapper. Seven modes run serially for five seconds each across three rotated
rounds (not a full balance of every position). JSON preserves every sample,
order, duration, pass count and checksum; the output path is required and existing
results are never overwritten. Record exact source revisions/hashes, compiler,
hardware, build commands and conditions with it. Production count validation
and full-copy buffer comparison happen outside timing.

Interpretation criterion, set before timing: if the copied full median differs
from production by more than 3%, report the mismatch and avoid a fine-grained
allocation of the production total. Even below that threshold, compiler layout,
specialization, cache state and desktop noise limit precision. Full-copy agreement
does not establish identical code generation for partial workloads. This tool
measures where time is spent; optimization gains still require
`compare_optimizations.py` under the normal benchmark contract. Do not combine its
ratios with old sessions.
