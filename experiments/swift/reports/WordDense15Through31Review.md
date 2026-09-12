# Experiment 5: word handlers through factor 31

Codex review of exact candidate `7ee65009d6ed2ed497a32688fa818b2eaffabc86`, against parent/development control `5f1a3e8a32af96aa3196f1cfed155310ba8c4b6d`. Shared record: [PR #5](https://github.com/fahlman/Primes/pull/5). Review and measurements were performed on September 11, 2026 local time (September 12 UTC).

## Review

**No blocking findings.** The candidate meets `experiments/swift/AGENTS.md` and preserves the project's source-based `algorithm=base,faithful=yes,bits=1` classification. This is a local review, not an upstream maintainer acceptance decision.

The PR's Swift generator was executed for odd factors 5–31. Its complete output matches every switch case exactly: 14 cases and 252 `markWord` calls. Independent read-only regeneration confirmed that each p-word group marks precisely offsets `0, p, ..., 63p`, with each word's first offset given by `(-64*j) mod p`. The existing cases 5–13 are byte-identical to the control; nine new cases add 207 word calls. Outside them, executable changes are the dispatch bound `p < 14` to `p < 32` and the default precondition-failure message.

Runtime discovery still tests odd candidates in sequence and dispatches only after finding an unmarked factor. Composite cases 9, 15, 21, 25, and 27 remain present but unreachable in a valid sieve. No prime list, wheel, presieving, mask table, or cross-pass state was added. Each source-level mark remains one single-bit OR inside `markWord`; the compiler performs the mask folding/vectorization.

The unchanged prefix starts at p² and advances by p bit positions until alignment, within at most 63 marks because odd p is coprime to 64. The complete-group guard `word + p <= fullWords` bounds every eight-byte access. Advancing by p words preserves the multiple's phase; the unchanged bounded tail resumes at that next multiple. Existing unaligned raw access and little-endian handling remain unchanged. The newly active prime factors first get a complete group at limits 3,585 (17), 3,969 (19), 5,633 (23), 4,609 (29), and 8,833 (31), all covered by the exhaustive extra checks.

## Independent verification

The candidate's three required checks all exited 0 with no sanitizer diagnostics:

- `swiftc -O -sanitize=address PrimeSieve.swift Verify.swift`, followed by its executable.
- `swiftc -O -whole-module-optimization PrimeSieve.swift Verify.swift`, followed by its executable.
- `swiftc -O -sanitize=address PrimeSieve.swift ExtraVerify.swift`, followed by its executable.

The first two compare complete prime arrays for every limit −2–2,048, selected larger square boundaries, 1M, and 10M, including repeated marking. ExtraVerify compares complete arrays for every limit 2,049–20,000, 500 seeded random limits through 2M, and 1,561 cases within three of every prime square through 2M. The Swift generator also exited 0 and matched the candidate byte-for-byte.

[Verification evidence](../word-dense-15-31-verification-7ee6500.json) records exact commands, exit codes, outputs, source hashes, generator source/output, assembly hashes/statistics, and timing conditions. The tests, sieve, runner, observer, and comparison scripts were not modified.

## Assembly and code size

| Property | Control 5f1a3e8 | Candidate 7ee6500 |
|---|---:|---:|
| runSieve instructions | 480 | 1,060 |
| Instruction bytes | 1,920 | 4,240 |
| Static 128-bit vector OR instructions | 23 | 122 |
| Factor-3 `st3.16b` instructions | 1 | 1 |
| 64-bit variable shifts in runSieve | 0 | 0 |

Counts include operand-free `ret` and exclude labels, directives, constants, padding, and other functions. Static instruction counts are not dynamic execution counts. Both assemblies keep the word helper fully inlined and the opaque observer as a real `bl` call. This reproduces Claude's 1,060-instruction observation: runSieve grew by 580 instructions, or 121%. It establishes code growth, not the size of any instruction-cache penalty.

The pre-timing [Codex review](https://github.com/fahlman/Primes/pull/5#issuecomment-5642353571) was posted after these checks and before timing.

## Measured result

**16.77% more throughput** than development control `5f1a3e8`, or **14.36% less time per pass**. The median saving is **8.292 microseconds per sieve**. Every candidate trial was faster than every control trial.

| Variant | Trial 1 ms/pass | Trial 2 | Trial 3 | Median |
|---|---:|---:|---:|---:|
| Development control `5f1a3e8` | 0.057114 | 0.057738 | 0.057804 | 0.057738 |
| Candidate `7ee6500` | 0.049446 | 0.049370 | 0.050153 | 0.049446 |

[Raw timing results](../word-dense-15-31-results-7ee6500.json) contain all six outputs, prime-count validations, source hashes, exact revisions, compiler and machine metadata, and run order. All six executions exited successfully, ran for at least five seconds, validated 78,498 primes, and reported one thread with `algorithm=base,faithful=yes,bits=1`.

Apple M4 Pro, arm64, Apple Swift 6.3.3; all variants used `-O -whole-module-optimization`. The runner and separately compiled observer were frozen at `25402d46ba991b39451724d3873d326626981e3f`. Fresh allocation, initialization, sieving, opaque observation, and release were included in each pass. Compilation, validation, prime enumeration, and output were excluded. Both executables were compiled before the three serial rotated rounds: control/candidate, candidate/control, control/candidate.

The timing lock was acquired exclusively before compilation and released in `finally`. No competing build, test, benchmark, or media playback was observed; the power-assertion check found no audio assertion. The desktop remained active. The pre-run snapshot showed Codex Renderer at 13.6% CPU and WindowServer at 6.7%; before/after snapshots are in the verification evidence. Three trials and active-desktop measurements limit precision, so the exact percentage is provisional.

The requested `5f1a3e8` control is byte-identical in sieve, runner, observer, and comparison script to current development `0c370b5d87e01989f176dfd07a98e068b0c9f3aa`, whose newer changes are documentation/results. Thus this session includes the current implementation as the development control without timing a duplicate executable. This is **not a new measurement against upstream**: the project baseline remains `PrimeSwift_1bitStriped_u8` at `22bfea9`, and no upstream ratio is inferred by multiplying earlier runs.

Reproduce from the review worktree's `experiments/swift` directory, after acquiring the timing lock and choosing a new output filename:

```sh
python3 compare_optimizations.py \
  --variant control=5f1a3e8a32af96aa3196f1cfed155310ba8c4b6d \
  --variant word-dense-15-31=7ee65009d6ed2ed497a32688fa818b2eaffabc86 \
  --output word-dense-15-31-results-7ee6500.json
```

## Decision and code-size interpretation

**Recommended for adoption; review and requested timing are complete. Integration is pending.** The larger runSieve still produces a clear net gain in this session, within Claude's hypothesized 10–20% throughput range. That does not tell us whether code size reduced a still larger possible gain: this comparison changes the marking strategy and code size together, and does not isolate instruction-cache behavior. No cache profiling or extra optimization experiment was performed.

No implementation changes were made in this review. Docker/Linux execution remains untested. The published review branch preserves the candidate, report, and raw evidence; prior measurement files remain unchanged.
