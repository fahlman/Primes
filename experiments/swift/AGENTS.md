# Swift sieve experiments: instructions for coding agents

These instructions apply to everything in `experiments/swift`. Current implementation, commands and accepted results belong in [README.md](README.md); each pull request owns its change history and decision. This file and `CLAUDE.md` belong to the fahlman/Primes fork only. Never include them, or anything else under `experiments/`, in a pull request to PlummersSoftwareLLC/Primes.

## Goal

Beat the three upstream Swift entries in `PrimeSwift/solution_1` (`PrimeSwift_8bitBool`, `PrimeSwift_1bit_u8`, `PrimeSwift_1bitStriped_u8`) on equal terms, in one category: `algorithm=base,faithful=yes,bits=1`, one thread, limit 1,000,000. Wheel, cached-state, and multithreaded variants are deferred.

## Baseline and development controls

The project baseline is currently `PrimeSwift_1bitStriped_u8` at upstream `22bfea9`, as established in [the direct comparison](https://github.com/fahlman/Primes/pull/6#issuecomment-5653991169). In general, it is the fastest of the three upstream Swift implementations, measured with the same runner, compiler flags, machine, and timing session as our candidate. Pin the upstream commit and identify the winning entry in each comparison PR. The Bool entry uses `bits=8`; retain that label when comparing it with the three `bits=1` implementations.

Our earlier versions are development controls: they measure the contribution of an optimization. The original verified implementation at commit `25402d4` and `0d0a142` are development controls, not the upstream baseline. Preserve their historical results. Report gains over the upstream baseline separately from gains over a development control.

## Sieve rules

Read the Rules, Base algorithm, and Faithfulness sections of `CONTRIBUTING.md` at the repository root. The rules below add to it and are stricter where they differ.

- Discover factors at run time by checking odd candidates in order, starting at 3. Stopping at √limit, starting at p², and inverted flags are allowed. Word scans that jump to the next unmarked bit are out of scope unless agreed first.
- Mark every composite with its own operation in the source. Unrolling and reordering the marks are fine; the eight fixed-mask streams do both. The compiler may merge these operations in machine code. The classification rests on the source, so say so wherever it matters.
- Every pass creates a fresh sieve instance that owns the complete state and a buffer allocated at run time and sized to the limit. Nothing survives into the next pass. No external dependencies.
- The completed flags are the result. A count or checksum alone is not.
- Not allowed in this work: wheels, presieving, copied composite patterns, multi-bit composite masks written in source, mask or pattern tables, precomputed prime lists, buffers or state reused across passes, more than one thread, and marking a prime as composite and then restoring it.
- Specialized small-factor handlers: dispatch only after the runtime bit test finds the candidate unmarked. Provide a handler for every odd value in the handled range, not only primes, so no knowledge of primality is built in. Start at p², mark individually up to any alignment boundary, and finish with a bounded tail.
- Output tags must match the code: `algorithm=base,faithful=yes,bits=1` and a thread count of 1. READMEs and PR records must describe what the code does.
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

## Work scope and branches

- State the intended change, acceptance criteria and directly relevant verification before starting. Use the agreed benchmark admission rule for timing work. Stop after the required checks and final decision; additional experiments or retiming need the user's direction.
- Use one `swift/<experiment>` branch per experiment, based on `swift/dense-small-factors`, with one PR in `fahlman/Primes`. Verify the head and base repositories. Keep the PR a draft while required work is incomplete.
- Use a separate worktree for concurrent work or when an isolated exact-revision checkout is needed. Sequential work may use the main checkout after preserving local changes. Put temporary worktrees under `/Users/ryan/Developer/Primes/.worktrees/`, create them from the main repository, and confirm the sparse checkout includes `PrimeSwift`, `experiments` and `.github`; if necessary, run `git sparse-checkout set PrimeSwift experiments .github` in the new worktree. Do not edit another agent's worktree.
- Once a branch is merged or its PR is closed, publish any unique source/evidence and remove its worktree and disposable builds. Keep the branch. Generated caches need no backup; preserve any unique uncommitted work before removal.
- Don't discard existing changes, rewrite pushed history, or push to upstream. Push to `origin` only. An upstream submission requires a fresh branch from `upstream/drag-race` containing only the solution folder; verify that with `git diff --stat upstream/drag-race...HEAD` before opening it. Submission remains paused until the user resumes it.

## Pull requests and reviews

- The PR description must be sufficient to understand the current decision: purpose and resulting behavior; exact candidate and control revisions; why the classification still applies; checks completed, skipped or pending; measured results and limitations when applicable; review status; and adopted, rejected or superseded disposition with the integration/replacement link. Scale detail to the change; a small maintenance PR need not fill every field.
- Keep the description's summary current when the candidate changes or later evidence arrives. Preserve original review comments and raw records. Attribute later checks to their reviewer and exact revision; do not rewrite an earlier session as if it ran those checks. A closed PR may have been superseded by adopted combined work rather than rejected.
- The other agent reviews the exact candidate before timing, identifies itself as Codex or Claude, and posts findings on the PR. Same-account review comments are sufficient. Changes to sieve or benchmark code after review require review of those changes before more timing.
- Post timing tables directly on the PR: actual trial results, units, candidate/control revisions, machine/compiler/flags, admission outcome and material conditions. Distinguish tooling-validation runs from accepted performance evidence. Link the durable raw record so readers can inspect details without needing it to understand the conclusion.
- Put detailed explanations, reviews, comparisons and decisions directly in the relevant PR, using linked comments for longer supporting records and keeping the description current. Do not add Markdown reports to development. The README holds current usage and accepted results; this file holds stable working rules. Link to PRs instead of maintaining duplicate narratives or experiment-status tables.
- Hand off with the PR link and exact commit. For agreed objectives spanning several PRs, use a fork issue if issues are enabled; otherwise use the relevant PR. Enabling issues is a separate repository-setting change.

## Evidence and retention

- Keep one canonical machine-readable record per independent run, using the existing tool's output format. Record run purpose, exact source/control identities, hardware/compiler/flags, commands and exit statuses, trial order and raw measurements when timed, and relevant conditions or incomplete work. Preserve failed and stopped runs separately; never pool a repeat into an earlier session or overwrite original measurements.
- Group each run's record and optional supporting files by PR, source revision and run name on a published evidence, review or archive branch. Publish and verify the commit before deleting local copies, and link its full commit from the PR. Raw records stay outside development integration; no extra checkout is required just to retain them. Existing records remain in the [historical snapshot](https://github.com/fahlman/Primes/tree/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift).
- Historical report files remain in published Git history. Link them for provenance and keep current explanations in the PRs.
- Include logs, assembly and artifact hashes when they support verification, explain a failure, or establish a code-generation claim. Record empty command output in the canonical record instead of creating separate empty files. Avoid retaining both a ZIP and an identical extracted copy. An expiring CI download is temporary transport, not the only permanent copy.
- Keep decision-bearing failures visible in the PR. Incidental wrapper failures can remain in the linked run record unless they limit confidence in the reported result. Preserve the original evidence in either case.
- Documentation and evidence-organization changes need focused checks of links, file identities and preservation; they do not trigger a sieve benchmark or full correctness suite. Tool changes need checks of the affected behavior. Sieve/benchmark candidates retain the full requirements below, including assembly identity or measured admission where applicable.
- The inherited all-language `CI` is disabled in the fork's Actions settings; its Swift Linux/Docker workflow remains active. `[skip ci]` is unnecessary for documentation commits and must never bypass a required check.

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
