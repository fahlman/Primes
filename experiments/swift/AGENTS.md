# Swift sieve experiments: instructions for coding agents

These instructions apply to everything in `experiments/swift`, and this file doubles as the project brief. It and `CLAUDE.md` belong to the fahlman/Primes fork only. Never include them, or anything else under `experiments/`, in a pull request to PlummersSoftwareLLC/Primes.

## Goal

Beat the three upstream Swift entries in `PrimeSwift/solution_1` (`PrimeSwift_8bitBool`, `PrimeSwift_1bit_u8`, `PrimeSwift_1bitStriped_u8`) on equal terms, in one category: `algorithm=base,faithful=yes,bits=1`, one thread, limit 1,000,000. Wheel, cached-state, and multithreaded variants are deferred.

## Baseline and development controls

The project baseline is currently `PrimeSwift_1bitStriped_u8` at upstream `22bfea9`, as established in [the direct comparison](reports/UpstreamBaselineComparison.md). In general, it is the fastest of the three upstream Swift implementations, measured with the same runner, compiler flags, machine, and timing session as our candidate. Pin the upstream commit and identify the winning entry in each report. The Bool entry uses `bits=8`; retain that label when comparing it with the three `bits=1` implementations.

Our earlier versions are development controls: they measure the contribution of an optimization. The historical `swift/baseline` branch (`25402d4`) and `0d0a142` are development controls, not the upstream baseline. Preserve those branches and historical results. Report gains over the upstream baseline separately from gains over a development control.

## Current best

- `swift/dense-small-factors`: sixteen-write fused sparse loop, source `59262fe`, adopted through [PR #12](https://github.com/fahlman/Primes/pull/12) in merge commit `83751ea`. The merge preserves the reviewed commits and exact sieve, runner, observer and verification source.
- One bit per odd candidate. Runtime-discovered factor 3 uses dense byte marking; odd factors 5–63 retain dense 64-bit handlers. Larger factors use two groups of eight individually expressed marks per main iteration, an optional eight-mark cleanup and a scalar tail of at most seven marks. Runtime discovery, wrapping arithmetic and fresh class-owned storage remain.
- Latest development comparison: **0.039553 ms per pass**, **1.24% more throughput** than development control `7509c87` (0.040044 ms), saving **0.491 µs per sieve**. Every candidate trial beat every development trial; all nine runs validated correctly. The independent 128-bit candidate `307da10` measured 0.042365 ms, **5.48% less throughput** than development, and remains unmerged. Apple M4 Pro, Swift 6.3.3; Spotlight activity makes exact percentages provisional. Instruction counts do not isolate the causes.
- [Sixteen-write review](reports/SixteenWriteFusedReview.md), [128-bit review](reports/Dense128Review.md), [raw results](sparse-next-results-59262fe-307da10.json), and [verification evidence](sparse-next-verification.json) were originally published in `1bf1be7` on `swift/sparse-next-review` and are preserved here unchanged.
- Fastest tested candidate, **not merged**: `bd3858c`, [PR #14](https://github.com/fahlman/Primes/pull/14), ports the 128-bit handlers for every odd factor 65–127 onto the adopted sixteen-write implementation and removes provably redundant offset overflow checks with `word &* 16`. It measured **39.116 µs** versus adopted development `e3f5a41` at **40.432 µs**, **3.36% more throughput**, saving **1.316 µs**; every candidate trial beat every development trial. [Report](reports/Dense128WrappingOffsetReview.md), [raw results](dense-128-offset-results-bd3858c.json), [verification](dense-128-offset-verification.json). This comparison does not isolate wrapping's contribution.
- The fresh direct upstream comparison measured candidate `bd3858c` at **39.000 µs** versus the fastest upstream entry, striped UInt8 at `22bfea9`, at **207.191 µs**: **5.31x throughput**. Bool and packed UInt8 measured 290.055 and 349.419 µs. Same M4 Pro / Swift 6.3.3, common runner, three rotated five-second trials each; all 12 validated. Spotlight activity before compilation makes the precise ratios provisional. [Report](reports/CurrentUpstreamSwiftComparison.md), [raw results](upstream-current-bd3858c.json), [provenance](upstream-current-bd3858c-verification.json). These results measure the unmerged candidate, not the adopted development source; do not combine ratios across sessions.
- The [seven-mode phase breakdown](reports/FusedSparseBandBreakdown.md) copies earlier B (`8f108f5`), so it is now stale for profiling current production. Its full raw-buffer comparison remains a correctness reference. The historical B session measured copied full at 39.962 µs versus production 40.183 µs, with sparse factors accounting for approximately 67.5%. Those figures do not profile the sixteen-write loop.

## Experiments

| Experiment | Branch or record | Median ms per pass | Status |
|---|---|---:|---|
| Eight fixed-mask streams, four writes each | `swift/baseline` (`25402d4`) | 0.1198 | Superseded |
| Direct array access; cached square root | [EqualTermsSwiftComparison.md](reports/EqualTermsSwiftComparison.md) | no reliable gain | Rejected |
| Stream fusion | `swift/stream-fusion` (`f0cd82d`) | 0.1212 | Rejected |
| Dense byte marking for 3, 5, and 7 | `b45c0c1`; results in `5833376` | 0.0824 | Superseded by experiment 4 |
| 1: wrapping index arithmetic in the byte-stream loops | [PR #2](https://github.com/fahlman/Primes/pull/2), `de38d53` | 0.079761 | Included in experiment 4; individual PR superseded |
| 2: 64-bit dense marking for odd factors 9–13 | [PR #3](https://github.com/fahlman/Primes/pull/3), `7b63048` | 0.071580 | Included in experiment 4; individual PR superseded |
| 3: 64-bit words for the 5 and 7 handlers | [PR #1](https://github.com/fahlman/Primes/pull/1), `62e5a59` | 0.074382 | Included in experiment 4; individual PR superseded |
| 4A: combined word handlers for odd factors 5–13 | [PR #4](https://github.com/fahlman/Primes/pull/4), `f43c436` | 0.064351 | Intermediate step, superseded by 4B |
| 4B: combined word handlers plus wrapping arithmetic | [PR #4](https://github.com/fahlman/Primes/pull/4), `e8ba734` | 0.058781 | Adopted; extended by experiments 5–7 |
| 5: word handlers for odd factors 15–31 | [PR #5](https://github.com/fahlman/Primes/pull/5), `7ee6500`; [review](https://github.com/fahlman/Primes/blob/a334f451ed91e08fb74b3b7d08c7291ea58e2848/experiments/swift/reports/WordDense15Through31Review.md) | 0.049446 | Adopted in `98b21c6`; incorporated into experiment 7 |
| 6: word handlers for odd factors 33–47 | [PR #7](https://github.com/fahlman/Primes/pull/7), `404d1cb`; [review](https://github.com/fahlman/Primes/blob/9093317190d9e004db9685f742a976caf0693ebc/experiments/swift/reports/WordDense33Through47Review.md) | 0.046554 | Adopted in `8861ddb`; incorporated into experiment 7 |
| 7: word handlers for odd factors 49–63 | [PR #8](https://github.com/fahlman/Primes/pull/8), `19aa38a`; [review](https://github.com/fahlman/Primes/blob/ff6e8bf141ec6d8b91ec0eb0f3e8ce38848dad96/experiments/swift/reports/WordDense49Through63Review.md) | 0.042376 | Adopted in `5cd948e`; dense handlers retained in 8B |
| 8A: eight writes per sparse fixed-mask stream | [PR #11](https://github.com/fahlman/Primes/pull/11), `47b4af1` | 0.042549 | Not selected; 8B won the direct comparison |
| 8B: fused sparse streams above 63 | [PR #11](https://github.com/fahlman/Primes/pull/11), `8f108f5`; [review](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/reports/SparseStreamExperiment8Review.md) | 0.040806 | Adopted in `703dc12`; superseded by the sixteen-write loop |
| Sixteen-write fused sparse loop | [PR #12](https://github.com/fahlman/Primes/pull/12), `59262fe`; [review](reports/SixteenWriteFusedReview.md) | 0.039553 | Adopted in `83751ea`; current development |
| 128-bit handlers for odd factors 65–127 | [PR #13](https://github.com/fahlman/Primes/pull/13), `307da10`; [review](reports/Dense128Review.md) | 0.042365 | Original implementation regressed; preserved unmerged for the focused offset follow-up |
| 128-bit handlers with wrapping byte offsets on sixteen-write development | [PR #14](https://github.com/fahlman/Primes/pull/14), `bd3858c`; [review](reports/Dense128WrappingOffsetReview.md) | 0.039116 | Qualified; fastest tested candidate, not merged |

Measurements are from each experiment's recorded session; use the linked reports for comparisons made in the same session. Keep the branches and results of rejected or superseded experiments.

## Files

| File | Role |
|---|---|
| `PrimeSieve.swift` | The sieve class: one bit per odd candidate, bit 0 stands for 3, and a set bit means composite. |
| `Benchmark.swift` | The timed runner. |
| `BenchmarkObserver.swift` | An opaque one-byte read, compiled as a separate module so the optimizer can't remove sieve work. It computes no part of the sieve. |
| `Verify.swift` | Complete-array checks against an independent Boolean sieve. |
| `ExtraVerify.swift` | Complete-array checks at random limits and at every prime-square boundary up to 2,000,000. |
| `run.sh`, `Dockerfile` | Build and run with the benchmark flags. |
| `compare_optimizations.py` | Timing comparison of committed revisions, using the frozen runner and observer from commit `25402d4`. |
| `compare_all.py` | Timing comparison against the three upstream entries, downloaded at commit `22bfea9`. |
| `tools/phase-split/` | Seven-mode cumulative diagnostic copied from earlier `8f108f5`; stale for current timing, retained as a full-buffer correctness reference. |
| `reports/`, `*.json` | Recorded results. Don't overwrite them unintentionally. |

## Sieve rules

Read the Rules, Base algorithm, and Faithfulness sections of `CONTRIBUTING.md` at the repository root. The rules below add to it and are stricter where they differ.

- Discover factors at run time by checking odd candidates in order, starting at 3. Stopping at √limit, starting at p², and inverted flags are allowed. Word scans that jump to the next unmarked bit are out of scope unless agreed first.
- Mark every composite with its own operation in the source. Unrolling and reordering the marks are fine; the eight fixed-mask streams do both. The compiler may merge these operations in machine code. The classification rests on the source, so say so wherever it matters.
- Every pass creates a fresh sieve instance that owns the complete state and a buffer allocated at run time and sized to the limit. Nothing survives into the next pass. No external dependencies.
- The completed flags are the result. A count or checksum alone is not.
- Not allowed in this work: wheels, presieving, copied composite patterns, multi-bit composite masks written in source, mask or pattern tables, precomputed prime lists, buffers or state reused across passes, more than one thread, and marking a prime as composite and then restoring it.
- Specialized small-factor handlers: dispatch only after the runtime bit test finds the candidate unmarked. Provide a handler for every odd value in the handled range, not only primes, so no knowledge of primality is built in. Start at p², mark individually up to any alignment boundary, and finish with a bounded tail.
- Output tags must match the code: `algorithm=base,faithful=yes,bits=1` and a thread count of 1. READMEs and reports must describe what the code does.
- Implement the sieve and the timed benchmark in Swift. Python may only build and launch executables.
- When borrowing an idea from another submission, read its code. Its labels are not proof that it complies.

## Benchmark contract

- Every pass times allocation, initialization, sieving, the opaque observation, and release. Compilation, validation, prime enumeration, building output arrays, and printing are not timed.
- Keep the observer a separately compiled module that the benchmark can't inline, built as in `run.sh`. Never change the workload or weaken this protection to improve a timing.
- Limit 1,000,000, at least 5 seconds per run, 78,498 primes expected.
- Build the benchmark with `-O -whole-module-optimization` and the observer as in `run.sh`. Compared variants use identical flags and the same runner.
- Timing evidence comes only from the reference machine (Apple M4 Pro, Swift 6.3.3): serial runs in rotated order, with nothing else building, testing, benchmarking, or playing media. Timings from any other machine, a Linux container, or Codex cloud are not evidence of a speedup; use those environments for correctness only.
- Compare committed revisions with `compare_optimizations.py`. Include the current development branch as a development control in the same run, and pass `--output` so the recorded `optimization-results.json` isn't overwritten.
- Use `compare_all.py` for comparisons against the upstream entries and identify the fastest upstream median as the project baseline. It overwrites `all-swift-results.json`: copy that file first, preserve the new run under a unique name, and restore the earlier record. Record the exact candidate revision, upstream revision, source and adapter hashes, hardware, Swift version, and run order with the results; acquire the timing lock before this script starts compiling.

## Timing sessions

- One agent runs timing at a time. Before starting, it creates `/tmp/primes-timing.lock` containing a one-line description of the run, and it deletes the file when done.
- Before any build, test, or benchmark, check for that file, and wait while it exists.

## Branches, pull requests, and reviews

- One experiment per branch, named `swift/<experiment>` and created from the current development branch (`swift/dense-small-factors`). Work in that branch's own git worktree, and don't edit another agent's worktree.
- Open one pull request per experiment in `fahlman/Primes`, targeting the current development branch in that fork. Verify both the head and base repositories; GitHub may suggest the upstream repository by default. Use a draft while implementation or required checks are incomplete.
- The PR is the shared record for implementation, review, timing, and the final decision. Its description explains what changed, why it remains `base,faithful=yes,bits=1`, the exact candidate commit, and which verification checks passed or remain pending. Keep it current as the candidate changes.
- Hand off with the PR link and exact commit, for example `Claude implemented <commit>; PR: <url>; report: <path>` or `Codex reviewed <commit>; PR: <url>; report: <path>`. Chat handoffs supplement the PR record.
- The other agent reviews that exact candidate commit before any timing and posts its findings on the PR, explicitly identifying itself as Codex or Claude. An agent's review comment is sufficient when both agents use the same GitHub account. Changes to the sieve or benchmark after review require review of the changed code before further timing.
- Post benchmark results on the same PR, following the benchmark contract and timing lock above. Identify both measured commits, hardware, Swift version, build flags, run order, validation results, and any conditions that limit the conclusion. Distinguish measured improvement from hypotheses.
- Commit reports and raw result files without overwriting earlier runs, publish them to the fork, and link the exact files and commits from the PR. A reviewer may publish a separate report branch from its own worktree; the evidence must not exist only on a local branch or in chat.
- Record whether the experiment is pending, adopted, or rejected on the PR. When it is adopted or rejected, also update Current best and Experiments in this file. Preserve rejected branches and results. Publishing a PR or a review does not itself adopt the experiment; integration stays within the user's authorized scope.
- Use issues in `fahlman/Primes` for agreed objectives, future experiments, and unresolved work when issues are enabled, and link related PRs. An issue is optional for an individual experiment. While issues are disabled, use the PR and the Experiments table; enabling issues is a separate repository-setting change.
- Keep this file focused on shared rules and the concise project status. Put detailed findings, measurements, and discussion in PRs and committed reports.
- The inherited all-language `CI` workflow does not test `experiments/swift`. Documentation/evidence-only commits may use GitHub's `[skip ci]` marker to avoid launching that unrelated matrix; [GitHub documents its push/PR behavior and pending-check limitation](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/skip-workflow-runs). This does not replace required source verification, independent review, or the dedicated exact-revision Linux validation. Do not use it to bypass a required check.
- Don't discard existing changes or rewrite history on pushed branches. Push only to `origin` (fahlman/Primes), and keep pull requests inside the fork.
- An upstream submission gets a fresh branch from `upstream/drag-race` containing only the solution folder. Before opening it, `git diff --stat upstream/drag-race...HEAD` must list nothing else.
- Native Linux/Docker correctness and runtime compatibility are validated for exact candidate `bd3858c` in PR #14, which remains unmerged. All six checks passed on arm64; amd64 coverage combines five checks from the original job and the final PhaseVerify WMO check from a focused follow-up after the original 45-minute timeout. Preserve that cancelled run and scope claims to the tested revision. The [Linux validation report](https://github.com/fahlman/Primes/blob/e5b94328376efaea77f9faab3979c181ea3fe234/experiments/swift/reports/LinuxDockerValidation.md) records source/image identities, substantial compile costs, full coverage and independent audits. No local Docker execution or native Threadripper performance measurement is included.

## Done checklist for a candidate

Run these from `experiments/swift`. A candidate is ready for timing only when all of them pass.

1. Correctness, with AddressSanitizer and with the benchmark's optimization flags:

   ```sh
   mkdir -p .build
   swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify-asan && .build/verify-asan
   swiftc -O -whole-module-optimization PrimeSieve.swift Verify.swift -o .build/verify && .build/verify
   swiftc -O -sanitize=address PrimeSieve.swift ExtraVerify.swift -o .build/extra-verify-asan && .build/extra-verify-asan
   ```

2. If the change depends on particular machine code, such as removed overflow checks or merged or vectorized stores, inspect the assembly:

   ```sh
   swiftc -O -parse-as-library -module-name BenchmarkObserver \
     -emit-module -emit-module-path .build/BenchmarkObserver.swiftmodule \
     -emit-object BenchmarkObserver.swift -o .build/BenchmarkObserver.o
   swiftc -O -whole-module-optimization -I .build PrimeSieve.swift Benchmark.swift -S -o .build/PrimeSwift.s
   ```

   The call to `observe` must still be a real call (`bl` on arm64), not inlined.

3. The change is committed on its own branch, its fork PR is open, and the other agent's review of the exact candidate commit is recorded there with no unresolved blocking findings.
4. Any write-up separates measured results from hypotheses, and claims a speedup only from the timing protocol above.
