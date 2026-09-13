# Swift sieve experiments: instructions for coding agents

These instructions apply to everything in `experiments/swift`, and this file doubles as the project brief. It and `CLAUDE.md` belong to the fahlman/Primes fork only. Never include them, or anything else under `experiments/`, in a pull request to PlummersSoftwareLLC/Primes.

## Goal

Beat the three upstream Swift entries in `PrimeSwift/solution_1` (`PrimeSwift_8bitBool`, `PrimeSwift_1bit_u8`, `PrimeSwift_1bitStriped_u8`) on equal terms, in one category: `algorithm=base,faithful=yes,bits=1`, one thread, limit 1,000,000. Wheel, cached-state, and multithreaded variants are deferred.

## Baseline and development controls

The project baseline is currently `PrimeSwift_1bitStriped_u8` at upstream `22bfea9`, as established in [the direct comparison](reports/UpstreamBaselineComparison.md). In general, it is the fastest of the three upstream Swift implementations, measured with the same runner, compiler flags, machine, and timing session as our candidate. Pin the upstream commit and identify the winning entry in each report. The Bool entry uses `bits=8`; retain that label when comparing it with the three `bits=1` implementations.

Our earlier versions are development controls: they measure the contribution of an optimization. The historical `swift/baseline` branch (`25402d4`) and `0d0a142` are development controls, not the upstream baseline. Preserve those branches and historical results. Report gains over the upstream baseline separately from gains over a development control.

## Current best
- Adopted source: cutoff 111, historical measured sieve `099e35a` ([PR #16](https://github.com/fahlman/Primes/pull/16), merge `380a942`). Everything since is maintenance with benchmark assembly byte-identical to `84d8a4f`: the unified generator (#21), current-source phase tooling (#24), the authoring template and generator checks (#26), and shared storage sizing (#27). The development head renders that sieve from `tools/PrimeSieve.swift.in`.
- Design: one bit per odd candidate, `algorithm=base,faithful=yes,bits=1`, one thread. Factor 3 uses dense byte marking, odd factors 5–63 dense 64-bit handlers, 65–111 dense 128-bit handlers, and factors above 111 the sixteen-write fused sparse loop with an eight-mark cleanup and a scalar tail. Every odd value in a handled range has a case, prime or not.
- Latest development comparison: cutoff 111 `099e35a` at **38.434 µs** against development `f6b5c5b` at 39.843 µs (+3.667%) and against cutoff 127 `bd3858c` at 38.642 µs (+0.540%, every trial faster). [Report](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md).
- Latest direct upstream comparison, measured at cutoff 127 `bd3858c`: **39.000 µs** against upstream striped UInt8 (`22bfea9`) at 207.191 µs, **5.31x**; Bool 290.055 µs, packed UInt8 349.419 µs. Not yet remeasured at cutoff 111; never combine ratios across sessions. [Report](reports/CurrentUpstreamSwiftComparison.md).
- Linux: exact `099e35a` passed all six checks and the runtime smoke on native amd64 and arm64 through the fork's workflow ([PR #15](https://github.com/fahlman/Primes/pull/15), merge `f639c15`). [Report](reports/Cutoff111LinuxValidation.md), [container cleanup](reports/LinuxContainerCleanup.md). Correctness and compatibility only; no Linux or x86 timing exists.
- Tested and rejected, branches and evidence preserved: 32 sparse writes (#17), the square-root discovery bound (#18, at 127 and again at 111), atomic marks (#19), compact case-literal loops (#20), inline marking helpers (#22), one unified 128-bit handler (#23), and a runtime 128-bit recurrence (#25). Every measured simplification of the marking code lost; the byte / 64-bit / 128-bit split is forced by the compiler's unroll limits, not taste.
- Submission: prepared on `swift/submission-review-base` (merge `35becbe`, package `b826fc6`), replacing the striped entry in `PrimeSwift/solution_1` with the adopted sieve, its template and tools; the sieve bytes equal development's. Paused by the user. Before it opens upstream: decide the result label, which is still `yellowcub_striped_UInt8`; run a direct upstream comparison at cutoff 111; validate the package itself on native Linux.
- Profiling: `tools/phase-split/` derives its diagnostic from the current source; the historical `8f108f5` copy remains only as a full-buffer correctness reference. The last breakdown, of B (`8f108f5`), put about 67.5% of a pass in the sparse loop and does not profile cutoff 111.

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
| Sixteen-write fused sparse loop | [PR #12](https://github.com/fahlman/Primes/pull/12), `59262fe`; [review](reports/SixteenWriteFusedReview.md) | 0.039553 | Adopted in `83751ea`; sparse kernel retained in cutoff 111 |
| 128-bit handlers for odd factors 65–127 | [PR #13](https://github.com/fahlman/Primes/pull/13), `307da10`; [review](reports/Dense128Review.md) | 0.042365 | Closed as tested/rejected and superseded by PR #14/#16; unmerged, branch and evidence preserved |
| 128-bit handlers with wrapping byte offsets on sixteen-write development | [PR #14](https://github.com/fahlman/Primes/pull/14), `bd3858c`; [review](reports/Dense128WrappingOffsetReview.md) | 0.039116 | Marking and wrapping incorporated through PR #16; cutoff 127 superseded |
| 128-bit cutoff sweep: 79 / 95 / 111 | [PR #16](https://github.com/fahlman/Primes/pull/16), `7f26170` / `2dc1d42` / `099e35a`; [review](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md) | 0.038919 / 0.038670 / 0.038434 | 111 adopted through PR #16; 79 and 95 not selected |
| Thirty-two sparse writes | [PR #17](https://github.com/fahlman/Primes/pull/17), `af83aa1`; [review](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md) | 0.041983 | Slower; does not qualify; closed as tested and rejected; unmerged |
| Square-root discovery bound at cutoff 127 | [PR #18](https://github.com/fahlman/Primes/pull/18), `76d82c2`; [review](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md) | 0.039155 | Flat; does not qualify; closed as tested and rejected; unmerged |
| Atomic sparse marks | [PR #19](https://github.com/fahlman/Primes/pull/19), `e889cd6`; [review](https://github.com/fahlman/Primes/blob/9867dce8a60985272c85baa8596433b9719e243c/experiments/swift/reports/FollowupFourExperimentReview.md) | 0.098332 | Slower; does not qualify; closed as tested and rejected; unmerged |
| Square-root discovery bound at adopted cutoff 111 | [PR #18](https://github.com/fahlman/Primes/pull/18), `968c249`; [review](https://github.com/fahlman/Primes/blob/31222e494667049240bb2fa3131d6af3acdd3f63/experiments/swift/reports/DiscoveryBound111Review.md) | 0.039115 | Flat; trial ranges overlap; closed as tested and rejected; unmerged |
| Native Linux/Docker validation and container cleanup | [PR #15](https://github.com/fahlman/Primes/pull/15), fix `f6256fd`; [review](reports/LinuxContainerCleanup.md) | Not timed (infrastructure) | Adopted via merge `f639c15`; both native full suites and cleanup probes passed |
| Compact dense case-literal loops | [PR #20](https://github.com/fahlman/Primes/pull/20), `1a259a8`; [review](https://github.com/fahlman/Primes/blob/1972c27a09ed12f519bffc21be6a6ef78adb2ae8/experiments/swift/reports/CompactDenseLoops.md) | 0.362478 | Rejected versus adopted 111 at 0.038298; closed unmerged; branch preserved |
| Unified dense-switch generator | [PR #21](https://github.com/fahlman/Primes/pull/21), `9c5d7e5`; [review](reports/DenseGeneratorReview.md) | Not timed | Adopted via PR #21 (`7be57ca`); label-only cleanup `26c88ef`; complete benchmark assembly remains unchanged |
| Current-source phase tooling | [PR #24](https://github.com/fahlman/Primes/pull/24), `0c605a4`; [review](reports/CurrentPhaseTools.md) | Not timed (maintenance) | Adopted via PR #24 (`2ee7b3a`); fresh merged-source short check passed |
| Checked authoring template and reusable generator checks | [PR #26](https://github.com/fahlman/Primes/pull/26), `1f9e11e`; [review](reports/AuthoringTemplateReview.md) | Not timed | Adopted via `0d64a47`; initial runtime source byte-identical; 98 generator checks passed |
| Shared storage layout | [PR #27](https://github.com/fahlman/Primes/pull/27), `5cbc25e`; [review](reports/StorageLayoutReview.md) | Not timed | Adopted via `b33b2fc`; complete benchmark assembly byte-identical; correctness and template integration passed |
| Prepared package duration and result refactors | [PR #28](https://github.com/fahlman/Primes/pull/28), `b826fc6`; [review](https://github.com/fahlman/Primes/blob/3fb586b/experiments/swift/reports/SubmissionCLIRefactor.md) | Not timed | Adopted via `35becbe` into the fork package branch; local release/ASan checks passed; upstream paused |

Measurements are from each experiment's recorded session; use the linked reports for comparisons made in the same session. Keep the branches and results of rejected or superseded experiments.

## Files

| File | Role |
|---|---|
| `PrimeSieve.swift` | Committed, directly compiled rendering of the sieve: one bit per odd candidate, bit 0 stands for 3, and a set bit means composite. Edit its template, then regenerate. |
| `tools/PrimeSieve.swift.in` | Handwritten source with two switch insertion lines and dispatch-bound tokens. This is the authoring source for changes outside generated cases. |
| `tools/generate-dense.swift` | Canonical whole-file renderer with both marked explicit switches: every odd factor 5–63 at 64 bits and 65–111 at 128 bits. Dispatch bounds come from that metadata. Use `--check PrimeSieve.swift` or `--write PrimeSieve.swift` under the lock; write replaces the complete file. The old `generate-dense-128.swift` filename forwards to it. |
| `tools/check-dense-generator.swift` | Reusable generator and compatibility-entry checks with independent marking schedules and disposable failure fixtures. Run under the same lock. |
| `Benchmark.swift` | The timed runner. |
| `BenchmarkObserver.swift` | An opaque one-byte read, compiled as a separate module so the optimizer can't remove sieve work. It computes no part of the sieve. |
| `Verify.swift` | Complete-array checks against an independent Boolean sieve. |
| `ExtraVerify.swift` | Complete-array checks at random limits and at every prime-square boundary up to 2,000,000. |
| `run.sh`, `Dockerfile` | Build and run with the benchmark flags. |
| `tools/compare-revisions.swift` | Timing comparison of committed revisions, all built with the frozen runner and observer from commit `25402d4`. `--output` is required and never overwrites. |
| `tools/compare-upstream.swift` | Timing comparison of a committed candidate against the three upstream entries, downloaded at commit `22bfea9` and built with the same frozen runner and observer. `--output` is required and never overwrites. |
| `tools/phase-split/` | Generates current phase inputs with source-identity guards; preserves the independent `8f108f5` full-buffer correctness reference. See its README before building or running. |
| `tools/linux-docker/` | `linux-validation.swift`: the native Linux/Docker validator (`validate`) and its lifecycle tests and Docker probe (`test-lifecycle`), driven by the fork's `swift-linux-docker-validation.yml` workflow on the runner host. |
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
- Implement the sieve, the benchmark and the project's tools in Swift, with POSIX `sh` only for thin wrappers such as `run.sh`. No sieve or benchmark logic lives outside Swift, and no other language is needed anywhere in the fork.
- When borrowing an idea from another submission, read its code. Its labels are not proof that it complies.

## Benchmark contract

- Every pass times allocation, initialization, sieving, the opaque observation, and release. Compilation, validation, prime enumeration, building output arrays, and printing are not timed.
- Keep the observer a separately compiled module that the benchmark can't inline, built as in `run.sh`. Never change the workload or weaken this protection to improve a timing.
- Limit 1,000,000, at least 5 seconds per run, 78,498 primes expected.
- Build the benchmark with `-O -whole-module-optimization` and the observer as in `run.sh`. Compared variants use identical flags and the same runner.
- Timing evidence comes only from the reference machine (Apple M4 Pro, Swift 6.3.3): serial runs in rotated order, with nothing else building, testing, benchmarking, or playing media. Timings from any other machine, a Linux container, or Codex cloud are not evidence of a speedup; use those environments for correctness only.
- Compare committed revisions with `swift tools/compare-revisions.swift`. Include the current development branch as a development control in the same run. `--output` is required and never overwrites, so every session leaves its own record.
- Use `swift tools/compare-upstream.swift` for comparisons against the upstream entries and identify the fastest upstream median as the project baseline. It builds the upstream adapters and the candidate with the frozen `25402d4` runner and observer, and records the candidate revision, the upstream revision, source and adapter hashes, hardware, Swift version and run order itself. `--output` is required and never overwrites. Hold the timing lock before it starts compiling.
- Admission rule for a speed change: three rotated five-second trials per variant in one session, and the candidate qualifies only if every candidate trial beats every control trial. Overlapping ranges are flat, not a gain. Don't repeat a flat or losing session to look for a win; a repeat happens only at the user's request and is reported separately, never pooled. A refactor of timed code is accepted on byte-identical benchmark assembly against the control, built with the same observer, flags and module name; if the assembly changes, it needs the same timing admission as a speed change, and a flat result does not show it is harmless.

## Timing sessions
- Hold `/tmp/primes-timing.lock` for any compile, test or benchmark you run, not only timing sessions: create it with a one-line description of the work before starting, and delete it when done. Only its creator removes it. Before starting, check for the file and wait while it exists. This keeps a timing session from ever overlapping another agent's build.

## Branches, pull requests, and reviews

- One experiment per branch, named `swift/<experiment>` and created from the current development branch (`swift/dense-small-factors`). Work in that branch's own git worktree, and don't edit another agent's worktree. Create worktrees from the main checkout (`git -C /Users/ryan/Developer/Primes worktree add ...`), which is a sparse checkout of `PrimeSwift`, `experiments` and `.github`; new worktrees inherit that, and one that comes out with all 110 language folders needs `git sparse-checkout set PrimeSwift experiments .github` run inside it. Remove a worktree once its branch is merged or its PR is closed; the branch stays.
- Open one pull request per experiment in `fahlman/Primes`, targeting the current development branch in that fork. Verify both the head and base repositories; GitHub may suggest the upstream repository by default. Use a draft while implementation or required checks are incomplete.
- The PR is the shared record for implementation, review, timing, and the final decision. Its description explains what changed, why it remains `base,faithful=yes,bits=1`, the exact candidate commit, and which verification checks passed or remain pending. Keep it current as the candidate changes.
- Hand off with the PR link and exact commit, for example `Claude implemented <commit>; PR: <url>; report: <path>` or `Codex reviewed <commit>; PR: <url>; report: <path>`. Chat handoffs supplement the PR record.
- The other agent reviews that exact candidate commit before any timing and posts its findings on the PR, explicitly identifying itself as Codex or Claude. An agent's review comment is sufficient when both agents use the same GitHub account. Changes to the sieve or benchmark after review require review of the changed code before further timing.
- Post benchmark results on the same PR, following the benchmark contract and timing lock above. Identify both measured commits, hardware, Swift version, build flags, run order, validation results, and any conditions that limit the conclusion. Distinguish measured improvement from hypotheses.
- Commit reports and raw result files without overwriting earlier runs, publish them to the fork, and link the exact files and commits from the PR. A reviewer may publish a separate report branch from its own worktree; the evidence must not exist only on a local branch or in chat.
- Record whether the experiment is pending, adopted, or rejected on the PR. When it is adopted or rejected, also update Current best and Experiments in this file. Preserve rejected branches and results. Publishing a PR or a review does not itself adopt the experiment; integration stays within the user's authorized scope.
- Use issues in `fahlman/Primes` for agreed objectives, future experiments, and unresolved work when issues are enabled, and link related PRs. An issue is optional for an individual experiment. While issues are disabled, use the PR and the Experiments table; enabling issues is a separate repository-setting change.
- Keep this file focused on shared rules and the concise project status. Put detailed findings, measurements, and discussion in PRs and committed reports.
- The inherited all-language `CI` workflow is disabled in the fork's Actions settings; the fork's own `swift-linux-docker-validation.yml` stays active. `[skip ci]` on documentation commits is no longer needed. Never use a marker to bypass a required check.
- Don't discard existing changes or rewrite history on pushed branches. Push only to `origin` (fahlman/Primes), and keep pull requests inside the fork.
- An upstream submission gets a fresh branch from `upstream/drag-race` containing only the solution folder. Before opening it, `git diff --stat upstream/drag-race...HEAD` must list nothing else.

## Done checklist for a candidate

Run these from `experiments/swift`, holding the timing lock. A candidate is ready for timing only when all of them pass.

1. The committed sieve is exactly its template rendering. Edit `tools/PrimeSieve.swift.in`, never `PrimeSieve.swift` directly; `--write` re-renders the whole file. When the template, generator or checker changed, run the generator's own checks too:

   ```sh
   swift tools/generate-dense.swift --check PrimeSieve.swift
   swift tools/check-dense-generator.swift
   ```

2. Correctness, with AddressSanitizer and with the benchmark's optimization flags. `PhaseVerify` compares complete buffers, padding included, with the historical `8f108f5` copy:

   ```sh
   mkdir -p .build
   swiftc -O -sanitize=address PrimeSieve.swift Verify.swift -o .build/verify-asan && .build/verify-asan
   swiftc -O -whole-module-optimization PrimeSieve.swift Verify.swift -o .build/verify && .build/verify
   swiftc -O -sanitize=address PrimeSieve.swift ExtraVerify.swift -o .build/extra-verify-asan && .build/extra-verify-asan
   swiftc -O -whole-module-optimization PrimeSieve.swift ExtraVerify.swift -o .build/extra-verify && .build/extra-verify
   swiftc -O -sanitize=address PrimeSieve.swift tools/phase-split/PhaseSieve.swift tools/phase-split/PhaseVerify.swift -o .build/phase-verify-asan && .build/phase-verify-asan
   swiftc -O -whole-module-optimization PrimeSieve.swift tools/phase-split/PhaseSieve.swift tools/phase-split/PhaseVerify.swift -o .build/phase-verify && .build/phase-verify
   ```

3. Inspect the assembly when the change depends on particular machine code, such as removed overflow checks or merged or vectorized stores, and always for a refactor that must not change the timed code, whose complete `.s` must equal the control's byte for byte:

   ```sh
   swiftc -O -parse-as-library -module-name BenchmarkObserver \
     -emit-module -emit-module-path .build/BenchmarkObserver.swiftmodule \
     -emit-object BenchmarkObserver.swift -o .build/BenchmarkObserver.o
   swiftc -O -whole-module-optimization -module-name PrimeSwift -I .build PrimeSieve.swift Benchmark.swift -S -o .build/PrimeSwift.s
   ```

   The call to `observe` must still be a real call (`bl` on arm64), not inlined.

4. The change is committed on its own branch, its fork PR is open, and the other agent's review of the exact candidate commit is recorded there with no unresolved blocking findings.
5. Any write-up separates measured results from hypotheses, and claims a speedup only from the timing protocol above.
