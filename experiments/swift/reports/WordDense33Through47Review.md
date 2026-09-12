# Experiment 6: word handlers through factor 47

Codex reviewed **only the delta from `7ee65009d6ed2ed497a32688fa818b2eaffabc86` to `404d1cbd725ee9d70f8bd52ee412326398424413`** for [PR #7](https://github.com/fahlman/Primes/pull/7). The branch is stacked on experiment 5, whose independent review remains in [PR #5](https://github.com/fahlman/Primes/pull/5). Review and timing were performed September 11, 2026 local time (September 12 UTC).

## Review findings

**No blocking findings.** The delta preserves the project's source-based `algorithm=base,faithful=yes,bits=1` classification. This is our code review under AGENTS.md, not a guarantee of upstream acceptance.

The candidate adds eight cases for every odd factor 33–47, containing 320 word calls. The PR #5 Swift generator, preserved in review commit `a334f451ed91e08fb74b3b7d08c7291ea58e2848`, was run with `5 47`; its complete output matches all 22 candidate case blocks and 572 calls byte-for-byte. Independent read-only regeneration also verified each block's loop guard, offsets and increment, and confirmed all old 5–31 cases are unchanged. Every p-word block covers exactly offsets `0, p, ..., 63p`, using each word j's first bit `(-64*j) mod p`. Outside the new cases, source changes are the dispatch bound `p < 32` to `p < 48`, the precondition-failure range message and documentation.

Dispatch remains behind sequential runtime odd-candidate discovery. Newly reached factors are 37, 41, 43 and 47; the new composite cases 33, 35, 39 and 45 are present but unreachable in a valid sieve. Each source-level mark remains one single-bit OR. No prime list, presieving, wheel, mask table, or retained sieve state was added. Allocation, initialization, result storage and release are unchanged.

The unchanged prefix starts at p² and advances by p bit positions to a word boundary, within at most 63 marks. Each new group requires `word + p <= fullWords`, bounding all eight-byte accesses. Advancing by p words preserves the phase of the multiples. The unchanged tail resumes at the next multiple and checks `bit < oddCount`. Unaligned access, byte order, larger-factor wrapping loops, and enumeration are unchanged.

## Independent verification

Every command in the [verification record](../word-dense-33-47-verification-404d1cb.json) exited 0. No sanitizer diagnostics occurred:

- Verify.swift with `-O -sanitize=address`.
- Verify.swift with `-O -whole-module-optimization`.
- ExtraVerify.swift with `-O -sanitize=address`.
- The Swift case generator and both assembly builds.

Verify.swift compares complete arrays for every limit −2–2,048, larger square boundaries, 1M and 10M, and checks repeated marking. ExtraVerify compares complete arrays for every limit 2,049–20,000, 500 seeded random limits through 2M, and 1,561 limits within three of every prime square through 2M.

| Newly active factor | Prefix marks to alignment | First complete-group limit | Second complete-group limit |
|---|---:|---:|---:|
| 37 | 49 | 9,729 | 14,465 |
| 41 | 17 | 8,321 | 13,569 |
| 43 | 47 | 11,393 | 16,897 |
| 47 | 31 | 11,137 | 17,153 |

The exhaustive extra checks therefore cover each new active handler's first and second group transitions and all intervening tail lengths. Composite cases were checked statically; valid sieve execution cannot exercise them. No new test or benchmark infrastructure was added.

## Assembly

| Property | Experiment 5, 7ee6500 | Experiment 6, 404d1cb |
|---|---:|---:|
| runSieve instructions | 1,060 | 1,831 |
| Instruction bytes | 4,240 | 7,324 |
| Static 128-bit vector OR instructions | 122 | 278 |
| Factor-3 `st3.16b` instructions | 1 | 1 |
| 64-bit variable shifts in runSieve | 0 | 0 |

The count includes operand-free `ret` and excludes labels, directives, constants, padding and other functions. Static instruction counts do not measure executed instructions. The word helper is fully inlined in both versions; both retain the real opaque observer call outside runSieve. The candidate adds 771 instructions, or 72.74%. This confirms the code-growth claim without attributing a measured instruction-cache cost.

The [pre-timing Codex review](https://github.com/fahlman/Primes/pull/7#issuecomment-5642525828) was posted after correctness/assembly verification and before the timing session.

## Three-way timing result

**Experiment 6 adds 6.62% more throughput over experiment 5**, reducing time per sieve by 6.21% and saving **3.083 microseconds per pass**. Every through-47 trial beat every through-31 trial, and every through-31 trial beat every development-control trial.

| Variant | Trial 1 ms/pass | Trial 2 | Trial 3 | Median |
|---|---:|---:|---:|---:|
| Development control `0c370b5` | 0.057162 | 0.058172 | 0.058308 | 0.058172 |
| Experiment 5 `7ee6500` | 0.049509 | 0.049637 | 0.050318 | 0.049637 |
| Experiment 6 `404d1cb` | 0.046297 | 0.046554 | 0.046598 | 0.046554 |

In this same session, experiment 5 improved throughput by 17.19% over the development control, and experiment 6 by 24.95%. These are development-control comparisons, not a new upstream-baseline measurement.

All nine executions exited successfully, ran for at least five seconds, validated 78,498 primes, and reported one thread with `algorithm=base,faithful=yes,bits=1`. [Raw timing evidence](../word-dense-33-47-results-404d1cb.json) includes exact commit/source hashes, every output and validation, medians, toolchain/hardware, harness hashes and run order.

Apple M4 Pro, arm64, Apple Swift 6.3.3. All three variants used `-O -whole-module-optimization` with the same Swift runner and separately compiled observer frozen at `25402d46ba991b39451724d3873d326626981e3f`. Every timed pass includes fresh allocation, initialization, sieving, opaque observation and release. Enumeration, validation, compilation and output are outside timing.

All executables were compiled before the serial, rotated rounds:

1. `0c370b5`, `7ee6500`, `404d1cb`.
2. `7ee6500`, `404d1cb`, `0c370b5`.
3. `404d1cb`, `0c370b5`, `7ee6500`.

Each variant occupies each position once. `/tmp/primes-timing.lock` was created exclusively before compilation, held through timing, and removed in `finally`. The explicit `--output` filename preserved earlier results. No competing build, test, benchmark or media playback was observed, and no audio assertion was present. The desktop was active: the pre-run snapshot showed Codex Renderer at 16.2% CPU and WindowServer at 12.9%; before/after snapshots are in the verification record. These are limited local trials, so the precise percentages are provisional.

To reproduce from this review worktree's `experiments/swift` directory, acquire the timing lock first and use a fresh output filename:

```sh
python3 compare_optimizations.py \
  --variant development=0c370b5d87e01989f176dfd07a98e068b0c9f3aa \
  --variant through-31=7ee65009d6ed2ed497a32688fa818b2eaffabc86 \
  --variant through-47=404d1cbd725ee9d70f8bd52ee412326398424413 \
  --output word-dense-33-47-results-404d1cb-rerun.json
```

## Recommendation and stack status

**Recommend adopting the 33–47 extension on top of experiment 5. Integration remains pending.** This was not a flat result, so the proposed stop condition was not reached. The extra 771 instructions still produce a clear net gain in this session. The comparison changes marking strategy and code size together; it cannot isolate an instruction-cache penalty or establish whether a smaller function could be faster still.

This review does not predict a gain from extending to 49–63, and no further band was implemented or timed. PR #7 remains stacked on PR #5; the author plans to rebase after #5 is merged. Exact reviewed and measured commits remain those above. No sieve, test, runner, observer or comparison-script changes were made during review. Docker/Linux execution remains untested.
