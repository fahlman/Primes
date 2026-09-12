# Compact dense-loop experiment

Status: implementation complete; verification, independent review and timing pending. Submission remains paused.

Control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599`, whose sieve is the adopted cutoff-111 source `099e35a`.

The candidate replaces each generated group of per-chunk calls with a case-literal `for j` loop. The offset remains `(p - (width * j) % p) % p`, with literal width and factor. All 54 odd-factor cases remain: 5–63 on 64-bit words and 65–111 on 128-bit chunks. Allocation, runtime factor discovery, p² starts, helpers, alignment, padding endpoints, sparse marking, runner and observer are unchanged. Source still marks each multiple with its own single-bit OR; classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

The source falls from 3,679 to 709 lines. This is a source-size result, not a machine-code or throughput claim.

## Bounded evaluation

1. Compile the control and candidate with the frozen benchmark context and inspect all changed functions and the complete timed path, including the real observer call. Record residual chunk loops, remainder arithmetic, shifts, outlining and spills rather than predicting speed from instruction counts.
2. Run the existing generator check and Verify/ExtraVerify/PhaseVerify under ASan and WMO. Raw-buffer equality must include padding. Commit and publish independent exact-revision review before timing.
3. Run one `compare_optimizations.py` session with the current control and candidate, three rotated five-second trials each, under `/tmp/primes-timing.lock` and with unique `--output`. Do not repeat a flat or losing result to seek a win. This is a refactor: identical compiled timed paths need no new timing; changed paths require measured evidence, and overlapping trial ranges alone cannot establish equivalence.
4. If the compact form survives the local screen, inspect the actual submission SwiftPM build and native Linux arm64/amd64 builds with the same harness and explicit CMO protection before proposing adoption. A clearly slower all-loop candidate is rejected; retain explicit calls unless a narrowly justified hybrid is separately reviewed.

Unified generation is independent maintenance work. Helper extraction, one unified 128-bit handler and phase-profiler redesign are deferred.
