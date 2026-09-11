# Swift solution by fahlman

This is a single-threaded, class-owned, odd-only Sieve of Eratosthenes. It stores one composite flag per bit and allocates fresh runtime-sized storage for every pass. It uses eight interleaved marking streams per prime, with a fixed mask in each stream, and unrolls the inner loop into four individual writes. It does not use pre-sieving, cached prime results, or a wheel.

`PrimeSieve.swift` is the reusable implementation. Construct `PrimeSieve(limit:)`, call `runSieve()`, then call `primes()` to obtain the inclusive prime list or `withStorage` to inspect the completed flags. Bit index zero represents 3; a set bit means composite. Padding bits must be ignored. A pointer passed into `withStorage` must not outlive its sieve instance.

The declared comparison tags are `algorithm=base,faithful=yes,bits=1`, with one thread. The base classification follows the repository's existing striped UInt8 implementation. This README describes the actual striped traversal so it can be reviewed independently.

## Run instructions

With Swift installed:

```sh
sh ./run.sh
```

The script compiles with `-O -whole-module-optimization` and runs fresh one-million sieves for at least five seconds. Build time and validation are outside the measured interval. Result output goes to stdout; validation/checksum details go to stderr.

Optional Docker build and run:

```sh
docker build -t faster-prime-swift .
docker run --rm faster-prime-swift
```

The Dockerfile uses the official `swift:6.3.3` and `swift:6.3.3-slim` images. Both tags were checked to exist for amd64 and arm64. Docker is not installed on the test Mac, so the container build and Linux runtime have not been tested.

## Output

One measured run on Apple M4 Pro, Apple Swift 6.3.3, arm64 macOS:

```text
fahlman_swift_striped_unrolled;41508;5.000106084;1;algorithm=base,faithful=yes,bits=1
```

## Comparison

The implementation beats all three repository Swift implementations in this local comparison. All four use `algorithm=base`, `faithful=yes`, and one thread. The original Boolean entry uses eight bits per flag; the other three use one bit per flag.

Apple M4 Pro, Apple Swift 6.3.3, arm64 macOS. All entries compiled with `-O -whole-module-optimization`. Each calculates the sieve through one million. Results are medians of three rotated runs per implementation, each lasting at least five seconds.

| Implementation | Median milliseconds per pass | Our throughput advantage |
|---|---:|---:|
| Repository: Boolean | 0.292488 | 2.43× |
| Repository: packed UInt8 | 0.351134 | 2.91× |
| Repository: striped UInt8 | 0.208603 | 1.73× |
| Our unrolled Swift | 0.120461 | — |

The timed workload includes fresh allocation, initialization, sieving, an opaque observation, and release on every pass. It excludes prime enumeration, output-array construction, and printing. `BenchmarkObserver.swift` is separately compiled Swift code that reads a runtime-selected byte, preventing the optimizer from removing sieve stores. The same observer and runner are used for every implementation. It calculates no part of the sieve.

Repository sources are pinned to commit `22bfea9c7122c46dcda799020fccf5ae83fe667f`. Allocation and marking loops are unchanged. The comparison removes each CLI/stopwatch, places equivalent packed-mask initialization in a lazy closure, and adds storage access/validation adapters. One-time mask initialization occurs before timing. The original Boolean algorithm is tested only at one million here, which avoids its known bounds issue at some other sizes.

Every runner validates the expected 78,498 primes before timing. Complete-array comparisons and AddressSanitizer validation of the unrolled implementation also passed, as described below.

Reproduce the all-three comparison (approximately 60 seconds of timed work, plus compilation):

```sh
python3 compare_all.py
```

The script downloads the pinned original sources, compiles all four programs with identical settings, and saves every raw run in `all-swift-results.json`. Generated sources and binaries live under `.build`. All benchmark logic is Swift; Python only builds and launches the independent executables.

The earlier two-way comparison remains reproducible with `python3 compare.py` and its original `comparison-results.json`.

[Repository Swift implementations](https://github.com/PlummersSoftwareLLC/Primes/tree/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeSwift/solution_1)

## Validation

Full prime arrays matched an independent ordinary Boolean sieve for every limit from -2 through 2,048, larger prime-square boundaries, one million, and ten million. Known counts matched 78,498 and 664,579. Repeated marking preserved the same results. This pass also ran with AddressSanitizer enabled and completed without errors.

Run verification on a toolchain supporting AddressSanitizer:

```sh
mkdir -p .build
swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify
.build/verify
```

## License

The new code is provided under the included MIT license. The original baseline source downloaded by `compare.py` remains attributed to its repository authors.

## Development baseline

This directory preserves the verified implementation and recorded measurements before further optimization. The baseline branch is `swift/baseline`, based on upstream commit `22bfea9c7122c46dcda799020fccf5ae83fe667f`.

The current target remains `algorithm=base,faithful=yes`, one thread, and a sieve limit of one million. Every timed pass includes fresh allocation, initialization, sieving, and release; prime enumeration is outside the timed interval. Retain the same compiler settings and observer when comparing implementations.

Create a separate branch from this baseline for each optimization. The first candidates are stream fusion and specialized dense marking, evaluated independently before combining changes. Wheel, cached-state, and parallel variants remain deferred. A future upstream submission should contain the proven change and required supporting files.

- [Equal-terms comparison](reports/EqualTermsSwiftComparison.md)
- [Review of other-language optimizations](reports/OtherLanguageOptimizationReview.md)

The source, verification program, benchmark tools, and recorded result files were copied without changes from the working package. These results describe the earlier measurements; repository setup did not rerun the full comparison. The Docker build remains untested.
