# Swift sieve by fahlman

This folder contains the current experimental implementation, development tools and selected reports. Individual changes, reviews and adoption decisions live in the [fork's pull requests](https://github.com/fahlman/Primes/pulls?q=is%3Apr). Historical raw records are preserved in the [evidence snapshot](https://github.com/fahlman/Primes/tree/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift), retained on `archive/swift-evidence`.

## Current implementation

`PrimeSieve.swift` implements a single-threaded, class-owned, odd-only Sieve of Eratosthenes. Construct `PrimeSieve(limit:)`, call `runSieve()`, then use `primes()` for the inclusive prime list or `withStorage` to inspect flags. Bit zero represents 3; a set bit means composite. Enumeration ignores padding. The storage pointer must not outlive the sieve.

Every pass allocates and initializes fresh runtime-sized storage, discovers factors from the sieve, and marks their multiples individually starting at p². Factor 3 uses dense byte marking, odd factors 5–63 use 64-bit handlers, odd factors 65–111 use 128-bit handlers, and larger factors use the sixteen-write fused sparse loop. Every odd value in each specialized range has a case; dispatch happens only after the runtime candidate-bit test. There is no presieving, wheel, cached sieve state or precomputed primality. The compiler may combine individual source operations into wider stores. Classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

The adopted cutoff is 111, measured at source `099e35a` and integrated through [PR #16](https://github.com/fahlman/Primes/pull/16). Subsequent maintenance includes the generator [#21](https://github.com/fahlman/Primes/pull/21), current-source profiling [#24](https://github.com/fahlman/Primes/pull/24), authoring template [#26](https://github.com/fahlman/Primes/pull/26) and shared storage sizing [#27](https://github.com/fahlman/Primes/pull/27). The latter preserves complete benchmark assembly against `84d8a4f`; it introduces no new throughput result.

## Build and run

Use Swift 6.3.3. Run commands from this directory and acquire `/tmp/primes-timing.lock` under the [working rules](AGENTS.md#timing-sessions) before compiling, testing or benchmarking.

```sh
sh ./run.sh
```

The runner uses `-O -whole-module-optimization`, a separately compiled opaque observer, limit 1,000,000 and at least five seconds. Each pass times allocation, initialization, marking, observation and release. Compilation, validation, enumeration and printing are outside timing. Validation expects 78,498 primes.

With Docker available:

```sh
docker build -t primes-swift .
docker run --rm primes-swift
```

The Dockerfile builds with Swift 6.3.3 and runs in its slim runtime image. Native Linux correctness is distinct from M4 performance; see [Linux validation tooling](tools/linux-docker/README.md).

## Editing and verification

Edit handwritten sieve code in `tools/PrimeSieve.swift.in` and dense marking metadata in `tools/generate-dense.swift`. The generator emits both explicit switches: 30 odd cases for 64-bit factors 5–63 and 24 for 128-bit factors 65–111. Every source mark is individual, and runtime dispatch bounds come from the same metadata.

```sh
swift tools/generate-dense.swift --write PrimeSieve.swift
swift tools/generate-dense.swift --check PrimeSieve.swift
swift tools/check-dense-generator.swift
```

`--write` atomically replaces the complete file, including handwritten sections; edits made directly to `PrimeSieve.swift` are overwritten. `--check` compares the complete rendered bytes. The template, dispatch shape, factor ranges, helper widths and source markers are checked before writing. `--template PATH` selects another template; the default is beside the generator. With no arguments, the tool prints both marked blocks.

Builds compile committed `PrimeSieve.swift` directly; generation is not a build step or timed work. `Verify.swift` and `ExtraVerify.swift` compare against independent prime lists and check small limits, alignment, tails, random limits and prime-square boundaries. The [source-candidate checklist](AGENTS.md#done-checklist-for-a-candidate) contains the required ASan/WMO and assembly commands. Generator changes also run the generator's own checks.

The [phase tools](tools/phase-split/README.md) derive profiling input from current source. Their older `PhaseSieve.swift` remains an active independent full-buffer reference; it must not be used as the current timing implementation.

## Accepted measurements

These are recorded results for exact historical revisions on M4 Pro / Swift 6.3.3. They are not fresh measurements of the development head.

| Comparison | Candidate | Control | Result |
|---|---|---|---|
| Adopted cutoff 111 | `099e35a`: 38.434 µs/sieve | `f6b5c5b`: 39.843 µs/sieve | 3.667% more throughput; 1.409 µs saved |
| Same cutoff-sweep session | `099e35a`: 38.434 µs/sieve | Cutoff 127 `bd3858c`: 38.642 µs/sieve | 0.540% more throughput; 0.208 µs saved |
| Latest accepted direct upstream comparison | Cutoff 127 `bd3858c`: 39.000 µs/sieve | Upstream striped UInt8 at `22bfea9`: 207.191 µs/sieve | 5.31× throughput |

The cutoff sweep used three rotated five-second trials per variant, with every cutoff-111 trial faster than every control trial; separation from 127 was only 0.036377 µs at the range boundary. See [PR #16](https://github.com/fahlman/Primes/pull/16) and its [report](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md).

The upstream session compared all three original Swift entries under the same adapted runner and machine conditions. Striped UInt8 was fastest. Spotlight activity and incomplete position balancing limit precision. See the [upstream report and raw-data links](reports/CurrentUpstreamSwiftComparison.md). The 5.31× result belongs to cutoff 127, not cutoff 111. Never multiply gains or combine ratios from separate sessions.

Exact `099e35a` passed all six checks and runtime smoke on native amd64 and arm64 through [PR #15](https://github.com/fahlman/Primes/pull/15). These are correctness and compatibility results, not Threadripper timing. See the [cutoff-111 report](reports/Cutoff111LinuxValidation.md) and [container-cleanup report](reports/LinuxContainerCleanup.md).

For new comparisons, follow the [benchmark contract](AGENTS.md#benchmark-contract). The Swift harnesses adopted through [PR #29](https://github.com/fahlman/Primes/pull/29) build all compared variants with the frozen `25402d4` runner and observer. Both require a unique `--output` path and refuse to overwrite records. Their author-reported tooling runs do not replace the accepted measurements above.

```sh
swift tools/compare-revisions.swift --variant control=CONTROL_REVISION --variant candidate=CANDIDATE_REVISION --output UNIQUE_RESULTS.json
swift tools/compare-upstream.swift --candidate CANDIDATE_REVISION --output UNIQUE_UPSTREAM_RESULTS.json
```

Replace the revision and output placeholders before running. Upstream sources are pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`; candidate and adapter identities are recorded with the results. The validator port remains separate work in [PR #30](https://github.com/fahlman/Primes/pull/30); consult its current review and evidence status.

## Submission and history

The prepared package is preserved on `swift/upstream-striped-111` at merge `35becbe`, also recorded by `origin/swift/submission-review-base`, following [PR #28](https://github.com/fahlman/Primes/pull/28). It improves the striped entry under `PrimeSwift/solution_1`; the reusable sieve matches development. Upstream submission remains paused.

Before submission: resolve the retained `yellowcub_striped_UInt8` result label, record an accepted direct comparison for cutoff 111, and validate the prepared package itself on native Linux. These remain distinct from experiment-source and tooling checks.

Use the [PR history](https://github.com/fahlman/Primes/pulls?q=is%3Apr) for individual outcomes and the [reports](reports/) for deeper explanations. Rejected experiments live on in their closed PRs, whose commits GitHub keeps; the `swift/stream-fusion` experiment is commit `f0cd82d`. The [earlier project brief](https://github.com/fahlman/Primes/blob/38eb1e77677133d610eb23e13171ee981c815771/experiments/swift/AGENTS.md) retains the former experiment table; it is a dated snapshot, not another current status list.

## License

The new experimental code is provided under the included MIT [license](LICENSE). Downloaded original comparison sources remain attributed to their repository authors.
