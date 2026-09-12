# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. Runtime-discovered factor 3 retains dense byte marking, and odd factors 5 through 63 retain dense 64-bit marking. This follow-up restores the previously tested 128-bit local handlers for every odd factor 65 through 127, dispatched only after the runtime candidate-bit test. Each multiple receives its own single-bit OR into a `SIMD2<UInt64>` lane. Factors above 127 retain the adopted sixteen-write fused loop, its optional eight-mark cleanup, and the scalar tail of at most seven marks. There is no presieving, cached sieve state, or wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding bits. The storage pointer must not outlive its sieve instance.

The comparison tags remain `algorithm=base,faithful=yes,bits=1`, with one thread. Small-factor specialization preserves runtime discovery and separate single-bit operations, following the approach documented in the [other-language review](reports/OtherLanguageOptimizationReview.md). The larger-factor loop uses the wrapping index arithmetic adopted in PR #4.

## Focused 128-bit wrapping-offset follow-up

Branch `swift/dense-128-wrapping-offset` starts from adopted sixteen-write development `e3f5a412d832e7fd25b1354dcf027e1dbf7ab29c`. Two source commits distinguish the unchanged 128-bit port (A) from the focused offset change (B). A is traceability only; the planned timing comparison is current development versus final B, after source, correctness and assembly checks. Verification, generator execution and timing for this follow-up are pending. No adoption is implied.

A reuses the exact 128-bit dispatch, helpers and generated switch from `307da10fe930e2bbdb46254770833026277e4cf3`, while preserving the adopted sixteen-write sparse code for factors above 127. B changes only the local chunk offset from `word * 16` to `word &* 16`, with the caller invariant `0 <= word < byteCount / 16`, hence `16 * word <= byteCount - 16`. The mathematical offset cannot overflow; whether omitting the overflow check improves generated code or throughput must be checked. No other tuning is included.

All odd cases 65 through 127 remain present, without precomputed prime lists or multi-bit composite masks. Individual marks peel from p² to a 128-bit boundary, complete groups mark p chunks, and an individual tail runs through the last allocated byte. Raw unaligned loads/stores and per-lane little-endian conversion preserve the original byte representation and B's padding, including factor 101's mark for 1,000,001 at limit 1,000,000. Fresh allocation, dense handlers 3–63, enumeration, benchmark and observer are unchanged. Classification remains source-based; the compiler may combine individual source operations.

The unchanged Swift generator can check the imported switch after acquiring the timing lock, from this directory:

```sh
swift tools/generate-dense-128.swift --check PrimeSieve.swift
```

It has not been run for this follow-up. `--write` remains available to regenerate only the marked block. ExtraVerify retains both previously reported boundary sets: 3,654 sparse-group limits and 11,382 wide alignment/group/tail limits, along with the original checks. The wide-boundary PhaseVerify extension also remains, while PhaseSieve itself stays the unchanged B reference. Its full raw-buffer comparison is useful for correctness, including padding; its timing copy is stale for this candidate and must not profile it.

The [original 128-bit review](reports/Dense128Review.md) measured `307da10` at 42.365 microseconds versus then-development at 40.044 microseconds, a regression. Its verification and assembly evidence explain this follow-up but do not validate or measure final B. The sixteen-write results below describe the adopted development control in an earlier session; do not combine those timings with new measurements.

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

The adopted development version tested two fused groups per sparse-loop iteration against adopted B at development `7509c87`. The bound `byte < end - r7 - p` protects the second group's last address; advancing by two groups leaves at most one complete eight-mark cleanup group. The scalar tail preserves B's byte-rounded padding behavior. Runtime factor discovery, factors 3–63, storage, benchmark and observer were unchanged.

Exact measured source **`59262fe`** delivered **1.24% more throughput**, saving **0.491 µs per sieve**: median **39.553 µs** versus development **40.044 µs**. Every candidate trial beat every development trial in one shared, rotated session on Apple M4 Pro / Swift 6.3.3, with three five-second runs each. The independent 128-bit candidate measured 42.365 µs in that session. Spotlight was near 99% CPU in both condition snapshots, so the exact percentages are provisional. This implementation was adopted through PR #12 in merge commit `83751ea`, which preserves the exact reviewed sieve, runner and observer.

Verify, ExtraVerify and PhaseVerify passed under both AddressSanitizer and optimized WMO, including 3,654 additional sparse-group boundaries and 34,983 phase checks over 1,521 limits with full-buffer equality and padding. These checks ran at `6679810`; final `59262fe` changes one comment only, independently reviewed with byte-identical recompiled assembly. The main loops use 51 instructions per sixteen marks, versus 54 for two B iterations; setup and cleanup still incur additional work. The real observer call and release remain. These counts do not isolate the cause of the measured gain.

[Review and decision](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/reports/SixteenWriteFusedReview.md), [raw results](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-results-59262fe-307da10.json), and [verification evidence](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-verification.json) are published for [PR #12](https://github.com/fahlman/Primes/pull/12). Those results describe the adopted development source, before this follow-up.

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

The project baseline is upstream **`PrimeSwift_1bitStriped_u8` at `22bfea9`**, the fastest of its three Swift entries in our shared-runner comparison. The session below measured the earlier `e8ba734`, adopted through [PR #4](https://github.com/fahlman/Primes/pull/4). It has not yet been repeated for adopted `59262fe`.


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

Those are historical development-control measurements, preserved in [all-swift-results.json](all-swift-results.json) and the [original report](reports/EqualTermsSwiftComparison.md). The later `e8ba734` was compared directly with all three upstream entries in the session above; adopted `59262fe` has only its recorded development comparison so far. Do not combine ratios across sessions.

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
