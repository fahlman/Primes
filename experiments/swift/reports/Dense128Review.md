# 128-bit handlers for 65–127: review and timing

**A clear regression; retain the development version for this experiment.** Candidate median **42.365 µs/pass**, versus development **40.044 µs/pass**: **-5.48% throughput**, taking **2.321 µs more per pass**.

Source candidate `307da10fe930e2bbdb46254770833026277e4cf3`, [PR #13](https://github.com/fahlman/Primes/pull/13), independently branched from development `7509c8791f6d35e5a354a77060756afdd5dd8391`. The other candidate is not incorporated. Both candidates passed source review, correctness and assembly checks before the single shared timing session. Atomic marking remains deferred. No production adoption or merge is part of this evaluation.

## Same-session comparison

| Variant | Trial 1 µs | Trial 2 µs | Trial 3 µs | Median µs | Throughput vs development |
|---|---:|---:|---:|---:|---:|
| Adopted B, development control (`7509c87`) | 40.044 | 40.058 | 40.044 | **40.044** | +0.00% |
| Sixteen-write fused loop (`59262fe`) | 39.543 | 39.558 | 39.553 | **39.553** | +1.24% |
| 128-bit handlers for 65–127 (`307da10`) | 42.365 | 42.351 | 42.375 | **42.365** | -5.48% |

A clear win requires every trial faster than every development trial. If both win but their ranges overlap, prefer the simpler sixteen-write candidate. This is a bounded admission rule, not a statistical significance test.

The shared-session recommendation is **Sixteen-write fused loop**. Current development is an optimization control, not the upstream baseline. This run does not remeasure the three upstream Swift implementations or combine ratios from earlier sessions.

## Source and classification

Every odd factor 65–127 has a handler dispatched only after its runtime candidate-bit test. Individual marks peel from p² to a 128-bit boundary, requiring at most 127 marks. A complete group processes p chunks and 128 successive multiples. In chunk j, `first = (-128*j) mod p`; all 32 cases and 3,072 helper calls were independently checked and reproduced by the committed Swift generator.

Each `SIMD2<UInt64>` local receives one single-bit OR per composite. Raw unaligned loads/stores, with per-lane little-endian conversion, preserve the byte representation. Whole-group bounds require every 16-byte access to fit inside allocated storage. The tail has at most 128 marks and uses the byte-rounded endpoint, preserving B’s padding, including factor 101’s mark for 1,000,001.

Runtime odd-factor discovery, p² starts, handlers 3–63, the original fused sparse loop above 127, fresh class-owned storage, enumeration, runner and observer remain. The SIMD local is not a precomputed composite mask. Classification remains source-based `algorithm=base,faithful=yes,bits=1`, one thread; compiler merging of individual source operations does not establish upstream acceptance.

The original 2–3 µs estimate was unmeasured. Fewer source stores alone do not predict throughput: the accesses become wider, the function grows, and alignment/tail work changes. The measured table above determines the conclusion.

## Executed verification and assembly

[Independent Codex source review](https://github.com/fahlman/Primes/pull/13#issuecomment-5644832523) and [assembly/execution review](https://github.com/fahlman/Primes/pull/13#issuecomment-5644894259) were posted before timing, with no blocking findings.

All recorded commands exited zero. Verify, ExtraVerify and PhaseVerify ran under both `-O -sanitize=address` and `-O -whole-module-optimization`. Verify compares complete prime arrays at every small limit, larger boundaries, one million and ten million. ExtraVerify retains every limit 2,049–30,000, 500 deterministic random limits and 1,561 prime-square cases. Additional candidate-specific checks cover the new grouping boundaries.

- `.build/extra-verify-asan`: Passed: every limit in 2,049...30,000, 11382 deduplicated 128-bit alignment/group/tail limits, 500 random limits in 2,049...2,000,000, and 1561 limits within 3 of every prime square up to 2,000,000.
- `.build/phase-verify-asan`: Passed 53015 partial/full flag checks over 2305 limits; allocation zeroing; full raw-buffer equality; 78,498 primes at 1,000,000.

PhaseSieve remains the adopted B reference. Its complete-buffer check includes padding, but its phase timings do not describe these candidates. That distinction is documented on both branches.

`runSieve` has **581 instructions** and retains four **27-instruction / eight-mark sparse loops** without calls or stack accesses inside them. The word helper remains **2,530 instructions**, matching B; completedPass remains **30** with a real observer call followed by release. The new 128-bit helper has **36,370 instructions**, including **1,024 vector ORs** and **2,048 scalar single-lane ORs**, with compiler-generated masks. Its 32 group loops have no calls or variable shifts, but contain offset-overflow checks and substantial spills/reloads; the stack frame is **1,056 bytes**. The p=67 group has **623 instructions / 49 stack accesses**, and p=127 has **1,072 / 108**. Two variable shifts remain in the scalar prefix and tail. Static function totals include failure paths and are not per-pass counts. These are code-generation costs, not correctness blockers; this experiment evaluates this implementation, not every possible 128-bit handler.

Instruction counts describe compiled code, not isolated causes of the measured result. Source hashes, command lines, outputs, assembly hashes and excerpts are in the verification record.

## Timing protocol and conditions

Apple M4 Pro, Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101), macOS 26.6.2 (25G83). One exclusive `/tmp/primes-timing.lock` hold covered 2026-09-12T09:02:40.966049+00:00 through 2026-09-12T09:05:34.635778+00:00, including compilation. The lock was removed in `finally`. The user-requested `caffeinate -i` hold kept the Mac awake during the work.

The unchanged `compare_optimizations.py` used the frozen Swift runner and separately compiled observer from `25402d46ba991b39451724d3873d326626981e3f`. Builds used `-O -whole-module-optimization`, with a separately compiled `-O` observer. Fresh allocation, initialization, marking, opaque observation and release are timed; validation, prime enumeration and printing are excluded.

Run order: (1) development, sixteen, dense128; (2) sixteen, dense128, development; (3) dense128, development, sixteen. All nine runs lasted at least five seconds, validated 78,498 primes, and reported one thread with the expected tags. The unique output file preserved prior measurements.

| Snapshot | Highest recorded CPU processes | Competing build/test/benchmark | Audio assertions |
|---|---|---:|---:|
| Before comparison | spotlightknowledged 99.3%; Codex (Renderer) 5.4%; codex 3.6%; Python 1.2% | 0 | 0 |
| After comparison | spotlightknowledged 99.7%; Codex (Renderer) 1.5%; ChatGPT 1.0%; claude 0.7% | 0 | 0 |

These are snapshots before comparison compilation and afterward, not continuous monitoring or benchmark averages. Spotlight was near 99% CPU in both snapshots. That background activity and a single rotated session make the exact percentages provisional. No additional timing bracket, upstream comparison, Linux/Docker run, or Threadripper measurement was added.

## Evidence

- [Raw comparison samples](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/sparse-next-results-59262fe-307da10.json).
- [Verification, reviews, assembly, source hashes, commands, conditions and calculations](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/sparse-next-verification.json).
- [Other independent candidate](SixteenWriteFusedReview.md).
