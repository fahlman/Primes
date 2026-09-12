# Fused-sparse phase diagnostics

On the `swift/fused-sixteen-writes` candidate branch, this copy remains the adopted
eight-write B reference. Its full-buffer checks can validate the candidate, but
its phase timings do not describe the candidate's sixteen-write sparse loop.

`PhaseSieve.swift` copies adopted production `8f108f5` (merged in `703dc12`,
unchanged in development `1edbea7`). Only the class name, `runSieve` signature,
and its extra factor cutoff differ. Normalize those three substitutions and
remove the six-line diagnostic header to compare it with `PrimeSieve.swift`
before use after a source change. Production sieve, submission runner and
observer are unchanged by this diagnostic update.

The [refreshed B breakdown](../../reports/FusedSparseBandBreakdown.md) records the
verified `56ad42b` copy, all 21 timing samples and the passing 3% full-copy control.

The [earlier through-63 breakdown](../../reports/PhaseBreakdownThrough63.md) and
[earlier sparse-band report](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/reports/SparseBandBreakdown.md)
describe `19aa38a` and remain historical evidence. They do not profile the current
fused sparse loops. New runs require unique output files.

The seven cumulative workloads are allocation only, through factor 3, through
factor 63, through factor 251, through factor 499, the copied full sieve, and the
production full sieve. All include fresh allocation/zeroing, opaque observation
and release. Partial workloads are diagnostics, not complete qualifying sieve
passes; their checksums are not prime counts. Subtract cumulative medians to
estimate factor 3, word factors 5–63, and the sparse factors in three bands.
Allocation also includes observation, release, the clock and runner overhead.
Each difference includes factor discovery and any effects of stopping early, so
these are approximate costs, not timers inside one pass.

At 1,000,000, the three sparse bands differ in factor count, stride and loop
length. Counts of B's source byte writes, with one fused traversal per factor:

| Band | Factor loops | Byte writes | Rounded writes per factor loop |
|---|---:|---:|---:|
| 67–251 | 36 | 132,120 | 3,670 |
| 257–499 | 41 | 48,828 | 1,191 |
| 503–997 | 73 | 23,431 | 321 |

Writes include repeated composite marks and final-byte padding. They are source
operations, not unique composites or measured hardware stores. The eight
per-factor bit phases are fused; the old counts of 288/328/584 independent
streams do not describe B. Stride, address order and tail share vary between
bands, so normalized band costs do not isolate a universal per-loop overhead.

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
