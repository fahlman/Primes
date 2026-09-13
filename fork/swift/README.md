# Swift development tools

The adopted sieve is [PrimeSieve.swift](../../PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8/Sources/PrimeSieveSwift/PrimeSieve.swift) in the striped Swift package. The [solution README](../../PrimeSwift/solution_1/README.md) covers the implementation, package build, CLI and generator. This directory contains fork-only benchmarks, comparisons and diagnostics; it is excluded from the upstream submission.

The package owns its editable template and generator in `Tools`, and compiles the generated sieve directly. Its `Verify.swift` is the canonical correctness check. There is one copy of the sieve, observer, template and verifier.

## Build and verify

Use Swift 6.3.3. Acquire `/tmp/primes-timing.lock` under the [working rules](../../AGENTS.md#timing-sessions) before compiling, testing or benchmarking. From this directory:

```sh
swift_package=../../PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8
swift "$swift_package/Tools/generate-dense.swift" --check "$swift_package/Sources/PrimeSieveSwift/PrimeSieve.swift"
swift check-dense-generator.swift
sh ./run.sh
```

`run.sh` builds the unchanged development benchmark with the canonical sieve and separately compiled observer. It uses `-O -whole-module-optimization`, limit 1,000,000 and at least five seconds; allocation through release is timed. Validation expects 78,498 primes. The full [candidate checklist](../../AGENTS.md#done-checklist-for-a-candidate) lists the ASan/WMO and assembly commands.

The [phase tools](phase-split/README.md) derive diagnostics from the canonical source. The historical `PhaseSieve.swift` remains an independent full-buffer reference. See [Linux validation](linux-docker/README.md) for the native Linux checks of the solution folder's Docker image, which runs all three Swift entries.

## Compare committed revisions

From this directory, replace the revision and output placeholders:

```sh
swift compare-revisions.swift --variant control=CONTROL_REVISION --variant candidate=CANDIDATE_REVISION --output UNIQUE_RESULTS.json
swift compare-upstream.swift --candidate CANDIDATE_REVISION --output UNIQUE_UPSTREAM_RESULTS.json
```

Both harnesses require a unique `--output` path and refuse to overwrite records. They use the unchanged runner and observer from commit `25402d4`; upstream sources are pinned to `22bfea9c7122c46dcda799020fccf5ae83fe667f`. Candidate lookup supports the canonical package path and historical `experiments/swift/PrimeSieve.swift` revisions. Build outputs stay under `.build`. Follow the [benchmark contract](../../AGENTS.md#benchmark-contract); tooling smoke checks are not accepted performance results.

## Accepted measurements

These are recorded results for exact historical revisions on M4 Pro / Swift 6.3.3. They are not fresh measurements of the development head.

| Comparison | Candidate | Control | Result |
|---|---|---|---|
| Adopted cutoff 111 | `099e35a`: 38.434 µs/sieve | `f6b5c5b`: 39.843 µs/sieve | 3.667% more throughput; 1.409 µs saved |
| Same cutoff-sweep session | `099e35a`: 38.434 µs/sieve | Cutoff 127 `bd3858c`: 38.642 µs/sieve | 0.540% more throughput; 0.208 µs saved |
| Accepted direct upstream comparison | Cutoff 111 `902e4c2`: 39.278 µs/sieve | Upstream striped UInt8 at `22bfea9`: 209.875 µs/sieve | 5.34× throughput; Bool (`bits=8`) 291.853 µs, 7.43×; packed 354.070 µs, 9.01× |

The cutoff sweep used three rotated five-second trials per variant, with every cutoff-111 trial faster than every control trial; separation from 127 was only 0.036377 µs at the range boundary. See the [recorded comparison in PR #16](https://github.com/fahlman/Primes/pull/16).

The upstream session compared the candidate with all three original Swift entries, every variant built with the frozen `25402d4` runner and observer, three rotated five-second trials each, on a quiet machine with no competing build, test, benchmark or media; all twelve runs validated 78,498 primes. Striped UInt8 remains the fastest upstream entry and the project baseline. See the [session record, log and condition snapshots](https://github.com/fahlman/Primes/tree/164f1fb9f71dd73c79f44e9f7d31ef49f75ddb4b/experiments/swift/upstream-comparison/accepted/902e4c2c85f1/session-20260913T1848Z). The earlier cutoff-127 comparison, 5.31×, stays with [PR #14](https://github.com/fahlman/Primes/pull/14#issuecomment-5653991965). Never multiply gains or combine ratios from separate sessions.

Exact `099e35a` passed all six checks and runtime smoke on native amd64 and arm64 through [PR #15](https://github.com/fahlman/Primes/pull/15). These are correctness and compatibility results, not Threadripper timing. See the [cutoff-111 verification](https://github.com/fahlman/Primes/pull/16#issuecomment-5653992293) and [container-cleanup verification](https://github.com/fahlman/Primes/pull/15#issuecomment-5653992129).

## Submission and history

The package prepared through [PR #28](https://github.com/fahlman/Primes/pull/28), preserved at `35becbe`, is now the development source under `PrimeSwift/solution_1`. Upstream submission remains paused. The entry prints the label `yellowcub_fahlman_striped_UInt8`, following the folder's `j-f1_yellowcub_bool` precedent for an improved entry. The packaged entry's own image is what [the Linux workflow](linux-docker/README.md) validates.

Use the [PR history](https://github.com/fahlman/Primes/pulls?q=is%3Apr) for individual outcomes, detailed reviews, timing tables and evidence links. The original report files remain in published Git history. Rejected experiments live on in their closed PRs, whose commits GitHub keeps; the `swift/stream-fusion` experiment is commit `f0cd82d`. The [earlier project brief](https://github.com/fahlman/Primes/blob/38eb1e77677133d610eb23e13171ee981c815771/experiments/swift/AGENTS.md) retains the former experiment table; it is a dated snapshot, not another current status list.

## License

Fork development tools retain the included MIT [license](LICENSE). The solution package and upstream implementations retain their existing repository licensing and attribution.
