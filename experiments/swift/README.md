# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. The runtime-discovered factor 3 uses specialized byte marking: each individual composite bit is marked in a local byte, which is written back once. Odd factors 5 through 63 retain the adopted 64-bit handlers. This candidate adds 128-bit local chunks for every odd factor 65 through 127, dispatched only after the same runtime candidate test; composite cases are included but never reached. Each multiple receives its own single-bit OR into a `SIMD2<UInt64>` lane before the chunk is stored. Factors above 127 retain the adopted fused sparse loop, marking eight successive multiples per iteration. There is no presieving, cached sieve state, or wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding bits. The storage pointer must not outlive its sieve instance.

The comparison tags remain `algorithm=base,faithful=yes,bits=1`, with one thread. Classification rests on the source: every multiple has an individual single-bit OR even if the compiler merges operations. Small-factor specialization preserves runtime discovery, following the approach documented in the [other-language review](reports/OtherLanguageOptimizationReview.md). The larger-factor loop uses the wrapping index arithmetic adopted in PR #4.

## 128-bit handler candidate

**This implementation regressed; retain development for this experiment.** Exact candidate `307da10fe930e2bbdb46254770833026277e4cf3` completed generator checking, compilation, correctness checks, independent source and assembly review, and one shared timing session. It starts from development `7509c8791f6d35e5a354a77060756afdd5dd8391`, whose sieve is adopted B `8f108f5`. No adoption or merge is part of this evaluation.

| Shared-session variant | Median microseconds per pass |
|---|---:|
| Development control `7509c87` | 40.044 |
| Independent sixteen-write candidate `59262fe` | 39.553 |
| This 128-bit candidate `307da10` | 42.365 |

The 128-bit candidate delivered **5.48% less throughput** than development and took **2.321 microseconds more per pass**. Every 128-bit trial was slower than every development trial. All nine rotated runs validated correctly on Apple M4 Pro with Swift 6.3.3 and identical benchmark settings. Spotlight was near 99% CPU in the before/after snapshots, so exact percentages remain provisional. This comparison evaluates this implementation, not every possible 128-bit handler. See the [review and full methodology](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/reports/Dense128Review.md) and [raw timing samples](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-results-59262fe-307da10.json). The historical comparisons later in this README describe earlier sessions and implementations.

The new path marks from p² to a 128-bit boundary individually, then handles complete groups of p chunks, then marks the remaining tail individually. Every generated odd case from 65 through 127 supplies the first bit offset `(-128*j) mod p` for chunk j. There are no mask tables or precombined composite masks. Unaligned raw loads and stores preserve the byte allocation, and each UInt64 lane is converted from/to little-endian. The peel and tail extend through the last allocated byte, retaining B's padding bits, including factor 101's mark for 1,000,001 at limit 1,000,000.

`SIMD2<UInt64>` avoids requiring UInt128's newer macOS availability. Assembly inspection found 1,024 vector ORs in the new helper, but also offset-overflow checks and substantial spills/reloads; the helper contains 36,370 static instructions. These observations do not isolate the cause of the regression. The benchmark, observer, allocation, enumeration, byte-3 handler and 64-bit handlers are unchanged.

The auditable Swift generator changes only its marked switch block. It covers every odd value without testing primality. After acquiring the timing lock, run from this directory:

```sh
swift tools/generate-dense-128.swift --check PrimeSieve.swift
swift tools/generate-dense-128.swift --write PrimeSieve.swift
```

The `--check` command passed, confirming that the generated switch matches the committed source; `--write` was not run. Verify, ExtraVerify and PhaseVerify all passed under both `-O -sanitize=address` and `-O -whole-module-optimization`. ExtraVerify included 11,382 additional deduplicated alignment, full-group and tail limits. PhaseVerify passed 53,015 checks over 2,305 limits, including full raw-buffer equality with unchanged adopted B and its padding bits. Independent source and assembly reviews reported no blocking findings. Exact commands, outputs, source and assembly hashes, and review links are in the [verification record](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-verification.json). The unchanged B phase copy remains stale for timing this candidate.

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

## Current results and project baseline

The adopted implementation is **experiment 8B, `8f108f5`**, merged through [PR #11](https://github.com/fahlman/Primes/pull/11) as `703dc12`. It retains the dense handlers through 63 and uses fused streams for larger factors. The merge preserves the reviewed commits and produces B's exact source.

| Latest development comparison | Median milliseconds per pass |
|---|---:|
| Development control `4483965` | 0.043259 |
| Alternative 8A, eight writes per stream `47b4af1` | 0.042549 |
| Adopted 8B, fused sparse streams `8f108f5` | **0.040806** |

B delivered **6.01% more throughput than development**, saving **2.453 µs per sieve**, and **4.27% more throughput than A**. All nine runs in this rotated M4 Pro / Swift 6.3.3 session validated correctly, and every B trial beat every A and development trial. Desktop activity makes exact percentages provisional; instruction counts do not isolate the cause of the gains. See the [review](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/reports/SparseStreamExperiment8Review.md), [raw results](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/sparse-stream-results-8f108f5.json), and [verification evidence](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/sparse-stream-verification-8f108f5.json).

The [phase diagnostic](tools/phase-split/README.md) still copies adopted B and is stale for timing this branch's 128-bit candidate. It remains a useful correctness reference through the verifier's full-buffer comparison. Do not use its unchanged cumulative timing copy to profile this candidate. The [refreshed B breakdown](reports/FusedSparseBandBreakdown.md) measured copied full at 39.962 µs versus production at 40.183 µs, passing the predefined 3% control; approximately 67.5% lay in B's sparse factors 67–997. Those estimates describe B in a separate session, not this candidate. A timing copy's normalized source must match production before profiling; identical output flags alone do not prove timing-code fidelity. Earlier reports remain historical evidence.

## Most recent direct upstream comparison

The project baseline is upstream **`PrimeSwift_1bitStriped_u8` at `22bfea9`**, the fastest of its three Swift entries in our shared-runner comparison. The session below measured the earlier `e8ba734`, adopted through [PR #4](https://github.com/fahlman/Primes/pull/4). It has not been repeated for adopted `8f108f5`.


| Implementation | Median milliseconds per pass | e8ba734 throughput advantage |
|---|---:|---:|
| Upstream Bool (`bits=8`) | 0.295470 | 4.98x |
| Upstream packed UInt8 (`bits=1`) | 0.347904 | 5.87x |
| Upstream striped UInt8 (`bits=1`), project baseline | 0.207650 | 3.50x |
| Earlier candidate `e8ba734` (`bits=1`) | 0.059299 | — |

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

Those are historical development-control measurements, preserved in [all-swift-results.json](all-swift-results.json) and the [original report](reports/EqualTermsSwiftComparison.md). The later `e8ba734` was compared directly with all three upstream entries in the session above; adopted `8f108f5` has only the recorded development comparison so far. Do not combine ratios across sessions.

To compare the current implementation with all three original entries:

```sh
python3 compare_all.py
```

Acquire the timing lock before running this command, back up `all-swift-results.json`, save the new results under a unique name, and restore the earlier file afterward. See [AGENTS.md](AGENTS.md) for the timing protocol.

This takes approximately 60 seconds of timed work plus compilation, downloads originals pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`, and replaces `all-swift-results.json` with the new measurements. Generated files stay under `.build`. Python only builds and launches executables; sieve and timed benchmark logic are Swift.

The earlier two-way comparison remains available through `compare.py` and `comparison-results.json`. The benchmark observer performs an opaque byte read and calculates no part of the sieve. The original Boolean implementation is compared only at one million, avoiding its known bounds issue at some other sizes.

## Validation

The adopted candidate `8f108f5` passed complete-array comparisons against an independent Boolean sieve with AddressSanitizer and the benchmark optimization flags, including every limit from −2 through 2,048, larger boundaries, one million, and ten million. Additional AddressSanitizer checks covered every limit 2,049–30,000, 500 random limits, and 1,561 prime-square cases. The unchanged phase verifier passed 16,511 partial/full checks over 1,501 limits under ASAN and WMO, including full-buffer equality to `19aa38a` with padding. Dense handlers are unchanged; assembly confirmed the separate word handler and real observer call. See the [verification record](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/sparse-stream-verification-8f108f5.json). Integration preserved the tested sieve and runner byte-for-byte.

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
