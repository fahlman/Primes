# 128-bit wrapping-offset follow-up: review and timing

**The follow-up is a clear improvement under the predefined admission rule.** Candidate median **39.116 µs/sieve**, development **40.432 µs/sieve**; **+3.36% throughput**, **+1.316 µs saved** per sieve.

[PR #14](https://github.com/fahlman/Primes/pull/14), exact final source `bd3858cac9a306aa3b8d4729cf059959a7c70885`, against adopted sixteen-write development `e3f5a412d832e7fd25b1354dcf027e1dbf7ab29c`. Port parent `63ff55cd77b47e6c906e801cf22bb9113fa5c080` is traceability only and was not timed. This comparison does not isolate wrapping's throughput contribution. No extra optimization or repeat bracket was added; atomic marking remains deferred. This candidate was selected for the authorized direct upstream comparison and Linux/Docker checks; it has not been merged.

## Source and assembly review

The port reuses the exact 128-bit dispatch, helper section and generator from original `307da10`, preserving adopted sixteen-write sparse marking above 127 and the existing handlers through 63. The final source diff changes only `word * 16` to `word &* 16`, with a caller-invariant comment. For helper index k=word+j, 0≤j<p and word+p≤floor(byteCount/16), hence 0≤k<floor(byteCount/16) and 16*k≤byteCount−16. The offset cannot overflow and every 16-byte access fits.

Every odd handler 65–127 remains, dispatched only after runtime factor discovery. Each source update sets one composite bit; p² starts, fresh class-owned storage, byte padding, runner and observer remain. Classification stays source-based `algorithm=base,faithful=yes,bits=1`, one thread. Compiler merging does not introduce source masks or establish upstream acceptance.

The committed generator matched all 32 cases / 3,072 calls. Independent Codex source and assembly review found no blockers before timing. The assembly gate required removal or material reduction of per-chunk offset checks, preserved marking/observer/release, and no new calls or material spill growth.

**All 3,072 per-chunk overflow checks and traps disappeared.** The vector helper shrank from 36,370 to 12,847 static instructions, and stack-access instructions fell from 4,619 to 1,669. Every runtime-prime main loop has fewer stack accesses (p=67: 49→31; p=127: 108→104). Only the unreachable composite case 65 grows. No helper calls were introduced, and only the expected two prefix/tail variable shifts remain.

The complete frame grew from 1,056 to 1,280 bytes. Constant-pool loads and spills remain; vector ORs grew from 1,024 to 1,365, showing broader compiler restructuring. Four sparse main loops remain 51 instructions per sixteen marks without calls or stack accesses. The word helper remains 2,530 instructions and completedPass 30, with real sieve, observer and release calls. Static counts include failure paths and do not isolate causes of throughput changes.

## Executed correctness checks

Verify passed under AddressSanitizer and benchmark WMO flags. ExtraVerify passed under ASAN, retaining exhaustive/random/prime-square checks plus both previous boundary sets. PhaseVerify passed under WMO, comparing complete raw buffers including padding with the unchanged B reference. Its copied phase timings remain stale for this candidate. No ExtraVerify WMO or PhaseVerify ASAN run was added to this local bracket.

- `.build/verify-asan`: Passed: complete prime arrays for every limit -2...2048, larger square boundaries, 1M, and 10M.
- `.build/verify-wmo`: Passed: complete prime arrays for every limit -2...2048, larger square boundaries, 1M, and 10M.
- `.build/extra-verify-asan`: Passed: every limit in 2,049...30,000, 11382 deduplicated 128-bit alignment/group/tail limits, 500 random limits in 2,049...2,000,000, and 1561 limits within 3 of every prime square up to 2,000,000. Passed: 3654 sparse double-group and cleanup boundary limits.
- `.build/phase-verify-wmo`: Passed 53015 partial/full flag checks over 2305 limits; allocation zeroing; full raw-buffer equality; 78,498 primes at 1,000,000.

[Review and assembly gate](https://github.com/fahlman/Primes/pull/14#issuecomment-5645887536); [executed checks before timing](https://github.com/fahlman/Primes/pull/14#issuecomment-5645932421). Exact commands, exit statuses, source hashes and assembly evidence are in the verification record.

## Same-session comparison

| Variant | Trial 1 µs | Trial 2 µs | Trial 3 µs | Median µs |
|---|---:|---:|---:|---:|
| development (`e3f5a41`) | 40.429 | 40.432 | 40.455 | **40.432** |
| wrapping (`bd3858c`) | 39.119 | 39.116 | 39.107 | **39.116** |

A clear win requires every candidate trial to beat every development trial; overlapping ranges are inconclusive. This is a bounded admission rule, not a statistical significance test. Development is an optimization control, not the upstream baseline.

Apple M4 Pro, Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101), macOS 26.6.2 (25G83). The exclusive timing-lock session ran from 2026-09-12T12:38:46.509408+00:00 to 2026-09-12T12:41:25.237946+00:00, including compilation, and released the lock. The unchanged comparison script used frozen runner and separately compiled observer `25402d4`, identical `-O -whole-module-optimization` builds and an `-O` observer. Allocation, initialization, marking, opaque observation and release remain timed.

Three five-second rounds: development/wrapping; wrapping/development; development/wrapping. All six trials validated 78,498 primes and the expected single-thread tags. The unique output preserved earlier measurements.

| Snapshot | Highest recorded CPU processes | Competing build/test/benchmark | Audio assertions |
|---|---|---:|---:|
| before | WindowServer 24.3%; Claude Helper 8.1%; Claude Helper (Renderer) 6.5%; Codex (Renderer) 5.1% | 0 | 0 |
| after | WindowServer 10.7%; Codex (Renderer) 2.7%; Codex (Service) 1.1%; claude 0.8% | 0 | 0 |

These snapshots are before compilation and after comparison, not continuous monitoring or trial averages. Background activity and one rotated session limit precision. No claim is made about Threadripper performance. Linux/Docker validation and the fresh upstream comparison are separate work with separately pinned evidence.

## Evidence

- [Raw results](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/dense-128-offset-results-bd3858c.json).
- [Verification, reviews, assembly, conditions and calculations](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/dense-128-offset-verification.json).
- [Original 128-bit result](Dense128Review.md).
