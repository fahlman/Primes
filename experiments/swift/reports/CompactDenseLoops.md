# Compact dense-loop experiment

Status: **tested and rejected; unmerged**. Exact candidate `1a259a84a892cc1008de179ef332d66bd1c514bf` passed source review, all correctness checks and assembly admission, but lost the single registered timing comparison. Preserve the branch and evidence. Submission remains paused.

Control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599`, whose sieve is the adopted cutoff-111 source `099e35a`.

The candidate replaces each generated group of per-chunk calls with a case-literal `for j` loop. The offset remains `(p - (width * j) % p) % p`, with literal width and factor. All 54 odd-factor cases remain: 5–63 on 64-bit words and 65–111 on 128-bit chunks. Allocation, runtime factor discovery, p² starts, helpers, alignment, padding endpoints, sparse marking, runner and observer are unchanged. Source still marks each multiple with its own single-bit OR; classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

The source falls from 3,679 to 709 lines. This is a source-size result, not a machine-code or throughput claim.

## Bounded evaluation

1. Compile the control and candidate with the frozen benchmark context and inspect all changed functions and the complete timed path, including the real observer call. Record residual chunk loops, remainder arithmetic, shifts, outlining and spills rather than predicting speed from instruction counts.
2. Run the existing generator check and Verify/ExtraVerify/PhaseVerify under ASan and WMO. Raw-buffer equality must include padding. Commit and publish independent exact-revision review before timing.
3. Run one `compare_optimizations.py` session with the current control and candidate, three rotated five-second trials each, under `/tmp/primes-timing.lock` and with unique `--output`. Do not repeat a flat or losing result to seek a win. This is a refactor: identical compiled timed paths need no new timing; changed paths require measured evidence, and overlapping trial ranges alone cannot establish equivalence.
4. If the compact form survives the local screen, inspect the actual submission SwiftPM build and native Linux arm64/amd64 builds with the same harness and explicit CMO protection before proposing adoption. A clearly slower all-loop candidate is rejected; retain explicit calls unless a narrowly justified hybrid is separately reviewed.

Unified generation is independent maintenance work. Helper extraction, one unified 128-bit handler and phase-profiler redesign are deferred.

## Verification and independent review

All 17 commands exited zero: generator check, control/candidate assembly builds, and Verify/ExtraVerify/PhaseVerify under ASan and WMO. Phase verification passed 53,015 partial/full checks over 2,305 limits, including raw-buffer padding equality. Source expansion independently reproduces the entire control file exactly.

Only factors 5 and 7 fully fold the chunk loop. The other 52 cases retain runtime chunk iteration and remainder arithmetic (multiply/shift sequences, not division instructions). Both dense helpers are now inlined into `runSieve`, whose frame grows from 240 to 912 bytes. The four sparse loops remain 51 instructions per 16 stores without stack accesses; `completedPass` retains the real observer and release calls. These facts require timing rather than a performance prediction.

Raw evidence is in `../compact-loop-evidence/`: verification commands and output, both assembly files, execution wrapper/support, and independent admission record. The inherited all-language CI runs 34719247028 and 34719248503 were cancelled because they enumerate `Prime*/Dockerfile` and do not exercise this experiment. The dedicated local checks above were all executed; native Linux and packaged-source checks are conditional on surviving the local screen.

## Timing result: rejected

One serial session on Apple M4 Pro / Swift 6.3.3 compared exact control `1d0522115846d8c6487d49a9bf0e60b18b9d8599` with exact compact candidate `1a259a84a892cc1008de179ef332d66bd1c514bf`, using unchanged `compare_optimizations.py`, the frozen `25402d4` runner and observer, and `-O -whole-module-optimization`. The lock covered all compilation and trials, and the command used unique `--output`. Order: control/candidate, candidate/control, control/candidate. All six five-second runs validated 78,498 primes, one thread and the required base/faithful/bits tags.

| Variant | Median µs/sieve | Three-trial range µs/sieve |
|---|---:|---:|
| Adopted cutoff 111 | 38.298 | 38.241–38.347 |
| Compact loops | 362.478 | 329.493–377.518 |

The compact version took **9.465 times as long**, reducing throughput by **89.434%** and adding **324.179 µs per sieve**. Every candidate trial was slower than every control trial. This is a development comparison, not a new upstream-baseline comparison.

An earlier preflight stopped on transient audio activity before compilation or timing; `timing-preflight-audio-1a259a8.json` preserves that attempt. No measured run was discarded or repeated. The successful session's pre/post snapshots show no competing build/test/benchmark or audio activity, but conditions were sampled only at endpoints, the desktop/OS remained active, and three rotations of two variants are not fully position-balanced. Candidate trial variation limits precise attribution; the large, consistently separated regression is sufficient to reject this refactor.

Only factors 5 and 7 fully folded. Compacting those two alone would remove just six source lines, so no hybrid follow-up was started. The candidate failed the registered local screen; no submission-package or native Linux test was started for it, and no conclusion is claimed about Linux performance. Explicit calls are retained. The useful independent maintenance change is the unified generator in [PR #21](https://github.com/fahlman/Primes/pull/21), with unchanged executable source and byte-identical complete benchmark assembly.

Raw results: `../compact-loop-evidence/timing-1a259a8.json`; conditions, command, exact source/runner/observer identities and executable hashes: `../compact-loop-evidence/timing-provenance-1a259a8.json`. Execution wrapper: `../compact-loop-evidence/time.py`.

An independent Codex audit recomputed the medians and range separation, checked exact source/harness inputs, executable and review/verification hashes, all six validation outputs and the recorded order, and confirmed rejection.
