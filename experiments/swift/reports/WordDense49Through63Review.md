# Experiment 7: word handlers through factor 63

Codex reviewed **only the delta from `404d1cbd725ee9d70f8bd52ee412326398424413` to `19aa38a0049e3507a687c482ee446f98ca38d299`** for [PR #8](https://github.com/fahlman/Primes/pull/8). The candidate is stacked on experiments 5 and 6, whose independent reviews remain in [PR #5](https://github.com/fahlman/Primes/pull/5) and [PR #7](https://github.com/fahlman/Primes/pull/7). Review and timing were performed September 11, 2026 local time (September 12 UTC).

## Review findings

**No blocking findings.** The delta preserves the project's source-based `algorithm=base,faithful=yes,bits=1` classification. This is our code review under AGENTS.md, not a guarantee of upstream acceptance.

The eight new cases for odd factors 49–63 contain 448 word calls. The PR #5 Swift generator, preserved in review commit `a334f451ed91e08fb74b3b7d08c7291ea58e2848`, was run with `5 63`; its complete output matches all 30 candidate case blocks and 1,020 calls byte-for-byte. Independent read-only regeneration confirms each block's guard, offsets and increment; all 22 old cases for 5–47 are byte-identical. Each p-word group covers exactly the 64 offsets `0, p, ..., 63p`, using word j's first bit `(-64*j) mod p`.

Dispatch remains behind sequential runtime odd-candidate discovery. Newly reached factors are 53, 59 and 61; composite cases 49, 51, 55, 57 and 63 remain unreachable in a valid sieve. Every source-level mark remains one single-bit OR. No prime list, presieving, wheel, mask table or retained state was introduced. Fresh allocation, initialization, result storage and release are unchanged in source.

The prefix still starts at p² and advances by p bit positions until reaching a word boundary, within at most 63 marks. The `word + p <= fullWords` guard bounds all eight-byte accesses. Advancing by p words preserves the multiples' phase; the bounded tail resumes at the next multiple. Unaligned access, byte order and larger-factor wrapping loops are unchanged. Removing the new cases and documentation changes and restoring the dispatch/diagnostic bounds reproduces the entire parent sieve source.

## Independent verification

Every command in the [verification record](../word-dense-49-63-verification-19aa38a.json) exited 0, with no sanitizer diagnostics:

- Verify.swift with `-O -sanitize=address`.
- Verify.swift with `-O -whole-module-optimization`.
- The expanded ExtraVerify.swift with `-O -sanitize=address`.
- The Swift generator and both assembly builds.

Verify.swift compares complete prime arrays for every limit −2–2,048, larger square boundaries, 1M and 10M, and checks repeated marking. ExtraVerify compares complete arrays for every limit 2,049–30,000, 500 seeded random limits through 2M, and 1,561 limits within three of every prime square through 2M.

ExtraVerify's only behavioral change is expanding its exhaustive upper bound from 20,000 to 30,000: 10,000 additional limits, or 27,952 exhaustive limits in total. Its reference algorithm, random seed, random checks and square-boundary checks are unchanged.

| Newly active factor | Prefix marks to alignment | First complete-group limit | Second complete-group limit |
|---|---:|---:|---:|
| 53 | 17 | 11,393 | 18,177 |
| 59 | 15 | 12,801 | 20,353 |
| 61 | 1 | 11,649 | 19,457 |

The expanded exhaustive range covers every new handler's first and second group transitions and the intervening tail lengths. The previous 20,000 bound missed factor 59's second transition at 20,353. Composite cases were checked statically because valid runtime discovery cannot dispatch to them.

## Assembly and outlining

| Property | Through 47, 404d1cb | Through 63, 19aa38a |
|---|---:|---:|
| runSieve instructions | 1,831 | 246 |
| Separate word-handler instructions | Inlined | 2,530 |
| Total sieve instructions | 1,831 | 2,776 |
| Total instruction bytes | 7,324 | 11,104 |
| Total static 128-bit vector OR instructions | 278 | 498 |
| Factor-3 `st3.16b` instructions | 1 | 1 |
| 64-bit variable shifts in sieve functions | 0 | 0 |

The count includes operand-free `ret` and excludes labels, directives, constants, padding and other functions. Static counts do not measure executed instructions. Both versions retain the real opaque observer call outside the sieve functions.

The compiler now keeps `markWordDenseMultiples` separate, called by runSieve once for each discovered word-handled factor: 16 calls per million-limit pass. Inside that function, the per-word helper is fully inlined; there are 495 `orr.16b` instructions, no calls, no 64-bit variable shifts, and 32 loop headers (30 case-group loops, prefix and tail). The other three vector ORs are in runSieve. Total sieve code grows by 945 instructions, or 51.61%.

**Outlining is not demonstrably only call overhead.** It can also alter register allocation, optimization context, scheduling and instruction layout. The comparison measures the net effect of the new handlers and those compiler changes together. It does not isolate the marking-band gain, call overhead, or instruction-cache effects.

The [pre-timing Codex review](https://github.com/fahlman/Primes/pull/8#issuecomment-5642700498) was posted after correctness/assembly verification and before timing.

## Three-way timing result

**Through 63 adds 9.92% more throughput over through 47**, reducing time per sieve by 9.03% and saving **4.204 microseconds per pass**. Every through-63 trial beat every through-47 trial, and every through-47 trial beat every development-control trial. Even the slowest through-63 trial exceeded the fastest through-47 trial's throughput by 8.85%.

| Variant | Trial 1 ms/pass | Trial 2 | Trial 3 | Median |
|---|---:|---:|---:|---:|
| Development control `0c370b5` | 0.057458 | 0.058000 | 0.058073 | 0.058000 |
| Through 47 `404d1cb` | 0.046348 | 0.046580 | 0.046838 | 0.046580 |
| Through 63 `19aa38a` | 0.042178 | 0.042376 | 0.042581 | 0.042376 |

In this same session, through 47 improved throughput by 24.52% over development, and through 63 by 36.87%. These are development comparisons, not a new upstream-baseline measurement. The outcome exceeds the author's approximately 3% hypothesis and Codex's approximately 2% guess; neither prediction was a measurement, and this result does not identify why the combined change exceeded them.

All nine executions exited successfully, ran for at least five seconds, validated 78,498 primes and reported one thread with `algorithm=base,faithful=yes,bits=1`. [Raw timing evidence](../word-dense-49-63-results-19aa38a.json) contains exact revisions/source hashes, outputs, validation, medians, hardware/toolchain, harness hashes and run order.

Apple M4 Pro, arm64, Apple Swift 6.3.3. All variants used `-O -whole-module-optimization` and the same Swift runner and separately compiled observer frozen at `25402d46ba991b39451724d3873d326626981e3f`. Timed passes include fresh allocation, initialization, sieving, opaque observation and release. Compilation, validation, enumeration and output are excluded.

All executables were compiled before these serial, rotated rounds:

1. `0c370b5`, `404d1cb`, `19aa38a`.
2. `404d1cb`, `19aa38a`, `0c370b5`.
3. `19aa38a`, `0c370b5`, `404d1cb`.

Each variant occupies each position once. `/tmp/primes-timing.lock` was created exclusively before compilation, held through timing and removed in `finally`; the explicit `--output` preserved earlier results. No competing build, test or benchmark process, or audio/playback assertion, was detected in the before/after snapshots. The desktop was active before compilation: WindowServer 39.7%, Safari 13.7%, WebContent 11.6% and Codex Renderer 10.9% CPU; after the run WindowServer was 3.9% and Codex Renderer 0.9%. Full snapshots are in the verification record. These limited local trials establish a clear separation in this session; precise percentages remain provisional and do not establish x86/Linux performance.

To reproduce from this review worktree's `experiments/swift` directory, acquire the timing lock first and use a fresh output filename:

```sh
python3 compare_optimizations.py \
  --variant development=0c370b5d87e01989f176dfd07a98e068b0c9f3aa \
  --variant through-47=404d1cbd725ee9d70f8bd52ee412326398424413 \
  --variant through-63=19aa38a0049e3507a687c482ee446f98ca38d299 \
  --output word-dense-49-63-results-19aa38a-rerun.json
```

## Recommendation and stack status

**Recommend adopting through 63 on top of experiments 5 and 6. Integration remains pending.** The result clearly separates from through 47, so the proposed condition for closing PR #8 is not met. This completes the planned extension through 63; no higher band or other optimization was implemented or timed.

PR #8 remains stacked on PRs #7 and #5, with the author's rebase planned after those are merged. The reviewed and measured candidate is exactly `19aa38a`. This review changed no sieve, test, runner, observer or comparison-script source. Docker/Linux execution remains untested.
