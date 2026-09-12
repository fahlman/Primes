# Square-root discovery on adopted cutoff 111

**Flat under the agreed admission rule; do not integrate on this evidence.** Candidate `968c249` measured 39.114576 µs per sieve versus cutoff-111 control `6f989ee` at 39.254545 µs. The median implies 0.357844% higher throughput and 0.139969 µs saved, but the ranges overlap. PR #18 remains open and unmerged. Adopted cutoff 111 is unchanged.

## Exact scope and review

- Candidate: `968c249b7bc61bad48dd39bcfdc4a325b71c1905`. It merges original PR #18 `76d82c275e3d84bdcbc69ec5ca9267a7414bd328` with current development, preserving history.
- Development control: `6f989eeb17b4826d43925efe6fa7a0e178efcc76`; its sieve is identical to adopted `099e35afa8a2f01d79ef11f805d760e81d1d983a`.
- Candidate sieve SHA256: `a193b04bfba33cd517578ef91e271f2c6ea285632d456c58ed566c4181eb09b0`.
- Control sieve SHA256: `f5b7d8f32b5aa53010e39869855e75033b3c998cb70829722bd2ef93a3352448`.

Only the discovery bound changes: a corrected integer square root is computed inside every pass, replacing `p <= limit / p` with `p <= sqrtLimit`. All marking, generated cutoff-111 cases, allocation, runner, observer and verifier code matches development. Runtime ascending discovery, p² starts, individual source marks, fresh class-owned state and `algorithm=base,faithful=yes,bits=1` remain. Classification rests on source operations. Corrections avoid squaring overflow and preserve nonpositive-limit behavior. Existing boundary checks cover the condition.

Independent Codex source review found no blockers; [source review](https://github.com/fahlman/Primes/pull/18#issuecomment-5648010319) and [final admission before timing](https://github.com/fahlman/Primes/pull/18#issuecomment-5648054805) identify the exact candidate. Assembly contains a square root and two correction divisions before odd-candidate discovery, no division inside that scan, four sparse loops with 16 stores each and no calls or stack accesses within them. The completed pass retains real initialization, sieve, observer and release calls. The inspected assembly hash is `084d64a4c2546a723ca17c55462d3f9310060c66a7af621446238b99815c286d`.

## Measurements

| Variant | Trial 1 µs | Trial 2 µs | Trial 3 µs | Median µs | Median sieves/s |
|---|---:|---:|---:|---:|---:|
| Cutoff 111 | 39.093127 | 39.356292 | 39.254545 | 39.254545 | 25474.757 |
| Cutoff 111 + square-root bound | 39.114576 | 39.303411 | 39.088763 | 39.114576 | 25565.917 |

Candidate range: **39.088763–39.303411 µs**; control: **39.093127–39.356292 µs**. The required condition was `max(candidate) < min(control)`; 39.303411 is not below 39.093127. No repeat timing was added after seeing the result. This screen is not a statistical significance test; the result does not prove the true effect is zero.

Apple M4 Pro, native arm64, Swift 6.3.3. One million, one thread, three runs of at least five seconds per variant, all six validated 78,498 primes and required tags. The unchanged `compare_optimizations.py` compiled both exact revisions with `-O -whole-module-optimization`, the frozen runner and separately compiled observer at `25402d46ba991b39451724d3873d326626981e3f`, and a unique `--output`. Allocation, initialization, sieve, opaque observation and release remain inside each timed pass. The source and compiler flags were identical except for the reviewed bound change.

Order: control/candidate; candidate/control; control/candidate. Three rotations with two variants are not fully position-balanced. `/tmp/primes-timing.lock` covered compilation through the end of the session and was released. Before/after snapshots found no monitored competing build/test/benchmark process or audio assertion. These are endpoint observations, not continuous monitoring or a claim of an idle machine. Before: Codex renderer 16.4%, service 11.9%, the wrapper Python process 11.3%, WindowServer 10.9%; after: WindowServer 10.4%, renderer 3.4%. Background activity and the small sample limit precision. No Linux, Threadripper or new upstream-baseline performance claim is made.

## Verification and preserved wrapper recovery

Codex executed the generator check and all six existing correctness checks locally: Verify, ExtraVerify and PhaseVerify under both ASan and WMO. All 14 commands through these checks exited zero. Verify covers every limit −2…2,048, larger square boundaries, 1M and 10M; ExtraVerify covers every limit through 30,000, generated alignment/tail boundaries, random limits, prime-square boundaries and sparse cleanup boundaries. PhaseVerify passed 53,015 checks over 2,305 limits with full raw-buffer equality.

The original wrapper then failed an overly strict byte-identity assertion before assembly. Current and frozen `Benchmark.swift` differ solely in the printed label (`fahlman_swift_dense_striped` versus `fahlman_swift_striped_unrolled`); their observers are identical. **The original `verify.json` remains failed, unchanged.** It is evidence of successful correctness commands followed by an orchestration failure, not a wholly successful wrapper execution.

A separate locked completion verified the exact command list, exits, original wrapper/source hashes and label-only difference, then compiled the observer and candidate assembly using the exact frozen runner. Those commands passed. No completed correctness checks were repeated. Independent recovery review requested explicit binding of the timing admission to the assembly hash, control and harness; those gates were added before timing. Original and assembly-stage wrapper versions are preserved alongside the final timing wrapper. The timing record links original verification, successful assembly and pre-timing admission by hashes.

The two inherited all-language CI runs triggered by candidate publication were deliberately cancelled while queued; both now report completed/cancelled. They do not test `experiments/swift`; this does not replace the six executed local checks. No new Linux validation was run for this retest.

## Evidence

- [Raw results](../discovery-111-results-968c249.json), SHA256 `dfe7400ce7a0d4d938167817b9eeea56aeab104968094fac81890c74debfe601`.
- [Recomputed analysis](../discovery-111-evidence/analysis.json).
- [Original verification record, including wrapper failure](../discovery-111-evidence/verify.json).
- [Successful assembly completion](../discovery-111-evidence/assembly.json), [assembly](../discovery-111-evidence/PrimeSwift.s).
- [Timing execution, hashes and endpoint conditions](../discovery-111-evidence/timing.json).
- [Pre-timing admission](../discovery-111-evidence/review.json), [review text](../discovery-111-evidence/admission.md).
- [Independent final audit](../discovery-111-evidence/independent-audit.json).
- [Preserved scripts](../discovery-111-evidence/scripts), [CI cancellation record](../discovery-111-evidence/ci-cancellations.json).

The prior cutoff-127 session remains unchanged in [the earlier report](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md). Its +0.034% median result overlapped too. It is separate evidence for a different control; no ratios or timings are combined across sessions.
