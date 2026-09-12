# Compact dense-loop experiment

Status: exact candidate `1a259a84a892cc1008de179ef332d66bd1c514bf` passed verification and independent Codex source/assembly review; admitted to the one registered timing session. Submission remains paused.

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
