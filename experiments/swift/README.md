# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. The runtime-discovered factor 3 uses specialized byte marking: each individual composite bit is marked in a local byte, which is written back once. Factors 5 through 63 use the same approach on 64-bit words; the cases for the composite values 9, 15, 21, 25, 27, 33, 35, 39, 45, 49, 51, 55, 57, and 63 are never reached. Larger factors use one fused loop per factor: each iteration marks two groups of eight successive multiples, with a fixed single-bit mask for each bit phase. One optional eight-mark group precedes the unchanged scalar tail of at most seven marks. There is no presieving, cached sieve state, or wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding bits. The storage pointer must not outlive its sieve instance.

The comparison tags remain `algorithm=base,faithful=yes,bits=1`, with one thread. Small-factor specialization preserves runtime discovery and separate single-bit operations, following the approach documented in the [other-language review](reports/OtherLanguageOptimizationReview.md). The larger-factor loop uses the wrapping index arithmetic adopted in PR #4.

## Run instructions

With Swift installed:

```sh
sh ./run.sh
```

The script compiles with `-O -whole-module-optimization` and runs fresh one-million sieves for at least five seconds. Build time, validation, enumeration, and printing are outside the timed interval. Allocation, initialization, marking, opaque observation, and release are inside every timed pass.

Historical example from the `e8ba734` direct upstream comparison on Apple M4 Pro with Swift 6.3.3:

```text
fahlman_swift_dense_striped;84792;5.000039292;1;algorithm=base,faithful=yes,bits=1
```

Optional Docker build and run:

```sh
docker build -t faster-prime-swift .
docker run --rm faster-prime-swift
```

The Dockerfile uses official `swift:6.3.3` and `swift:6.3.3-slim` images. The image tags were checked for amd64 and arm64. Docker is not installed on the test Mac, so the container build and Linux runtime remain untested.

## Adopted sixteen-write fused loop

The adopted change uses two fused groups per sparse-loop iteration, measured against the earlier B development control `7509c87`. The bound `byte < end - r7 - p` protects the second group's last address; advancing by two groups leaves at most one complete eight-mark cleanup group. The scalar tail preserves B's byte-rounded padding behavior. Runtime factor discovery, factors 3–63, storage, benchmark and observer are unchanged.

Exact measured source **`59262fe`** delivered **1.24% more throughput**, saving **0.491 µs per sieve**: median **39.553 µs** versus development **40.044 µs**. Every candidate trial beat every development trial in one shared, rotated session on Apple M4 Pro / Swift 6.3.3, with three five-second runs each. The independent 128-bit candidate measured 42.365 µs in that session. Spotlight was near 99% CPU in both condition snapshots, so the exact percentages are provisional. This implementation was adopted through PR #12 in merge commit `83751ea`, which preserves the exact reviewed sieve, runner and observer.

Verify, ExtraVerify and PhaseVerify passed under both AddressSanitizer and optimized WMO, including 3,654 additional sparse-group boundaries and 34,983 phase checks over 1,521 limits with full-buffer equality and padding. These checks ran at `6679810`; final `59262fe` changes one comment only, independently reviewed with byte-identical recompiled assembly. The main loops use 51 instructions per sixteen marks, versus 54 for two B iterations; setup and cleanup still incur additional work. The real observer call and release remain. These counts do not isolate the cause of the measured gain.

[Review and decision](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/reports/SixteenWriteFusedReview.md), [raw results](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-results-59262fe-307da10.json), and [verification evidence](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-verification.json) are published for [PR #12](https://github.com/fahlman/Primes/pull/12). Changes after the measured source commit are documentation only.

The diagnostic copy still describes B. Its full-buffer verifier provides a reference for this candidate, but its timings do not profile the sixteen-write loop. The historical results below describe adopted or earlier versions and are separate from this session.

## Current results and project baseline

The adopted implementation is the **sixteen-write fused sparse loop, source `59262fe`**, merged through [PR #12](https://github.com/fahlman/Primes/pull/12) as `83751ea`. It retains dense handlers through 63 and marks sixteen successive sparse multiples per main iteration.

| Latest development comparison | Median milliseconds per pass |
|---|---:|
| Development control `7509c87` | 0.040044 |
| Adopted sixteen-write loop `59262fe` | **0.039553** |
| Independent 128-bit candidate `307da10` | 0.042365 |

The adopted candidate delivered **1.24% more throughput**, saving **0.491 µs per sieve**, with every trial beating every development trial. The 128-bit candidate delivered **5.48% less throughput** and remains unmerged. All nine rotated M4 Pro / Swift 6.3.3 runs validated correctly. Spotlight activity makes exact percentages provisional. See the [review](reports/SixteenWriteFusedReview.md), [raw results](sparse-next-results-59262fe-307da10.json), and [verification](sparse-next-verification.json).

The [phase diagnostic](tools/phase-split/README.md) still copies earlier B (`8f108f5`). Its full-buffer comparison remains a correctness reference, but the [historical breakdown](reports/FusedSparseBandBreakdown.md) does not profile this implementation. Normalized source equality is required before using a diagnostic copy for current phase timings.

## Most recent direct upstream comparison

The fastest tested candidate is **`bd3858c` in [PR #14](https://github.com/fahlman/Primes/pull/14), not yet merged**. It adds the 128-bit handlers for odd factors 65–127 to the adopted sixteen-write loop, with provably safe wrapping byte offsets. Its direct development comparison measured **39.116 µs** versus `e3f5a41` at **40.432 µs**, **3.36% more throughput**, saving **1.316 µs per sieve**. Every candidate trial beat every development trial. [Review](reports/Dense128WrappingOffsetReview.md), [raw results](dense-128-offset-results-bd3858c.json), [verification](dense-128-offset-verification.json). The port parent was not timed, so this does not isolate wrapping's contribution.

A separate fresh session compared that exact candidate with all three upstream entries. The project baseline remains **`PrimeSwift_1bitStriped_u8` at `22bfea9`**, the fastest upstream implementation.

| Implementation | Median µs per sieve | Candidate throughput ratio |
|---|---:|---:|
| Upstream Bool (`bits=8`) | 290.055 | 7.44x |
| Upstream packed UInt8 (`bits=1`) | 349.419 | 8.96x |
| Upstream striped UInt8 (`bits=1`), project baseline | 207.191 | **5.31x** |
| Unmerged candidate `bd3858c` (`bits=1`) | **39.000** | — |

Three rotated five-second trials per implementation, Apple M4 Pro, Swift 6.3.3, identical compiler flags and allocation-through-release Swift runner. All 12 executions validated 78,498 primes, and every candidate trial beat every upstream trial. Spotlight activity before compilation makes the exact ratios provisional; snapshots do not establish activity during individual trials. Three rounds do not fully balance four execution positions. These are adapted upstream kernels under a common runner at one million, not the original CLI executables or Threadripper measurements. [Report and adapter details](reports/CurrentUpstreamSwiftComparison.md), [raw results](upstream-current-bd3858c.json), [provenance](upstream-current-bd3858c-verification.json).

The earlier `e8ba734` comparison remains preserved in its [report](reports/UpstreamBaselineComparison.md) and [raw record](upstream-baseline-e8ba734.json). The adopted development source remains the sixteen-write implementation described above; the newest direct upstream result belongs to unmerged `bd3858c`.

Our earlier implementations are **development controls**, including the historical `swift/baseline` branch. Comparisons against them measure each optimization's contribution and are separate from the upstream baseline. The combined candidate's earlier 38.72% gain was over development control `0d0a142`; wrapping added 9.48% over the combined word handlers alone. See the [combined review](https://github.com/fahlman/Primes/blob/8d773810e9d250076f332904169b3d540b7863db/experiments/swift/reports/CombinedReview.md).

Historical stream-fusion and dense-byte results remain in [OptimizationResults.md](reports/OptimizationResults.md) and [optimization-results.json](optimization-results.json). Those measurements and the original comparison below describe earlier versions.

## Original repository comparison

Before these experiments, our original development control beat all three repository Swift entries under the same allocation-to-release timing convention:

| Repository implementation | Original control throughput advantage |
|---|---:|
| Boolean | 2.43x |
| Packed UInt8 | 2.91x |
| Striped UInt8 | 1.73x |

Those are historical development-control measurements, preserved in [all-swift-results.json](all-swift-results.json) and the [original report](reports/EqualTermsSwiftComparison.md). The later `e8ba734` and unmerged `bd3858c` each have their own direct upstream comparison; adopted `59262fe` has its recorded development comparison. Do not combine ratios across sessions.

To compare the current implementation with all three original entries:

```sh
python3 compare_all.py
```

Acquire the timing lock before running this command, back up `all-swift-results.json`, save the new results under a unique name, and restore the earlier file afterward. See [AGENTS.md](AGENTS.md) for the timing protocol.

This takes approximately 60 seconds of timed work plus compilation, downloads originals pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`, and replaces `all-swift-results.json` with the new measurements. Generated files stay under `.build`. Python only builds and launches executables; sieve and timed benchmark logic are Swift.

The earlier two-way comparison remains available through `compare.py` and `comparison-results.json`. The benchmark observer performs an opaque byte read and calculates no part of the sieve. The original Boolean implementation is compared only at one million, avoiding its known bounds issue at some other sizes.

## Validation

The earlier adopted B candidate `8f108f5` passed complete-array comparisons against an independent Boolean sieve with AddressSanitizer and the benchmark optimization flags, including every limit from −2 through 2,048, larger boundaries, one million, and ten million. Additional AddressSanitizer checks covered every limit 2,049–30,000, 500 random limits, and 1,561 prime-square cases. The unchanged phase verifier passed 16,511 partial/full checks over 1,501 limits under ASAN and WMO, including full-buffer equality to `19aa38a` with padding. Dense handlers are unchanged; assembly confirmed the separate word handler and real observer call. See the [verification record](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/sparse-stream-verification-8f108f5.json). Integration preserved the tested sieve and runner byte-for-byte.

```sh
mkdir -p .build
swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify
.build/verify
```

## Development branches

- `swift/baseline`: the original verified implementation at `25402d4`, preserved as a development control.
- `swift/stream-fusion`: the tested traversal experiment, retained as evidence rather than adopted.
- `swift/dense-small-factors`: the adopted implementation and current development branch.
- `swift/sparse-stream-loops`: experiment 8 history, preserving alternative A and adopted B.

Use separate branches for further optimizations. The target remains `base,faithful=yes`, one thread, and one million, with the same timing boundary and compiler settings. Wheel, cached-state, and parallel variants remain deferred. A future upstream submission should contain the proven change and required supporting files.

## License

The new code is provided under the included MIT license. Downloaded original comparison sources remain attributed to their repository authors.
