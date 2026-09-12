# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. The runtime-discovered factor 3 uses specialized byte marking: each individual composite bit is marked in a local byte, which is written back once. Factors 5 through 13 use the same approach on 64-bit words; 9 has a case but is never reached, because it's composite. Larger factors use eight fixed-mask streams with four writes per inner iteration. There is no presieving, cached sieve state, or wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding bits. The storage pointer must not outlive its sieve instance.

The comparison tags remain `algorithm=base,faithful=yes,bits=1`, with one thread. Small-factor specialization preserves runtime discovery and separate single-bit operations, following the approach documented in the [other-language review](reports/OtherLanguageOptimizationReview.md). The larger-factor loop is unchanged from our verified baseline.

## Run instructions

With Swift installed:

```sh
sh ./run.sh
```

The script compiles with `-O -whole-module-optimization` and runs fresh one-million sieves for at least five seconds. Build time, validation, enumeration, and printing are outside the timed interval. Allocation, initialization, marking, opaque observation, and release are inside every timed pass.

Example from the final entry-point check on Apple M4 Pro with Swift 6.3.3:

```text
fahlman_swift_dense_striped;60279;5.000052542;1;algorithm=base,faithful=yes,bits=1
```

Optional Docker build and run:

```sh
docker build -t faster-prime-swift .
docker run --rm faster-prime-swift
```

The Dockerfile uses official `swift:6.3.3` and `swift:6.3.3-slim` images. The image tags were checked for amd64 and arm64. Docker is not installed on the test Mac, so the container build and Linux runtime remain untested.

## Optimization results

Three rotated five-second runs per implementation, on the same Apple M4 Pro and Swift 6.3.3 toolchain, using one frozen benchmark runner and separately compiled observer:

| Implementation | Median milliseconds per pass | Throughput relative to saved baseline | Decision |
|---|---:|---:|---|
| Saved unrolled baseline | 0.119792 | 1.000x | Preserved |
| Eight fused marking streams | 0.121191 | 0.988x | Not adopted |
| Specialized factors 3, 5, and 7 | 0.082380 | 1.454x | Current implementation |

The retained change reduced time per sieve by 31.2%, or increased throughput by 45.4%, relative to the saved baseline in this comparison. Stream fusion did not demonstrate an improvement, so the two changes were not combined. All nine measured executions validated 78,498 primes and exited successfully. [Full results and reproduction commands](reports/OptimizationResults.md) are recorded with the [raw measurements](optimization-results.json).

## Original repository comparison

Before these experiments, our saved baseline beat all three repository Swift entries under the same allocation-to-release timing convention:

| Repository implementation | Baseline throughput advantage |
|---|---:|
| Boolean | 2.43x |
| Packed UInt8 | 2.91x |
| Striped UInt8 | 1.73x |

Those are historical baseline measurements, preserved in [all-swift-results.json](all-swift-results.json) and the [original report](reports/EqualTermsSwiftComparison.md). The current optimization was compared directly with our saved baseline; the original three entries were not rerun during this experiment.

To compare the current implementation with all three original entries:

```sh
python3 compare_all.py
```

This takes approximately 60 seconds of timed work plus compilation, downloads originals pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`, and replaces `all-swift-results.json` with the new measurements. Generated files stay under `.build`. Python only builds and launches executables; sieve and timed benchmark logic are Swift.

The earlier two-way comparison remains available through `compare.py` and `comparison-results.json`. The benchmark observer performs an opaque byte read and calculates no part of the sieve. The original Boolean implementation is compared only at one million, avoiding its known bounds issue at some other sizes.

## Validation

The baseline verification program was reused unchanged. Both candidates passed complete-array comparisons against an independent Boolean sieve for all limits from -2 through 2,048, larger square boundaries, one million, and ten million. Repeated marking preserved results. Both candidates passed the same checks with AddressSanitizer enabled.

```sh
mkdir -p .build
swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify
.build/verify
```

## Development branches

- `swift/baseline`: the original verified implementation at `25402d4`.
- `swift/stream-fusion`: the tested traversal experiment, retained as evidence rather than adopted.
- `swift/dense-small-factors`: the measured improvement and current development branch.

Use separate branches for further optimizations. The target remains `base,faithful=yes`, one thread, and one million, with the same timing boundary and compiler settings. Wheel, cached-state, and parallel variants remain deferred. A future upstream submission should contain the proven change and required supporting files.

## License

The new code is provided under the included MIT license. Downloaded original comparison sources remain attributed to their repository authors.
