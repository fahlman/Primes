# Review and timing of the two dense-word experiments

Codex reviewed both exact candidates on 2026-09-11 against the shared AGENTS.md at `0d0a142` and the repository's contributing rules. **Both pass: no blocking correctness or category findings.** Independent required correctness checks passed, reviews were posted on the PRs before timing, and both candidates improved throughput in the requested shared comparison.

| Experiment | PR | Exact candidate |
| --- | --- | --- |
| 2: factors 9–13 on words | [#3](https://github.com/fahlman/Primes/pull/3) | `7b63048bc31d6740b3af690e9be99771ea3d26a4` |
| 3: factors 5 and 7 on words | [#1](https://github.com/fahlman/Primes/pull/1) | `62e5a596359d07fedaba6e22a7aa786bed7c40fd` |

Baseline: `0d0a1422df12f66b0047393f9ae40ed233061a8a`, the current `swift/dense-small-factors` head. Review artifacts live on a separate `swift/word-dense-review` branch and worktree; the candidate and development branches were not changed.

## Correctness and source classification

Both implementations peel individual multiples from p² to the first 64-bit boundary. Since each handled factor is odd, at most 63 increments reach that boundary. For word position j in a group, its first multiple has bit offset `(-64*j) mod p`. The hard-coded offsets agree with that formula for every case: 9/11/13 in experiment 2 and 5/7 in experiment 3. A group of p words marks exactly 64 consecutive multiples, and the next group or scalar tail starts at the next multiple.

The loop guard `word + p <= fullWords`, where `fullWords = oddCount >> 6`, restricts all word operations to complete words of initialized storage. Every eight-byte access fits. Prefix and tail writes are individually bounded by `oddCount`, so no partial word is loaded or stored. Existing flags are preserved by each OR. The counters and word-to-byte offsets remain within the allocation-derived bounds; no wrapping arithmetic is added by either experiment.

The storage remains bound to UInt8. The code accesses it through raw `loadUnaligned` and `storeBytes`, not a rebound or assumed-aligned UInt64 pointer. The installed Swift standard-library interface and [SE-0107 raw memory access](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0107-unsaferawpointer.md#raw-memory-access) / [SE-0349 unaligned operations](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0349-unaligned-loads-and-stores.md#proposed-solution) support these accesses. Both types admit all bit patterns. Conversion from little-endian after the load, and to little-endian before the store, preserves the byte/bit mapping.

Both candidates continue to discover factors by checking every odd candidate in order. Dispatch happens only after a runtime prime test. Every odd value in each specialized range has a handler; experiment 2 includes 9, even though the sieve excludes it at runtime. Each composite still receives its own single-bit OR in source. No wheel, presieving, mask table, multi-bit source mask, restored prime, retained state, or extra thread is introduced. The class continues to own fresh runtime-sized storage and the complete flags on every pass. This preserves the project's source-based `algorithm=base,faithful=yes,bits=1` classification; compiler folding/vectorization of the individual operations is not a source-level composite-pattern table.

Experiment 2 leaves the byte handlers for 3/5/7 unchanged. Experiment 3 moves 5/7 to words and leaves the factor-3 byte marking operations unchanged. The existing larger-factor streams and the benchmark/observer code are unchanged by both candidates.

## Independent checks

For each exact candidate, all three required configurations passed, with every build and executable exiting 0:

- `swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o verify-asan`, followed by `./verify-asan`.
- `swiftc -O -whole-module-optimization PrimeSieve.swift Verify.swift -o verify`, followed by `./verify`.
- `swiftc -O -sanitize=address PrimeSieve.swift ExtraVerify.swift -o extra-verify-asan`, followed by `./extra-verify-asan`.

Verify.swift compared complete prime arrays for every limit from -2 through 2048, larger prime-square boundaries, 1M and 10M. ExtraVerify.swift checked 500 seeded random limits and 1,561 limits around prime squares through 2M. Experiment 2 additionally checked every limit from 2,049 through 20,000. This covers its first actual word groups (limit 2,561 for factor 11 and 2,689 for factor 13) and every possible tail length. Experiment 3's first word groups occur at limit 1,153; Verify.swift's exhaustive range already covers all its tail lengths. No sanitizer errors were reported.

The exact candidate sources were also compiled to arm64 assembly using `-O -whole-module-optimization`, with the observer separately compiled. Both candidates inline markWord, fold the individual-bit loops into constant OR operations, use vector ORs for adjacent words, and retain factor 3's `st3.16b` loop. No variable 64-bit shifts or markWord calls remain in runSieve. The factor-5 loop visibly uses two 128-bit ORs and one 64-bit OR per group. Each benchmark retains a real `bl` call to the opaque observer.

[Verification commands, exit statuses, output, source hashes and assembly checks](../word-dense-verification-7b63048-62e5a59.json).

PR reviews recorded before timing: [experiment 2](https://github.com/fahlman/Primes/pull/3#pullrequestreview-5184387657), [experiment 3](https://github.com/fahlman/Primes/pull/1#pullrequestreview-5184387735).

## Shared timing session

The process acquired `/tmp/primes-timing.lock` exclusively before building the comparison and released it in `finally` afterward. No competing compiler, test, or benchmark process was detected at the preflight check. Both independent reviews and all checks finished before this run. No review build or test ran in parallel with timing. All three benchmark executables were built before any measured trial.

```sh
python3 experiments/swift/compare_optimizations.py \
  --variant current=0d0a1422df12f66b0047393f9ae40ed233061a8a \
  --variant word9-13=7b63048bc31d6740b3af690e9be99771ea3d26a4 \
  --variant word5-7=62e5a596359d07fedaba6e22a7aa786bed7c40fd \
  --output experiments/swift/word-dense-results-7b63048-62e5a59.json
```

Reference machine: Apple M4 Pro, Swift 6.3.3, macOS 26.6.2, arm64. Identical `-O -whole-module-optimization` flags, frozen Swift runner and separate observer from `25402d46ba991b39451724d3873d326626981e3f`, limit 1,000,000 and one thread. Allocation, initialization, sieve execution, opaque observation and release are inside each timed pass; validation and enumeration are outside. All nine runs lasted at least five seconds and validated 78,498 primes. The comparison exited 0.

Run order: current / 9–13 / 5–7; 9–13 / 5–7 / current; 5–7 / current / 9–13.

| Variant | Trial 1 ms/pass | Trial 2 ms/pass | Trial 3 ms/pass | Median ms/pass | Throughput vs current |
| --- | ---: | ---: | ---: | ---: | ---: |
| Current dense | 0.080967 | 0.081957 | 0.081444 | 0.081444 | +0.00% |
| Experiment 2: words for 9–13 | 0.071367 | 0.071580 | 0.071951 | 0.071580 | +13.78% |
| Experiment 3: words for 5 and 7 | 0.074560 | 0.074382 | 0.073536 | 0.074382 | +9.49% |

Every sample from either candidate was faster than every baseline sample. Experiment 2 produced 13.78% more median passes per second; experiment 3 produced 9.49% more. The percentages come from this single shared baseline session, not historical measurements.

Environment qualification: no competing build/test/benchmark or playback assertion was observed before the session. Normal desktop activity remained: a brief address-book synchronization process used approximately 24% of one CPU in the preflight snapshot, and WindowServer ranged from roughly 14% before to 45% after. These snapshots do not prove the machine was idle throughout. The results consistently support improvement in this session, but exact percentages can vary with system load and scheduling.

[Raw timing results, including every output, full revisions, source hashes, flags and run order](../word-dense-results-7b63048-62e5a59.json). Earlier result files were preserved.

## Decision and limits

Both experiments are suitable for the proposed combined follow-up candidate, subject to its own review and timing. Their gains are not additive evidence, and neither this run nor the earlier wrapping run measures their combination. No implementation was merged or promoted to Current best here. The existing conflicts between experiments 2 and 3 remain for the implementation follow-up to resolve. Docker/Linux and big-endian execution are untested; the three upstream Swift entries were not part of this comparison.
