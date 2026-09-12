# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. Runtime-discovered factor 3 retains dense byte marking, and odd factors 5 through 63 retain dense 64-bit marking. The adopted implementation uses the 128-bit local handlers for every odd factor 65 through 111, dispatched only after the runtime candidate-bit test. Each multiple receives its own single-bit OR into a `SIMD2<UInt64>` lane. Factors above 111 retain the adopted sixteen-write fused loop, its optional eight-mark cleanup, and the scalar tail of at most seven marks. There is no presieving, cached sieve state, or wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding bits. The storage pointer must not outlive its sieve instance.

The comparison tags remain `algorithm=base,faithful=yes,bits=1`, with one thread. Small-factor specialization preserves runtime discovery and separate single-bit operations, following the approach documented in the [other-language review](reports/OtherLanguageOptimizationReview.md). The larger-factor loop uses the wrapping index arithmetic adopted in PR #4.

## 128-bit cutoff sweep

Cutoff 111, exact measured source `099e35afa8a2f01d79ef11f805d760e81d1d983a`, is adopted through [PR #16](https://github.com/fahlman/Primes/pull/16) in merge commit `380a942`. It incorporates PR #14's 128-bit marking and proven-safe wrapping byte offsets, with handlers ending at 111. Factors above 111 use the retained sixteen-write sparse loop. The 79 and 95 variants were not selected, and the earlier 127 configuration is superseded. The verifiers retain their 65–127 boundary limits, including factors now handled by the sparse loop. The recorded comparison and its limits are summarized below.

## Focused 128-bit wrapping-offset follow-up

Exact candidate **`bd3858cac9a306aa3b8d4729cf059959a7c70885`** delivered **3.36% more throughput**, saving **1.316 µs per sieve**: median **39.116 µs** versus adopted sixteen-write development **40.432 µs** at `e3f5a412d832e7fd25b1354dcf027e1dbf7ab29c`. Every candidate trial beat every development trial in one rotated session on Apple M4 Pro / Swift 6.3.3, with three five-second runs each. All six trials validated correctly. Before/after snapshots found no competing builds, tests, benchmarks or audio assertions, but background desktop activity and a single session limit precision. PR #14's marking and wrapping work is incorporated through PR #16 with cutoff 111; these measurements describe the earlier 127 configuration.

Branch `swift/dense-128-wrapping-offset` has two source commits: the unchanged 128-bit port A (`63ff55cd77b47e6c906e801cf22bb9113fa5c080`) and focused offset change B (`bd3858c`). A is traceability only and was not timed. The comparison measured development versus final B; it does not isolate wrapping's throughput contribution. [Review and measured result](https://github.com/fahlman/Primes/blob/40900ef9fef5253f60e030af1ec872aa37f6892e/experiments/swift/reports/Dense128WrappingOffsetReview.md), [raw results](https://github.com/fahlman/Primes/blob/40900ef9fef5253f60e030af1ec872aa37f6892e/experiments/swift/dense-128-offset-results-bd3858c.json), and [verification and assembly evidence](https://github.com/fahlman/Primes/blob/40900ef9fef5253f60e030af1ec872aa37f6892e/experiments/swift/dense-128-offset-verification.json) are permanently linked at the evidence commit. The separate [upstream comparison](https://github.com/fahlman/Primes/blob/599821c1a259976fd44837c17bc618199985bf1a/experiments/swift/reports/CurrentUpstreamSwiftComparison.md), summarized below, is now published. The earlier 127 configuration has its own [Linux validation record](https://github.com/fahlman/Primes/blob/e5b94328376efaea77f9faab3979c181ea3fe234/experiments/swift/reports/LinuxDockerValidation.md); its coverage remains specific to `bd3858c`. Cutoff111 has a separate exact-revision validation linked below.

A reuses the exact 128-bit dispatch, helpers and generated switch from `307da10fe930e2bbdb46254770833026277e4cf3`, while preserving the adopted sixteen-write sparse code for factors above 127. B changes only the local chunk offset from `word * 16` to `word &* 16`, with the caller invariant `0 <= word < byteCount / 16`, hence `16 * word <= byteCount - 16`. The mathematical offset cannot overflow. Independent source and assembly reviews found no blockers before timing. All 3,072 per-chunk overflow checks and traps disappeared; the vector helper fell from 36,370 to 12,847 static instructions and from 4,619 to 1,669 stack-access instructions. The frame grew from 1,056 to 1,280 bytes, while every runtime-prime main loop had fewer stack accesses. No new helper calls appeared, and real sieve, observer and release calls remain. These counts do not isolate the cause of the measured gain. No other tuning is included.

In `bd3858c`, all odd cases 65 through 127 are present, without precomputed prime lists or multi-bit composite masks. Individual marks peel from p² to a 128-bit boundary, complete groups mark p chunks, and an individual tail runs through the last allocated byte. Raw unaligned loads/stores and per-lane little-endian conversion preserve the original byte representation and B's padding, including factor 101's mark for 1,000,001 at limit 1,000,000. Fresh allocation, dense handlers 3–63, enumeration, benchmark and observer are unchanged. Classification remains source-based; the compiler may combine individual source operations.

The canonical Swift generator, `tools/generate-dense.swift`, produces both current explicit switches: 30 odd cases and 1,020 helper calls for 64-bit factors 5–63, plus 24 odd cases and 2,112 helper calls for 128-bit factors 65–111. In chunk j, the first bit is `(-width * j) mod p`; every odd factor has a case, with no primality test or composite mask in the generator. After acquiring the timing lock, run from this directory:

```sh
swift tools/generate-dense.swift --check PrimeSieve.swift
swift tools/generate-dense.swift --write PrimeSieve.swift
```

`--check` compares both complete marked blocks, including formatting. `--write` replaces only those blocks and writes once after locating both marker pairs. With no arguments, it prints both blocks. The old `tools/generate-dense-128.swift` path remains a forwarding wrapper for existing validation commands; it now operates on both blocks too. Historical recorded tool hashes remain tied to their original commits.

The `swift/dense-generator` refactor adds only the two 64-bit marker comments to `PrimeSieve.swift`. Removing those lines reproduces adopted development `1d05221` byte for byte; the explicit calls, runtime helpers, alignment peels, tails, allocation, runner, observer, and verifiers are unchanged. Source comparisons cover both generated blocks. Swift execution of the new generator remains pending central review; no build, test, timing, or performance claim accompanies this refactor.

At historical cutoff 127 `bd3858c`, the old 128-bit generator's `--check` passed for all 32 cases and 3,072 calls. The rest of this paragraph describes that earlier candidate's local verification; its generator's `--write` was not run for that follow-up. Verify passed under AddressSanitizer and optimized WMO. ExtraVerify passed under ASAN, retaining the original exhaustive, random and prime-square checks plus 3,654 sparse-group limits and 11,382 wide alignment/group/tail limits. PhaseVerify passed under WMO with 53,015 partial/full checks over 2,305 limits, including complete raw-buffer equality and padding. ExtraVerify WMO and PhaseVerify ASAN were not added to this local bracket. PhaseSieve stays the unchanged earlier B reference; its timing copy is stale for this candidate and must not profile it.

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

The Dockerfile uses official `swift:6.3.3` and `swift:6.3.3-slim` images. Its unchanged build and runtime passed on native Linux amd64 and arm64 for the earlier cutoff-127 source **`bd3858c` in PR #14**. Verify, ExtraVerify and PhaseVerify each passed under ASAN and WMO on both architectures. Amd64 coverage combines five checks from the original job with the final PhaseVerify WMO check from a focused follow-up after the original 45-minute limit interrupted compilation. Compilation dominated the elapsed time; the original timeout and all successful evidence are preserved in the [Linux validation report](https://github.com/fahlman/Primes/blob/e5b94328376efaea77f9faab3979c181ea3fe234/experiments/swift/reports/LinuxDockerValidation.md). This coverage applies to that candidate revision. Docker has not been installed or run locally as part of this work; hosted results establish correctness and compatibility only.

Exact adopted cutoff 111 `099e35a` separately passed the unchanged Docker build/runtime and all six correctness checks on native Linux amd64 and arm64. [Report and immutable raw evidence](https://github.com/fahlman/Primes/blob/a196d5e609a29ff65efbb8bc43c0d61c2d6a33e9/experiments/swift/reports/Cutoff111LinuxValidation.md). This verifies the actual adopted source; it makes no Linux performance claim.

## Sixteen-write sparse-loop history

In PR #12, the adopted change used two fused groups per sparse-loop iteration, measured against the earlier B development control `7509c87`. The bound `byte < end - r7 - p` protects the second group's last address; advancing by two groups leaves at most one complete eight-mark cleanup group. The scalar tail preserves B's byte-rounded padding behavior. Runtime factor discovery, factors 3–63, storage, benchmark and observer are unchanged.

Exact measured source **`59262fe`** delivered **1.24% more throughput**, saving **0.491 µs per sieve**: median **39.553 µs** versus development **40.044 µs**. Every candidate trial beat every development trial in one shared, rotated session on Apple M4 Pro / Swift 6.3.3, with three five-second runs each. The independent 128-bit candidate measured 42.365 µs in that session. Spotlight was near 99% CPU in both condition snapshots, so the exact percentages are provisional. This implementation was adopted through PR #12 in merge commit `83751ea`, which preserves the exact reviewed sieve, runner and observer.

Verify, ExtraVerify and PhaseVerify passed under both AddressSanitizer and optimized WMO, including 3,654 additional sparse-group boundaries and 34,983 phase checks over 1,521 limits with full-buffer equality and padding. These checks ran at `6679810`; final `59262fe` changes one comment only, independently reviewed with byte-identical recompiled assembly. The main loops use 51 instructions per sixteen marks, versus 54 for two B iterations; setup and cleanup still incur additional work. The real observer call and release remain. These counts do not isolate the cause of the measured gain.

[Review and decision](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/reports/SixteenWriteFusedReview.md), [raw results](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-results-59262fe-307da10.json), and [verification evidence](https://github.com/fahlman/Primes/blob/1bf1be7f46d3ab716c236a3ddc4c4b0a6d35eabf/experiments/swift/sparse-next-verification.json) are published for [PR #12](https://github.com/fahlman/Primes/pull/12). Those results describe the adopted development source, before this follow-up.

The diagnostic copy still describes B. Its full-buffer verifier provides a reference for this candidate, but its timings do not profile the sixteen-write loop. The historical results below describe adopted or earlier versions and are separate from this session.

## Current results and project baseline

The adopted implementation is **cutoff 111, source `099e35a`**, integrated through [PR #16](https://github.com/fahlman/Primes/pull/16). It uses dense byte marking for 3, 64-bit handlers for 5–63, 128-bit handlers for 65–111, and sixteen-write sparse marking above 111.

| Same-session comparison | Median µs per sieve |
|---|---:|
| Then-adopted development control `f6b5c5b` (through 63) | 39.843 |
| Earlier cutoff 127 `bd3858c` | 38.642 |
| Adopted cutoff 111 `099e35a` | **38.434** |

Cutoff 111 delivered **3.667% more throughput**, saving **1.409 µs** against the then-adopted development control. Against 127 in the same session, it gained **0.540%** and saved **0.208 µs**. Every 111 trial beat every trial of both controls. Its separation from 127 was only 0.036377 µs; the registered non-overlap screen is not a significance test. [Review and immutable measurements](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md). The earlier PR #12 results remain preserved in the preceding history section and their linked records.

The [phase diagnostic](tools/phase-split/README.md) still copies earlier B (`8f108f5`). Its full-buffer comparison remains a correctness reference, but the [historical breakdown](reports/FusedSparseBandBreakdown.md) does not profile this implementation. Normalized source equality is required before using a diagnostic copy for current phase timings.

## Latest follow-up experiments

[PR #16](https://github.com/fahlman/Primes/pull/16)'s cutoff 111 (`099e35a`) passed the agreed timing screen against cutoff 127 (`bd3858c`): **38.434 versus 38.642 µs**, **0.540% more throughput**, saving **0.208 µs per sieve**. Every trial was faster, but the trial ranges are separated by only 0.036377 µs. Single benchmark builds took **45.378 versus 114.492 seconds** on the Mac. The same session measured adopted development63 at 39.843 µs; cutoff 111 gains 3.667% and saves 1.409 µs against that control. Cutoff79 was slower than127, and cutoff95 overlapped it.

A separate session against the exact 127 source found thirty-two sparse writes ([#17](https://github.com/fahlman/Primes/pull/17), `af83aa1`) **6.705% lower throughput**, the square-root discovery bound ([#18](https://github.com/fahlman/Primes/pull/18), `76d82c2`) **flat**, and atomic sparse marks ([#19](https://github.com/fahlman/Primes/pull/19), `e889cd6`) **60.168% lower throughput**. None qualifies for integration on this evidence. All 27 five-second runs validated, under the timing lock with independent audits, on Apple M4 Pro / Swift 6.3.3. Endpoint conditions and the initial audio-preflight stop are preserved. Three rotations are not fully position-balanced; the screen is not a significance test.

PR #18 was then retested on adopted cutoff 111: `968c249` measured **39.115 µs** against development `6f989ee` at **39.255 µs**, a median **0.358%** throughput increase saving **0.140 µs**. The trial ranges overlap, so it remains **flat under the agreed admission rule; closed as tested and rejected, without merging**. All six local correctness checks and all six benchmark runs passed; wrapper recovery and independent audits are preserved in the [new report](https://github.com/fahlman/Primes/blob/31222e494667049240bb2fa3131d6af3acdd3f63/experiments/swift/reports/DiscoveryBound111Review.md). This is a separate session from the cutoff-127 measurements above.

Cutoff111 is adopted through PR #16. PR #17, #18 and #19 were tested and closed as rejected without merging; their branches and all reports/raw evidence are preserved. The integration includes PR #14's underlying marking and wrapping work with the 111 cutoff; the historical 127 configuration is superseded. These results establish neither Linux performance nor a new direct upstream ratio. [Review, raw results, compiler records and provenance](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md).

## Most recent direct upstream comparison

The candidate in the latest direct upstream comparison is **historical cutoff 127 `bd3858c` from [PR #14](https://github.com/fahlman/Primes/pull/14)**. It adds the 128-bit handlers for odd factors 65–127 to the adopted sixteen-write loop, with provably safe wrapping byte offsets. Its direct development comparison measured **39.116 µs** versus `e3f5a41` at **40.432 µs**, **3.36% more throughput**, saving **1.316 µs per sieve**. Every candidate trial beat every development trial. [Review](reports/Dense128WrappingOffsetReview.md), [raw results](dense-128-offset-results-bd3858c.json), [verification](dense-128-offset-verification.json). The port parent was not timed, so this does not isolate wrapping's contribution.

A separate fresh session compared that exact candidate with all three upstream entries. The project baseline remains **`PrimeSwift_1bitStriped_u8` at `22bfea9`**, the fastest upstream implementation.

| Implementation | Median µs per sieve | Candidate throughput ratio |
|---|---:|---:|
| Upstream Bool (`bits=8`) | 290.055 | 7.44x |
| Upstream packed UInt8 (`bits=1`) | 349.419 | 8.96x |
| Upstream striped UInt8 (`bits=1`), project baseline | 207.191 | **5.31x** |
| Historical cutoff 127 `bd3858c` (`bits=1`) | **39.000** | — |

Three rotated five-second trials per implementation, Apple M4 Pro, Swift 6.3.3, identical compiler flags and allocation-through-release Swift runner. All 12 executions validated 78,498 primes, and every candidate trial beat every upstream trial. Spotlight activity before compilation makes the exact ratios provisional; snapshots do not establish activity during individual trials. Three rounds do not fully balance four execution positions. These are adapted upstream kernels under a common runner at one million, not the original CLI executables or Threadripper measurements. [Report and adapter details](reports/CurrentUpstreamSwiftComparison.md), [raw results](upstream-current-bd3858c.json), [provenance](upstream-current-bd3858c-verification.json).

The earlier `e8ba734` comparison remains preserved in its [report](reports/UpstreamBaselineComparison.md) and [raw record](upstream-baseline-e8ba734.json). The adopted source is cutoff 111 `099e35a`. The most recent direct upstream result belongs to cutoff 127 `bd3858c`; its 5.31x ratio has not been measured for 111.

Our earlier implementations are **development controls**, including the historical `swift/baseline` branch. Comparisons against them measure each optimization's contribution and are separate from the upstream baseline. The combined candidate's earlier 38.72% gain was over development control `0d0a142`; wrapping added 9.48% over the combined word handlers alone. See the [combined review](https://github.com/fahlman/Primes/blob/8d773810e9d250076f332904169b3d540b7863db/experiments/swift/reports/CombinedReview.md).

Historical stream-fusion and dense-byte results remain in [OptimizationResults.md](reports/OptimizationResults.md) and [optimization-results.json](optimization-results.json). Those measurements and the original comparison below describe earlier versions.

## Original repository comparison

Before these experiments, our original development control beat all three repository Swift entries under the same allocation-to-release timing convention:

| Repository implementation | Original control throughput advantage |
|---|---:|
| Boolean | 2.43x |
| Packed UInt8 | 2.91x |
| Striped UInt8 | 1.73x |

Those are historical development-control measurements, preserved in [all-swift-results.json](all-swift-results.json) and the [original report](reports/EqualTermsSwiftComparison.md). The later `e8ba734` and cutoff 127 `bd3858c` each have their own direct upstream comparison; then-adopted `59262fe` has its recorded development comparison. Cutoff111 has its latest comparison against development controls. Do not combine ratios across sessions.

To compare the current implementation with all three original entries:

```sh
python3 compare_all.py
```

Acquire the timing lock before running this command, back up `all-swift-results.json`, save the new results under a unique name, and restore the earlier file afterward. See [AGENTS.md](AGENTS.md) for the timing protocol.

This takes approximately 60 seconds of timed work plus compilation, downloads originals pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`, and replaces `all-swift-results.json` with the new measurements. Generated files stay under `.build`. Python only builds and launches executables; sieve and timed benchmark logic are Swift.

The earlier two-way comparison remains available through `compare.py` and `comparison-results.json`. The benchmark observer performs an opaque byte read and calculates no part of the sieve. The original Boolean implementation is compared only at one million, avoiding its known bounds issue at some other sizes.

## Validation

For exact cutoff 111 `099e35a`, see [the cutoff-sweep review](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md) for local reported-check provenance and independent source review, and [the exact-revision Linux report](https://github.com/fahlman/Primes/blob/a196d5e609a29ff65efbb8bc43c0d61c2d6a33e9/experiments/swift/reports/Cutoff111LinuxValidation.md) for the new native full-suite execution evidence. Historically, adopted candidate `8f108f5` passed complete-array comparisons against an independent Boolean sieve with AddressSanitizer and the benchmark optimization flags, including every limit from −2 through 2,048, larger boundaries, one million, and ten million. Additional AddressSanitizer checks covered every limit 2,049–30,000, 500 random limits, and 1,561 prime-square cases. Its phase verifier passed 16,511 partial/full checks over 1,501 limits under ASAN and WMO, including full-buffer equality to `19aa38a` with padding. Assembly confirmed the separate word handler and real observer call. See that earlier [verification record](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/sparse-stream-verification-8f108f5.json). Integration preserved its tested sieve and runner byte-for-byte.

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
