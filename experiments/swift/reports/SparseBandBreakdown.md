# Sparse-band timing breakdown

The diagnostic extension in **PR #10 passed review and verification**. On the unchanged adopted development sieve, factors **67–251 account for 18.777 µs/pass**, approximately **44% of the full pass** and **64% of sparse-loop time**. The middle and final sparse bands account for 7.156 and 3.518 µs. This diagnoses development `4483965`; it does not profile experiment 8's candidates.

The copied full median was **42.542 µs**, compared with **42.577 µs** for production: **−0.084%**, well inside the 3% criterion set before timing. These are cumulative-workload differences, not direct timers inside one full sieve.

## Estimated stage costs

| Stage | Estimated µs/pass | Share of copied full | Source writes | ns per source write |
|---|---:|---:|---:|---:|
| Allocation, zeroing, observation, release and runner overhead | 0.767 | 1.8% | — | — |
| Factor 3 | 0.814 | 1.9% | — | — |
| Word factors 5–63 | 11.509 | 27.1% | — | — |
| Sparse factors 67–251 | 18.777 | 44.1% | 132,120 | 0.142 |
| Sparse factors 257–499 | 7.156 | 16.8% | 48,828 | 0.147 |
| Sparse factors 503–997 | 3.518 | 8.3% | 23,431 | 0.150 |
| **Copied full total** | **42.542** | **100.0%** | | |

Subtract `through_251 − through_63`, `through_499 − through_251`, and `copied_full − through_499` for the three sparse bands. Allocation includes zeroing, observation, release and runner/clock overhead. Other differences also include factor discovery and cutoff overhead. Source-write counts include repeated composite writes and one padding-bit write; they are not counts of unique composites or measured hardware stores.

The three bands contain 36, 41 and 73 active factors, hence 288, 328 and 584 streams. Their rounded writes per stream are 459, 149 and 40. The modest increase in normalized time per write does not establish a dominant setup cost: strides, tails, address order and subtraction noise differ. A fitted per-stream coefficient would also absorb per-factor costs because stream count is always eight times factor count. The direct candidate comparison, not this fit, determines the winner.

## Cumulative trials

| Workload | Trial 1 µs | Trial 2 µs | Trial 3 µs | Median µs |
|---|---:|---:|---:|---:|
| production_full | 41.668 | 42.577 | 42.701 | 42.577 |
| copied_full | 42.018 | 42.542 | 42.989 | 42.542 |
| through_499 | 38.619 | 39.023 | 39.220 | 39.023 |
| through_251 | 31.594 | 31.867 | 32.034 | 31.867 |
| through_63 | 12.969 | 13.090 | 13.124 | 13.090 |
| through_3 | 1.561 | 1.581 | 1.593 | 1.581 |
| allocation_only | 0.762 | 0.767 | 0.767 | 0.767 |

## Review and verification

- Exact diagnostic candidate: **`a1a0030f52fdd5ad86635120d3a50600b6ffbe72`**, based on **`4483965cedbf9cbe293caa84201474e92d5b2c6d`**.
- The production sieve is unchanged since adopted `19aa38a`. Production runner, observer and `PhaseSieve.swift` are unchanged. Normalizing the six-line header and three documented source substitutions reproduces production byte-for-byte.
- Codex ran ASAN and optimized WMO verification: **34,983 partial/full checks over 1,521 limits** per build, including new cutoffs and neighboring odd/even/composite cutoffs, both sides of 251²/257²/499²/503², allocation zeroing, exact full-buffer equality and 78,498 primes at one million. All commands exited zero.
- An independent Codex subagent reviewed the source and assembly; [Codex's review and execution findings were posted before timing](https://github.com/fahlman/Primes/pull/10#issuecomment-5644491219). No blocking findings.
- Assembly preserves one 249-instruction cutoff loop and one 2,530-instruction word helper shared with production. All five cutoff modes reach the same 32-instruction pass body; named wrapper thunks have two instructions and mode-table closure adapters twelve. The real observer call and release remain. No cutoff-specific kernel specialization appears in this build. Production retains its separate 246-instruction outer loop.

## Session and limits

This diagnostic ran **2026-09-12 07:35:46–07:37:31 UTC**, inside the same exclusive lock hold as the subsequent [experiment 8 comparison](SparseStreamExperiment8Review.md). The lock was acquired before compilation and removed in `finally` after both runs. Both outputs used unique `--output` paths, preserving prior reports.

Apple M4 Pro; macOS 26.6.2 (25G83); Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3`, `clang-2100.1.1.101`), arm64. Diagnostic executable `-O -whole-module-optimization`; observer separately compiled with `-O`. Limit one million, one thread, fresh storage every pass. All **21 trials** lasted at least five seconds. Full validation and serialization were outside timing; partial modes are diagnostics, not qualifying complete sieves.

Order: (1) production, copy, through499, through251, through63, through3, allocation; (2) copy, through499, through251, through63, through3, allocation, production; (3) through499, through251, through63, through3, allocation, production, copy. Three rotations do not fully balance seven positions.

No competing build/test/benchmark process or audio assertion appeared in snapshots before/after the diagnostic. Desktop activity remained: WindowServer 12.3% and Codex Renderer 5.2% immediately beforehand, 10.3% and 2.9% afterward. These snapshots do not continuously characterize load. The full-copy trials span 42.018–42.989 µs, so small differences between normalized band costs deserve caution. The copy/control agreement does not turn cumulative subtraction into an exact profiler.

The later optimization comparison uses a different runner and its own three-way development control. Its development median was 43.259 µs. Sharing a lock hold does not justify mixing that total with these phase costs; use the direct comparison's own control for candidate gains. No upstream or cross-machine speedup is claimed here.

The band extension is recommended for integration. PR #10 remains unmerged. Its diagnostic copy must be refreshed before profiling a subsequently adopted sparse-loop implementation.

## Evidence

- [Raw 21-trial samples](../phase-band-results-a1a0030.json)
- [Shared verification, source hashes, assembly review, session record and calculations](../sparse-stream-verification-8f108f5.json)
- [PR #10](https://github.com/fahlman/Primes/pull/10)
