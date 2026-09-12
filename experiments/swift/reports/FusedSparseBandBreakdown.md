# Adopted fused-sparse sieve: refreshed band breakdown

The refreshed diagnostic tracks adopted experiment 8B: copied-full median **39.962 µs/pass** versus actual production **40.183 µs/pass**, a **-0.549%** difference. It passes the predefined 3% control criterion.

Sparse factors 67–997 account for approximately **26.986 µs (67.5%)** of the copied complete pass. The 67–251 band is the largest component, at 17.002 µs. These are differences of cumulative medians, not direct timers within a production pass or a measurement of an optimization gain.

## Revisions and scope

- Diagnostic candidate: `56ad42b2b2dfdd7a463323d212cf2a5781266f25`, [PR #10](https://github.com/fahlman/Primes/pull/10).
- Development revision: `1edbea7b781a3f45c146ebd43388187367be30b5`. Production source is unchanged from adopted B `8f108f5dfe48d3c79bbe06d147a4097039635dc4` (merged through PR #11 in `703dc12`).
- Original PR #10 commit `a1a0030` is preserved by a merge commit. The refreshed copy incorporates B while retaining the new cutoffs and expanded verifier; no pushed history was rewritten.
- Production sieve, submission runner and separately compiled observer are unchanged. Production retains source-based `algorithm=base,faithful=yes,bits=1`, one thread; partial diagnostic workloads are not qualifying complete sieves.
- This session profiles current B only. It does not rerun A/B or upstream comparisons, and its absolute times must not be combined with old sessions to calculate a speedup.

## Cumulative measurements

Each entry includes fresh allocation and zeroing, the requested marking work, opaque observation, release, and runner/clock overhead. Validation and enumeration occur outside timing.

| Mode | Round 1 µs | Round 2 µs | Round 3 µs | Median µs |
|---|---:|---:|---:|---:|
| `production_full` | 39.207 | 40.183 | 40.433 | **40.183** |
| `copied_full` | 39.308 | 39.962 | 40.499 | **39.962** |
| `through_499` | 36.171 | 36.642 | 36.978 | **36.642** |
| `through_251` | 29.643 | 29.978 | 30.227 | **29.978** |
| `through_63` | 12.815 | 12.976 | 13.021 | **12.976** |
| `through_3` | 1.546 | 1.561 | 1.576 | **1.561** |
| `allocation_only` | 0.741 | 0.735 | 0.737 | **0.737** |

## Estimated incremental costs

Shares use the copied-full median, so all six rows sum to its total. Each marking band includes factor discovery and the effects of its cutoff.

| Stage | Estimated µs/pass | Share of copied full |
|---|---:|---:|
| Allocation, zeroing, observation, release and runner overhead | 0.737 | 1.8% |
| Factor 3 | 0.824 | 2.1% |
| Word factors 5–63 | 11.415 | 28.6% |
| Sparse factors 67–251 | 17.002 | 42.5% |
| Sparse factors 257–499 | 6.663 | 16.7% |
| Sparse factors 503–997 | 3.321 | 8.3% |

| Sparse factors | Fused factor loops | Source byte writes | Estimated ns/source write |
|---|---:|---:|---:|
| 67–251 | 36 | 132,120 | 0.129 |
| 257–499 | 41 | 48,828 | 0.136 |
| 503–997 | 73 | 23,431 | 0.142 |

Source writes include repeated composite marks and final-byte padding. They are not counts of unique composites or measured hardware stores. B has one fused traversal per factor; the old 288/328/584 independent-stream counts do not describe it. Stride, address order, tail share and factor discovery also vary between bands. These normalized costs do not isolate a universal setup cost or predict the gain from another change.

## Verification and independent review

- Removing the six-line header and reversing exactly the class-name, method-signature and outer-loop-condition substitutions makes `PhaseSieve.swift` identical to production B. Source hashes are recorded below.
- The diagnostic verifier passed **34,983 partial/full flag checks over 1,521 limits** under both `-O -sanitize=address` and `-O -whole-module-optimization`, including allocation zeroing and full raw-buffer equality with padding. All commands exited 0. Production validates 78,498 primes at 1,000,000.
- The suite includes 23 cutoffs, the measured band edges and neighboring cutoffs, and limits on both sides of 251², 257², 499² and 503². Production correctness evidence from the adopted B review remains applicable because its source and verification programs did not change.
- An independent Codex subagent reviewed exact candidate `56ad42b` with no blocking findings; [source review](https://github.com/fahlman/Primes/pull/10#issuecomment-5644627942) was posted before timing. A second independent Codex subagent audited assembly; [assembly review](https://github.com/fahlman/Primes/pull/10#issuecomment-5644630334) was also posted before timing.

| Compiled component | Static instructions |
|---|---:|
| Production `runSieve`, in both builds | 566 |
| Copied `runSieve` with cutoff | 568 |
| Shared outlined dense-word handler | 2,530 |
| Each of four fused sparse loops | 27 |
| Shared cutoff-pass body | 32 |
| Named cutoff thunks / actual mode-table adapters | 2 / 12 |
| Production / allocation-only pass wrappers | 30 / 29 |

Production instruction streams match between the diagnostic and submission-runner builds after symbol and local-label normalization; dense-word helpers match too. The copy adds cutoff preservation and a conditional comparison. Register allocation differs, but all four sparse loops retain eight immediate-mask byte updates with no loop-body stack accesses. All five cutoff modes call the same kernel with verified constants; no per-cutoff marking specialization appears. Fresh allocation/zeroing and deallocation remain real calls, as does the external observer followed by release.

## Session and limits

Apple M4 Pro; Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101); macOS 26.6.2 (25G83). The exclusive `/tmp/primes-timing.lock` was acquired before compilation, held from 2026-09-12T08:06:11.549550+00:00 through 2026-09-12T08:08:10.627681+00:00, and removed in `finally`. The observer was compiled separately with `-O`; the diagnostic used `-O -whole-module-optimization` and a unique `--output phase-band-fused-results-56ad42b.json`.

All **21 serial trials** completed, each lasting at least five seconds. Seven modes rotated by one position over three rounds; three rounds do not fully balance all seven positions. The raw file records exact order, elapsed durations, pass counts and checksums. The runtime control validated 78,498 primes and full-copy buffer equality before measurement.

Process and audio snapshots were taken before compilation, immediately before measurement and afterward:

| Snapshot | Highest recorded CPU processes | Competing build/test/benchmark | Audio assertions |
|---|---|---:|---:|
| Before compilation | WindowServer 24.9%; Codex (Renderer) 16.7%; Codex (Service) 10.1%; corespotlightd 4.3% | 0 | 0 |
| Before timing | WindowServer 11.1%; Codex (Renderer) 4.2%; Codex (Service) 2.3%; sleep 0.7% | 0 | 0 |
| After timing | WindowServer 11.4%; Codex (Renderer) 2.7%; Codex (Service) 1.5%; SafariBookmarksSyncAgent 1.4% | 0 | 0 |

All marking modes became slower across successive rounds: production ranged from 39.207 to 40.433 µs and the copy from 39.308 to 40.499 µs. This drift makes small differences and fine-grained band attribution provisional. No repeat session was added.

Snapshots are not continuous monitoring. Desktop activity, cache state, wrapper/cutoff overhead and cumulative subtraction limit precision. Passing the predefined 3% copied-full control supports an approximate breakdown, not exact production stage times. Docker/Linux execution and other processors were not tested here.

An independent Codex subagent checked this final report and the updated project documentation against the raw samples and verification record, with no blocking findings.

## Evidence

- [Raw timing samples](../phase-band-fused-results-56ad42b.json).
- [Verification, source/assembly hashes, review, commands, session conditions and calculations](../phase-band-fused-verification-56ad42b.json).
- [Diagnostic implementation and procedure](../tools/phase-split/README.md).
- Historical pre-fusion measurements remain unchanged: [through-63 report](PhaseBreakdownThrough63.md) and [original sparse-band report at a7fc27f](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/reports/SparseBandBreakdown.md).
