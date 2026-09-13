# Adopted through-63 Swift phase breakdown

The remaining sparse byte streams account for about **69%** of a pass on this M4 Pro. Word handlers through 63 account for about **27%**; allocation/zeroing/observation/release and factor 3 together account for under **4%**. This identifies where an optimization could matter; it does not establish a speedup for an untested change.

The production full-pass median was **42.601 µs**. The diagnostic full-copy median was **42.640 µs**, just **0.089% higher**, passing the interpretation criterion set before timing (within 3%).

## Estimated costs

These are differences between cumulative-workload medians, not timers inserted into a production pass. Shares use the copied full total so the components sum to that total.

| Stage | Estimated µs/pass | Share of copied full |
|---|---:|---:|
| Allocation, zeroing, observation, release and runner overhead | 0.651 | 1.5% |
| Factor 3 (dense bytes) | 0.926 | 2.2% |
| Factors 5–63 (dense words) | 11.541 | 27.1% |
| Factors 67–997 (sparse byte streams) | 29.522 | 69.2% |
| **Total, copied full** | **42.640** | **100.0%** |

The allocation row includes the loop's clock read, function dispatch and observation overhead; it is not a pure allocator measurement. The marking rows also include factor discovery and cutoff overhead. Through 63 completes active factors through 61; 63 and 65 are composite, and the next active factor is 67.

## Cumulative measurements

| Workload | Round 1 µs | Round 2 µs | Round 3 µs | Median µs |
|---|---:|---:|---:|---:|
| Production full | 42.375 | 42.601 | 42.689 | 42.601 |
| Copied full | 42.489 | 42.640 | 43.019 | 42.640 |
| Allocation + through 63 | 13.012 | 13.200 | 13.117 | 13.117 |
| Allocation + through 3 | 1.570 | 1.577 | 1.587 | 1.577 |
| Allocation only | 0.651 | 0.676 | 0.538 | 0.651 |

Derived costs are `through_3 − allocation_only`, `through_63 − through_3`, and `copied_full − through_63`. The smallest component has appreciable relative noise: allocation-only ranges from 0.538 to 0.676 µs. Fine distinctions within that fraction of the total are not warranted.

## Source, verification and review

- Diagnostic candidate: [`a1f63c58dbfc2f09c7c93c49bb1404069056d508`](https://github.com/fahlman/Primes/commit/a1f63c58dbfc2f09c7c93c49bb1404069056d508), based on development `fac788ecc0a76458d8c663c6784ed3f08117b967`.
- Production sieve: adopted `19aa38a0049e3507a687c482ee446f98ca38d299`, byte-identical in `fac788e`. SHA-256: `6b0cb1d4f06007c6011449125b4d2cdf84a55bc3a5e6028697e81721338e515c`.
- Removing the diagnostic header and reversing exactly the class rename, method signature and extra cutoff guard reproduces production source byte-for-byte. The production sieve, runner and observer were not changed.
- ASAN (`-O -sanitize=address`) and optimized WMO each passed **16,511 partial/full flag checks over 1,501 limits**. Checks cover every valid odd flag against an independent Boolean reference, odd/even/composite cutoffs, small buffers, square/group boundaries, varied limits, allocation zeroing, and full-buffer equality including padding. Production validates **78,498 primes** at 1,000,000.
- The previously adopted production code was not re-reviewed as a new optimization or put through a redundant full optimization verification campaign. This pass specifically verifies the diagnostic copy and its partial workloads.
- An [independent Codex subagent source review](https://github.com/fahlman/Primes/pull/9#issuecomment-5644303785) found no blockers at the exact candidate before timing. [Codex execution/assembly checks](https://github.com/fahlman/Primes/pull/9#issuecomment-5644309378) were also posted before timing. This is not a Claude review.

The production loop has 246 assembly instructions; the copied loop has 249, including the cutoff. Both call the **same compiler-merged 2,530-instruction word handler**. Copied-full, through-63 and through-3 share one common wrapper and runtime-cutoff function, with no separate constant-cutoff kernel specialization in this build. All workload paths reach a real separately compiled `observe` call and release. A separate build with the production runner retains the same 246/2,530 instruction counts. These checks reduce code-generation uncertainty but do not make cumulative subtraction an exact profiler.

## Session and limits

- Apple M4 Pro; macOS 26.6.2 (25G83); Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3`, `clang-2100.1.1.101`), arm64.
- Session including compilation: **2026-09-12 06:53:35–06:55:05 UTC**. Measurements started at approximately 06:53:50 UTC.
- The observer was compiled separately with `-O`; diagnostic executable with `-O -whole-module-optimization`. Exact commands, source hashes, binary and assembly hashes, exit statuses and outputs are in the verification JSON.
- `/tmp/primes-timing.lock` was acquired exclusively before compilation and removed in `finally`. Build/test/benchmark and audio checks were clear before compilation, immediately before measurement and after measurement; these are snapshots, not continuous monitoring.
- Fifteen serial trials, five seconds each, one thread, limit 1,000,000. All trial durations were at least five seconds and the run exited zero. Full-count and byte-equality validation preceded timing. Partial workloads intentionally leave composites unmarked and are not qualifying complete sieve passes.
- Rotations: (1) production, copy, through-63, through-3, allocation; (2) copy, through-63, through-3, allocation, production; (3) through-63, through-3, allocation, production, copy. Three rounds do not fully balance all five positions.
- Desktop activity remained present. Immediately before measurement, WindowServer was 9.9% CPU and Codex Renderer 5.0%; afterward 10.4% and 3.4%. Pre-compilation snapshots also showed indexing/cloud activity, reduced before measurement. These percentages are process snapshots, not averages over the benchmark.
- This is a diagnostic of the adopted M4 implementation, not a comparison against upstream or another candidate. Do not combine it with old session ratios or use it to infer Threadripper/Linux performance. The historical `IndependentReview.md` remains unchanged; its old phase timings no longer describe the adopted source.

The immediate optimization opportunity is the sparse byte-stream loop, at approximately **29.5 µs/pass**. As an illustration rather than a prediction, reducing that component's time by 10% would save about 3.0 µs/pass if other costs stayed fixed. No new optimization was implemented or timed here.

## Evidence

- [Raw samples](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/phase-breakdown-results-a1f63c5.json)
- [Verification, source hashes, assembly review, session conditions and calculations](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/phase-breakdown-verification-a1f63c5.json)
- [Diagnostic source and reproduction notes](../tools/phase-split/README.md)
- [Shared PR #9](https://github.com/fahlman/Primes/pull/9)

The diagnostic refresh and report are ready for integration; the adopted production implementation remains through 63.
