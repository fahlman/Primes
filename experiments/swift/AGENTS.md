# Swift sieve experiments: instructions for coding agents

These instructions apply to everything in `experiments/swift`, and this file doubles as the project brief. It and `CLAUDE.md` belong to the fahlman/Primes fork only. Never include them, or anything else under `experiments/`, in a pull request to PlummersSoftwareLLC/Primes.

## Goal

Beat the three upstream Swift entries in `PrimeSwift/solution_1` (`PrimeSwift_8bitBool`, `PrimeSwift_1bit_u8`, `PrimeSwift_1bitStriped_u8`) on equal terms, in one category: `algorithm=base,faithful=yes,bits=1`, one thread, limit 1,000,000. Wheel, cached-state, and multithreaded variants are deferred.

## Current best

- `swift/dense-small-factors`: sieve source from commit `b45c0c1`, results recorded in `5833376`.
- One bit per odd candidate. Runtime-discovered factors 3, 5, and 7 use dense byte marking; larger factors use eight fixed-mask streams with four writes per iteration.
- 0.0824 ms per pass, the median of three rotated five-second trials on the reference machine: 1.45× the saved baseline. Not yet timed against the upstream entries in the same session.
- Latest review: [reports/IndependentReview.md](reports/IndependentReview.md), of commit `5833376`.

## Experiments

| Experiment | Branch or record | Median ms per pass | Status |
|---|---|---:|---|
| Eight fixed-mask streams, four writes each | `swift/baseline` (`25402d4`) | 0.1198 | Superseded |
| Direct array access; cached square root | [EqualTermsSwiftComparison.md](reports/EqualTermsSwiftComparison.md) | no reliable gain | Rejected |
| Stream fusion | `swift/stream-fusion` (`f0cd82d`) | 0.1212 | Rejected |
| Dense byte marking for 3, 5, and 7 | `swift/dense-small-factors` (`b45c0c1`) | 0.0824 | Current best |
| Wrapping index arithmetic in the byte-stream loops | — | — | Proposed (review item 1) |
| 64-bit dense marking for odd factors 9–31, starting with 9–13 | — | — | Proposed (review item 2) |
| 64-bit words for the 5 and 7 handlers | — | — | Proposed (review item 3) |

Keep the branches and results of rejected experiments.

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
| `tools/phase-split/` | Times each stage of a pass. It copies the sieve code as of `5833376`; see its header. |
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
- Compare committed revisions with `compare_optimizations.py`. Always include the current development branch in the same run, and pass `--output` so the recorded `optimization-results.json` isn't overwritten.
- `compare_all.py` overwrites `all-swift-results.json`. Copy that file first.

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
- Don't discard existing changes or rewrite history on pushed branches. Push only to `origin` (fahlman/Primes), and keep pull requests inside the fork.
- An upstream submission gets a fresh branch from `upstream/drag-race` containing only the solution folder. Before opening it, `git diff --stat upstream/drag-race...HEAD` must list nothing else.
- Docker and Linux execution are untested. Don't claim they work until they've run.

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
