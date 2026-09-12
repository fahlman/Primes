# Cutoff, sparse-loop, discovery and atomic experiments

Independent source review admitted all six candidate commits below. Both registered timing sessions completed successfully; all 27 runs validated correctly. Only cutoff 111 met the speed-admission rule against the 127-factor control. No candidate is adopted or merged by this review.

The author is Claude; the independent reviews were performed by Codex root and Codex subagents. Every candidate is reviewed against exact `bd3858cac9a306aa3b8d4729cf059959a7c70885`, the unmerged PR #14 implementation. Later PR #14 head `8e46815` merges documentation only and preserves its tested source bytes. Current development `4f6862f` differs from the requested `f6b5c5b` control only in README and AGENTS, so that pinned control still measures the adopted sixteen-write implementation without 128-bit handlers.

| PR | Candidate | Exact commit | Independent source review |
|---|---|---|---|
| [#16](https://github.com/fahlman/Primes/pull/16) | Cutoff 79 | `7f261701ce8c031ec0104b00631c4dba74289ff3` | Admitted |
| #16 | Cutoff 95 | `2dc1d42d0840e1ec1488e57f4504264bfa055762` | Admitted |
| #16 | Cutoff 111 | `099e35afa8a2f01d79ef11f805d760e81d1d983a` | Admitted |
| [#17](https://github.com/fahlman/Primes/pull/17) | 32 sparse writes | `af83aa15d86f0a15155349bcaa76ebd4710fc357` | Admitted; comment nit |
| [#18](https://github.com/fahlman/Primes/pull/18) | Integer-root discovery bound | `76d82c275e3d84bdcbc69ec5ca9267a7414bd328` | Admitted |
| [#19](https://github.com/fahlman/Primes/pull/19) | Atomic sparse marks | `e889cd6b51bcd3f0de025d13541662b6f49c7c5f` | Admitted for inspected Swift 6.3.3; wording nits |

## Registered measurement

Two sessions use the unchanged `compare_optimizations.py`, frozen runner and separate observer `25402d46ba991b39451724d3873d326626981e3f`, identical `-O -whole-module-optimization`, and three rotated five-second trials per variant. An exclusive `/tmp/primes-timing.lock` covers compilation through completion. Unique `--output` paths preserve earlier results. A transparent compiler launcher records argument lists, exit statuses and wall time; it does not change Swift source, flags or the timed workload.

The cutoff session starts in order development63 (`f6b5c5b`), cutoff79, cutoff95, cutoff111, cutoff127 (`bd3858c`): 15 runs. Compare each cutoff with 127 and 63 separately. The second session starts baseline127 (`bd3858c`), sparse32, discovery, atomic: 12 runs, with 127 as the direct control requested in the handoff. These are development controls; the project baseline remains the fastest upstream Swift implementation, measured in its separate recorded session.

A candidate qualifies only if every candidate trial is faster than every control trial. Failure to separate means no merge on this evidence. This is an admission screen, not a statistical significance test. Three rotations do not fully balance four or five execution positions. Do not combine ratios between sessions, infer a Linux/Threadripper gain, choose a winner from instruction counts, or start another experiment from these results without a new scope decision.

Before-timing review records: [#16](https://github.com/fahlman/Primes/pull/16#issuecomment-5646578917), [#17](https://github.com/fahlman/Primes/pull/17#issuecomment-5646578990), [#18](https://github.com/fahlman/Primes/pull/18#issuecomment-5646579067), [#19](https://github.com/fahlman/Primes/pull/19#issuecomment-5646584493). [Registration and source identities](../followup-four-review.json).

## Source review

### Cutoffs

Two independent source audits reproduce each full generated switch using `(-128*j) mod p`: cutoff79 has eight cases/576 calls, cutoff95 sixteen/1,280, and cutoff111 twenty-four/2,112. Every odd value in the range has a case; the generator does not test primality or construct composite masks. The source outside the block is identical after normalizing comments and the sole dispatch bound. Runner, observer, verifiers, Dockerfile and harness sources match `bd3858c`. [Machine-readable source audit](../cutoff-sweep-source-audit.json).

The unchanged sparse fallback remains valid above each cutoff. It starts at p², preserves individual marks, and uses the same byte-rounded padding boundary as the vector path. Runtime discovery prevents composite candidates from being dispatched. No additional targeted correctness concern was identified.

### Thirty-two writes

The strict bound `byte < end-r7-3*p` protects the fourth group's last address and all preceding accesses. Advancing four groups leaves at most three complete cleanup groups and seven scalar marks. The existing 8/16/24/32-mark boundaries exercise cleanup counts and the first main-loop entry; subsequent groups preserve the translated invariant. Index arithmetic remains representable under the existing factor bound.

Saved assembly contains four 110-instruction/32-store main loops with nine stack-access instructions each; inspected cleanup loops contain 27 instructions/eight stores with no stack accesses. This is not a throughput prediction. Nonblocking source-comment nit: line49 still says two groups; this candidate uses four. It is left unchanged to preserve the exact timing candidate.

### Integer-root discovery bound

The downward correction rejects estimates above the integer root. The upward correction stops before the next square exceeds the limit. Nonpositive limits keep a zero bound without dividing by zero; for positive Int limits the estimate and increment fit, and division avoids squaring overflow. The computation remains inside every pass. Saved assembly moves the division into the root corrections and leaves no division in discovery; sparse loops remain unchanged.

### Atomic sparse marks

Offsets, masks, bounds, advancement, cleanup and tail are unchanged. Twenty-five syntactic single-bit marks become relaxed atomic ORs. Everything from the dense helper onward is byte-identical to `bd3858c`, and the runner/observer/verifiers are unchanged. Synchronization is a standard Swift module and the sieve remains single-threaded.

Admission of the scoped `Atomic<UInt8>` view rests on the inspected contract and concrete representation. Swift 6.3.3 permits a layout-compatible temporary rebind of initialized storage; Atomic has its representation's layout, and UInt8's representation is one byte with alignment one and no separate resource state. The rebound pointer does not escape, and the original byte pointer is not accessed inside the closure. This reasoning supports the concrete specialization, not arbitrary Atomic reinterpretation. [Pointer contract](https://github.com/swiftlang/swift/blob/swift-6.3.3-RELEASE/stdlib/public/core/UnsafePointer.swift#L1195-L1274), [Atomic layout/lifetime](https://github.com/swiftlang/swift/blob/swift-6.3.3-RELEASE/stdlib/public/Synchronization/Atomics/Atomic.swift#L15-L55), [storage representation](https://github.com/swiftlang/swift/blob/swift-6.3.3-RELEASE/utils/SwiftAtomics.py#L13-L21).

Saved assembly contains 919 runSieve instructions and 100 ldsetb instructions, four 35-instruction/16-mark main loops without stack accesses, and guarded cleanup blocks with 38 instructions/eight stack accesses. Dense helpers and real observation/release remain. Nonblocking wording corrections: describe a source-level marking change, since generated address setup/register allocation also changes; qualify ldsetb claims to the inspected M4/Swift 6.3.3 build. Earlier Linux validation covers `bd3858c`, not this atomic candidate.

All candidates retain runtime ascending factor discovery, p² starts, individual single-bit source marking, fresh class-owned allocation and `base,faithful=yes,bits=1`. Compiler merging is permitted under the project's source-level classification; this review does not establish upstream acceptance.

## Correctness provenance

The user and Claude explicitly report full-checklist success at every exact candidate commit: generator checks where applicable, Verify ASAN/WMO, ExtraVerify ASAN, and PhaseVerify ASAN/WMO with full raw-buffer equality and a real observer call in assembly. Codex inspected current saved pass logs and assembly for cutoff111 and the three other experiments. Those files were preserved unchanged with hashes in [the peer-artifact manifest](../followup-four-peer-artifacts.json). The earlier cutoff79/95 artifacts were not available in the current cutoff worktree.

The saved files do not independently record command exit codes or exact source hashes at their creation. Their execution provenance is user/Claude-reported; Codex did not rerun the full suites. Independent source review found no concrete unresolved concern requiring an additional targeted check. Fresh measurement builds and benchmark output validation are recorded separately in each execution record.

## Timing results

### Cutoff sweep

All 15 runs validated 78,498 primes and the expected one-thread tags. The session completed with exit 0 and released its lock. **Cutoff 111 qualifies against cutoff127**: every trial was faster, with a median throughput gain of 0.5401% and 0.20757 µs saved. Every cutoff, including 127, also beat the adopted development63 control on every trial. No merge is performed.

| Cutoff | Median µs/sieve | Sieves/s from median | Throughput versus127 | Saved µs versus127 | Benchmark compile seconds | Admission versus127 |
|---|---:|---:|---:|---:|---:|---|
| development63 | 39.843 | 25098.3 | -3.016% | -1.202 | 7.107 | Slower on every trial |
| cutoff79 | 38.919 | 25694.5 | -0.712% | -0.277 | 9.850 | Slower on every trial |
| cutoff95 | 38.670 | 25860.1 | -0.072% | -0.028 | 21.808 | Not clearly separated |
| cutoff111 | 38.434 | 26018.5 | +0.540% | +0.208 | 45.378 | Qualifies |
| cutoff127 | 38.642 | 25878.8 | control | — | 114.492 | Control |

Cutoff 111 trial range: **38.396479–38.573821 µs**; cutoff 127: **38.610198–38.802403 µs**. Their ranges are separated by only **0.036377 µs**. This meets the preregistered rule in this session; it does not establish statistical significance or broad reproducibility. Cutoff 95 overlaps 127, and 79 is slower on every trial. Against development 63, cutoff 111 gains 3.6666% throughput and saves 1.40922 µs. These are separate comparisons from the same session, not multiplied cross-session ratios.

The measured compiler times are one benchmark build per variant, in the registered order, on the Mac. Cutoff 111 took 45.378 s versus 114.492 s at 127. They demonstrate substantial build-cost reduction here, without claiming a replicated compile-time distribution or a Linux result for the shortened cutoff.

The original 14:56 UTC preflight stopped on audio-output assertions before any Swift compilation or benchmark. Its [execution record](../cutoff-sweep-execution-20260912.json) is preserved. After the user quit other applications, the actual cutoff session ran 14:59:51–15:04:25 UTC. Before/after snapshots showed no competing build/test/benchmark or audio assertions. The before snapshot included the orchestrator Python process at 13.5%; after, Codex Renderer was 9.9%. These are endpoint snapshots, not continuous monitoring.

[Raw results](../cutoff-sweep-results-20260912-audio-preflight-retry1.json), [execution and conditions](../cutoff-sweep-execution-20260912-audio-preflight-retry1.json), [compiler events](../cutoff-sweep-compiler-20260912-audio-preflight-retry1.jsonl), [recomputed analysis](../cutoff-sweep-analysis-20260912-audio-preflight-retry1.json).

### Sparse, discovery and atomic session

All 12 runs validated 78,498 primes and the expected one-thread tags. The session completed with exit 0 and released its lock. **None of these three candidates qualifies.** Thirty-two writes and atomic marking were slower on every trial; the square-root discovery change overlaps the control and is flat under the registered rule.

| Variant | Median µs/sieve | Sieves/s from median | Throughput versus127 | Saved µs versus127 | Benchmark compile seconds | Admission |
|---|---:|---:|---:|---:|---:|---|
| baseline127 | 39.168 | 25531.1 | control | — | 114.658 | Control |
| sparse32 | 41.983 | 23819.1 | -6.705% | -2.815 | 120.269 | Slower on every trial |
| discovery | 39.155 | 25539.8 | +0.034% | +0.013 | 114.502 | Not clearly separated |
| atomic | 98.332 | 10169.7 | -60.168% | -59.164 | 115.880 | Slower on every trial |

The control range was **39.153813–39.234166 µs**. Sparse32 ranged **41.845352–42.015017 µs**, discovery **39.056432–39.240803 µs**, and atomic **97.854671–98.470786 µs**. Fewer instructions did not produce faster atomic marking in this measurement. This measures the complete source change; it does not isolate the cause of the slowdown or establish performance on x86.

The session ran 15:05:17–15:14:03 UTC on the same Apple M4 Pro with Swift 6.3.3. Before/after snapshots showed no competing build/test/benchmark processes or audio assertions. Before compilation, the orchestrator Python process was 11.8%, WindowServer 10.9%, NeptuneOneWallpaper 4.7% and VTDecoderXPCService 2.3%; after completion, backupd was 4.2%. These endpoint observations do not establish uninterrupted machine idleness or exclude visual background activity. Compiler wall times are one build per variant, not a replicated build-time study.

The three rounds ran in these orders: baseline127/sparse32/discovery/atomic; sparse32/discovery/atomic/baseline127; discovery/atomic/baseline127/sparse32. Builds completed serially before the first timing trial. As in the cutoff session, three rotations do not fully balance four positions.

[Raw results](../sparse-discovery-atomic-results-20260912.json), [execution and conditions](../sparse-discovery-atomic-execution-20260912.json), [compiler events](../sparse-discovery-atomic-compiler-20260912.jsonl), [recomputed analysis](../sparse-discovery-atomic-analysis-20260912.json).

## Disposition and evidence

PR #16's cutoff 111 qualifies for consideration, with a narrow 0.036377 µs trial-range gap and a lower observed compile cost. Cutoffs 79 and 95 do not qualify against 127. PR #17 is slower, PR #18 is flat, and PR #19 is slower. They do not qualify for integration on this evidence. All four PRs and their source commits remain unmerged; this review makes no adoption decision.

The second session provides no direct comparison between cutoff 111 and its three candidates. Neither session establishes a Linux or Threadripper speedup. Existing Linux correctness coverage is for exact bd3858c, not these follow-up commits.

The [measurement wrapper](../followup-four-evidence/measurement-tools/run-followup-timing.py), [compiler launcher](../followup-four-evidence/measurement-tools/swiftc-timing-shim.py), [support](../followup-four-evidence/measurement-tools/primes_run_support.py), and [analysis script](../followup-four-evidence/measurement-tools/analyze-followup-timing.py) are preserved. The initial wrapper before the optional retry label is retained in measurement-tools-initial; the failed preflight record identifies its hashes. Registration is immutable historical input: its not_started value describes timing at registration, not final status.

An independent Codex subagent audited both completed sessions: 15 cutoff runs and 12 sparse/discovery/atomic runs. Source identities, frozen harness, compiler records, validation, rotations, arithmetic and cleanup were consistent. Cutoff 111 alone qualified against cutoff 127 under the registered non-overlap screen, gaining 0.540074% throughput and saving 0.207573 µs. Cutoff 79, sparse32 and atomic were slower; cutoff 95 and discovery did not clearly separate. The initial cutoff audio-preflight failure is preserved and produced no compilation or measurements. Endpoint snapshots recorded no monitored build/test/benchmark conflict or audio assertion, but do not provide continuous monitoring. Rotations were not fully position-balanced, and admission is not a statistical-significance claim. Comparisons remain within their respective sessions; no merge is implied. [Independent audit record](../followup-four-independent-audit.json).
