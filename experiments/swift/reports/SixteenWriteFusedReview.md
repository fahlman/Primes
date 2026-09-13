# Sixteen-write fused loop: review and timing

**A clear improvement under the predefined admission rule.** Candidate median **39.553 µs/pass**, versus development **40.044 µs/pass**: **+1.24% throughput**, saving **0.491 µs/pass**.

Source candidate `59262fe2592c893bba05f8ceba64df13dad36df7`, [PR #12](https://github.com/fahlman/Primes/pull/12), independently branched from development `7509c8791f6d35e5a354a77060756afdd5dd8391`. The other candidate is not incorporated. Both candidates passed source review, correctness and assembly checks before the single shared timing session. Atomic marking remains deferred. No production adoption or merge is part of this evaluation.

## Same-session comparison

| Variant | Trial 1 µs | Trial 2 µs | Trial 3 µs | Median µs | Throughput vs development |
|---|---:|---:|---:|---:|---:|
| Adopted B, development control (`7509c87`) | 40.044 | 40.058 | 40.044 | **40.044** | +0.00% |
| Sixteen-write fused loop (`59262fe`) | 39.543 | 39.558 | 39.553 | **39.553** | +1.24% |
| 128-bit handlers for 65–127 (`307da10`) | 42.365 | 42.351 | 42.375 | **42.365** | -5.48% |

A clear win requires every trial faster than every development trial. If both win but their ranges overlap, prefer the simpler sixteen-write candidate. This is a bounded admission rule, not a statistical significance test.

The shared-session recommendation is **Sixteen-write fused loop**. Current development is an optimization control, not the upstream baseline. This run does not remeasure the three upstream Swift implementations or combine ratios from earlier sessions.

## Source and classification

The main sparse loop performs two groups of eight individual marks. With `G = end - r7`, the guard `byte < G - p` bounds the second group’s last address. Two p-byte advances preserve B’s order and masks. Loop exit leaves at most one complete eight-mark cleanup; after that, the scalar tail has at most seven marks. B’s byte-rounded padding set is unchanged.

Runtime odd-factor discovery, p² starts, dense handlers 3–63, fresh class-owned storage, enumeration, runner and observer are unchanged. Every source OR still sets one bit. The candidate retains source-based `algorithm=base,faithful=yes,bits=1`, one thread.

Correctness checks ran at `6679810`; final `59262fe` changes one comment only, clarifying source offsets versus compiler-selected address bases. Independent review confirmed the exact one-line change, and a fresh optimized assembly build was byte-identical to the fully verified revision. No correctness behavior changed.

## Executed verification and assembly

[Independent Codex source review](https://github.com/fahlman/Primes/pull/12#issuecomment-5644805672) and [assembly/execution review](https://github.com/fahlman/Primes/pull/12#issuecomment-5644822391) were posted before timing, with no blocking findings.

All recorded commands exited zero. Verify, ExtraVerify and PhaseVerify ran under both `-O -sanitize=address` and `-O -whole-module-optimization`. Verify compares complete prime arrays at every small limit, larger boundaries, one million and ten million. ExtraVerify retains every limit 2,049–30,000, 500 deterministic random limits and 1,561 prime-square cases. Additional candidate-specific checks cover the new grouping boundaries.

- `.build/extra-verify-asan`: Passed: every limit in 2,049...30,000, 500 random limits in 2,049...2,000,000, and 1561 limits within 3 of every prime square up to 2,000,000. Passed: 3654 sparse double-group and cleanup boundary limits.
- `.build/phase-verify-asan`: Passed 34983 partial/full flag checks over 1521 limits; allocation zeroing; full raw-buffer equality; 78,498 primes at 1,000,000.

PhaseSieve remains the adopted B reference. Its complete-buffer check includes padding, but its phase timings do not describe these candidates. That distinction is documented on both branches.

The four main sparse loops compile to **51 instructions per sixteen marks**, versus 54 for two B iterations, without calls or stack accesses inside those loops. Complete `runSieve` grows from 566 to **905 instructions**. Setup spills offsets and each optional eight-mark cleanup has two stack-pair reloads; the spill-free claim applies only to the main loops. The word helper remains **2,530 instructions** and completedPass **30**, retaining the real observer call and release.

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
- [Other independent candidate](Dense128Review.md).
