# Swift optimization experiment results

Recorded September 11, 2026. The retained small-factor specialization increases throughput by **45.4%** over our saved Swift baseline. Stream fusion showed no improvement and was not adopted. No combined variant was tested.

## Measurements

Hardware: Apple M4 Pro, arm64, macOS 26.6.2. Compiler: Apple Swift 6.3.3, `-O -whole-module-optimization`. Each executable uses one thread, a limit of one million, and `algorithm=base,faithful=yes,bits=1`.

| Variant | Trial 1 ms/pass | Trial 2 ms/pass | Trial 3 ms/pass | Median ms/pass |
|---|---:|---:|---:|---:|
| Saved baseline | 0.118822 | 0.120610 | 0.119792 | 0.119792 |
| Stream fusion | 0.119423 | 0.121191 | 0.121665 | 0.121191 |
| Small-factor specialization | 0.083264 | 0.081792 | 0.082380 | 0.082380 |

The dense candidate took 31.2% less time per sieve. Its three measurements were consistently below all three baseline measurements. Fusion was approximately 1.2% slower by median; this small difference does not establish a general regression, but provides no reason to adopt it here.

All executables were built before timed runs began. Runs were serial, rotating the order across three rounds. Every executable used the frozen baseline runner and separately compiled Swift observer; only the sieve source and printed label varied. Allocation, initialization, marking, observation, and release occur inside each measured pass. Validation, enumeration, compilation, and output do not. All nine executions validated 78,498 primes and exited successfully. The raw output, validation messages, run order, compiler/platform information, source hashes, and commit IDs are in [optimization-results.json](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/optimization-results.json).

## Changes and decision

**Stream fusion:** four residue cases supply constant single-bit masks for eight successive composites. Instead of finishing eight independent traversals, one loop issues eight marks in address order and advances by the factor. It passed correctness checks, but the measured result did not improve on the existing four-store striped loop. This experiment remains on its own branch.

**Small-factor specialization:** when runtime discovery finds factor 3, 5, or 7, a bounded initial loop marks from p² until reaching a byte boundary. Each complete group then processes eight successive multiples using explicit single-bit ORs into local byte variables, storing each byte once. A bounded scalar tail completes the remaining marks. All larger factors keep the baseline marking loop. Allocation, factor discovery, enumeration, and storage layout are unchanged.

These are all odd factors below eight. The implementation neither assumes a separate list of primes nor copies presieved patterns. It retains a fresh class-owned, dynamically allocated buffer on every pass. Source review found no correctness or classification issue under the repository's individual-marking rule and the precedents described in the [research review](OtherLanguageOptimizationReview.md). Maintainer acceptance still depends on the eventual submitted implementation.

Both candidates passed the unchanged `Verify.swift` with AddressSanitizer: complete prime arrays for limits -2 through 2,048, larger square boundaries, one million, ten million, and repeated marking. The final dense entry point also ran successfully for five seconds after its printed label was updated. No further sieve-code change followed its timed comparison.

## Reproduce

Run from `experiments/swift` in a clone of this fork. The commit references freeze the measured source, even if development branches later move.

```sh
python3 compare_optimizations.py \
  --variant baseline=25402d46ba991b39451724d3873d326626981e3f \
  --variant stream-fusion=f0cd82df7c1c24e02b25dab259ec3d3ffc4732be \
  --variant dense-small-factors=b45c0c199ab43567636e9b79310fc925b80b42af
```

The command runs three five-second trials per candidate (45 seconds total, plus compilation) and replaces `optimization-results.json`. Pass `--output PATH` to keep the original record. Build products are ignored under `.build/optimization-comparison`.

The original three repository Swift entries were not rerun in this experiment. Their earlier comparison against the saved baseline remains in [EqualTermsSwiftComparison.md](EqualTermsSwiftComparison.md). Docker/Linux execution remains untested.
