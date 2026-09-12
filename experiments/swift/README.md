# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. The runtime-discovered factor 3 uses specialized byte marking: each individual composite bit is marked in a local byte, which is written back once. Factors 5 through 31 use the same approach on 64-bit words; the cases for the composite values 9, 15, 21, 25, and 27 are never reached. Larger factors use eight fixed-mask streams with four writes per inner iteration. There is no presieving, cached sieve state, or wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding bits. The storage pointer must not outlive its sieve instance.

The comparison tags remain `algorithm=base,faithful=yes,bits=1`, with one thread. Small-factor specialization preserves runtime discovery and separate single-bit operations, following the approach documented in the [other-language review](reports/OtherLanguageOptimizationReview.md). The larger-factor loop uses the wrapping index arithmetic adopted in PR #4.

## Run instructions

With Swift installed:

```sh
sh ./run.sh
```

The script compiles with `-O -whole-module-optimization` and runs fresh one-million sieves for at least five seconds. Build time, validation, enumeration, and printing are outside the timed interval. Allocation, initialization, marking, opaque observation, and release are inside every timed pass.

Example from the direct upstream comparison on Apple M4 Pro with Swift 6.3.3:

```text
fahlman_swift_dense_striped;84792;5.000039292;1;algorithm=base,faithful=yes,bits=1
```

Optional Docker build and run:

```sh
docker build -t faster-prime-swift .
docker run --rm faster-prime-swift
```

The Dockerfile uses official `swift:6.3.3` and `swift:6.3.3-slim` images. The image tags were checked for amd64 and arm64. Docker is not installed on the test Mac, so the container build and Linux runtime remain untested.

## Current results and project baseline

The project baseline is upstream **`PrimeSwift_1bitStriped_u8` at `22bfea9`**, the fastest of its three Swift entries in our shared-runner comparison. Our adopted implementation is `e8ba734`, merged through [PR #4](https://github.com/fahlman/Primes/pull/4).

| Implementation | Median milliseconds per pass | Our throughput advantage |
|---|---:|---:|
| Upstream Bool (`bits=8`) | 0.295470 | 4.98x |
| Upstream packed UInt8 (`bits=1`) | 0.347904 | 5.87x |
| Upstream striped UInt8 (`bits=1`), project baseline | 0.207650 | 3.50x |
| Adopted candidate (`bits=1`) | 0.059299 | — |

Three rotated five-second trials per implementation, Apple M4 Pro, Swift 6.3.3, same compiler flags and allocation-through-release Swift runner. All 12 executions validated 78,498 primes. Background desktop and backup activity makes the precise ratios provisional. These results compare adapted upstream kernels under the common runner. [Full report, adapter details, and reproduction](reports/UpstreamBaselineComparison.md); [raw results and provenance](upstream-baseline-e8ba734.json).

Our earlier implementations are **development controls**, including the historical `swift/baseline` branch. Comparisons against them measure each optimization's contribution and are separate from the upstream baseline. The combined candidate's earlier 38.72% gain was over development control `0d0a142`; wrapping added 9.48% over the combined word handlers alone. See the [combined review](https://github.com/fahlman/Primes/blob/8d773810e9d250076f332904169b3d540b7863db/experiments/swift/reports/CombinedReview.md).

Historical stream-fusion and dense-byte results remain in [OptimizationResults.md](reports/OptimizationResults.md) and [optimization-results.json](optimization-results.json). Those measurements and the original comparison below describe earlier versions.

## Original repository comparison

Before these experiments, our original development control beat all three repository Swift entries under the same allocation-to-release timing convention:

| Repository implementation | Original control throughput advantage |
|---|---:|
| Boolean | 2.43x |
| Packed UInt8 | 2.91x |
| Striped UInt8 | 1.73x |

Those are historical development-control measurements, preserved in [all-swift-results.json](all-swift-results.json) and the [original report](reports/EqualTermsSwiftComparison.md). The current candidate was compared directly with all three upstream entries in the newer session above; do not combine ratios across the two sessions.

To compare the current implementation with all three original entries:

```sh
python3 compare_all.py
```

Acquire the timing lock before running this command, back up `all-swift-results.json`, save the new results under a unique name, and restore the earlier file afterward. See [AGENTS.md](AGENTS.md) for the timing protocol.

This takes approximately 60 seconds of timed work plus compilation, downloads originals pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`, and replaces `all-swift-results.json` with the new measurements. Generated files stay under `.build`. Python only builds and launches executables; sieve and timed benchmark logic are Swift.

The earlier two-way comparison remains available through `compare.py` and `comparison-results.json`. The benchmark observer performs an opaque byte read and calculates no part of the sieve. The original Boolean implementation is compared only at one million, avoiding its known bounds issue at some other sizes.

## Validation

The adopted candidate passed complete-array comparisons against an independent Boolean sieve with AddressSanitizer and the benchmark optimization flags, including small limits, larger boundaries, one million, and ten million. Additional AddressSanitizer checks covered limits 2,049–20,000, 500 random limits, and 1,561 prime-square boundaries. See the [combined verification record](https://github.com/fahlman/Primes/blob/8d773810e9d250076f332904169b3d540b7863db/experiments/swift/combined-verification-e8ba734.json).

```sh
mkdir -p .build
swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify
.build/verify
```

## Development branches

- `swift/baseline`: the original verified implementation at `25402d4`, preserved as a development control.
- `swift/stream-fusion`: the tested traversal experiment, retained as evidence rather than adopted.
- `swift/dense-small-factors`: the measured improvement and current development branch.

Use separate branches for further optimizations. The target remains `base,faithful=yes`, one thread, and one million, with the same timing boundary and compiler settings. Wheel, cached-state, and parallel variants remain deferred. A future upstream submission should contain the proven change and required supporting files.

## License

The new code is provided under the included MIT license. Downloaded original comparison sources remain attributed to their repository authors.
