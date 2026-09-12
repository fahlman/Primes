# Unified dense generator review

Candidate: `9c5d7e541499294c49b0a256441347555b9410eb`, following `ce33c7d021f464b4740dcaa46d9ae5bbf2fb065b`.
Control: adopted development `1d0522115846d8c6487d49a9bf0e60b18b9d8599` (cutoff-111 sieve from `099e35a`).
Status: implementation and checks complete; ready for integration review, not adopted. Upstream submission remains paused.

## Change

One Swift generator now emits both explicit dense switches, covering all 54 odd values: 5–63 on 64-bit words (1,020 calls) and 65–111 on 128-bit chunks (2,112 calls). It uses the same normalized offset formula for both widths, performs no primality test and constructs no composite masks. The old 128-bit generator filename forwards to the canonical tool for existing validation commands. Both `--check` and `--write` cover both blocks; writes happen once, only after both marker pairs are validated. Invalid input prints a concise error and exits 1.

The sieve gains only two 64-bit marker comments. Removing those lines reproduces the entire control source byte-for-byte, SHA-256 `f5b7d8f32b5aa53010e39869855e75033b3c998cb70829722bd2ef93a3352448`. All marking operations, alignment, padding, runtime discovery, fresh allocation, runner and observer stay identical. Classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

## Evidence

Independent Codex source review regenerated every block and checked that each factor covers exactly `0,p,...,(width-1)p`. Source review found no blocker.

Under the exclusive timing lock, the canonical and compatibility commands passed. Deliberately changed calls in each width were rejected; `--write` restored the exact source, including unchanged text outside the blocks. A missing marker caused failure without changing the file. The initial error path raised an uncaught top-level error and produced a Swift crash trace; that historical record is preserved. Commit `9c5d7e5` catches errors; all 11 follow-up commands returned their expected exit code, including five deliberate exit-1 checks, without crash dumps.

The complete optimized assembly of the sieve plus frozen benchmark is **byte-identical**, without label normalization, to the control: SHA-256 `8a8ec1e81bf8f5095e4d09b65b5e8ecfaf407f253b90cdeb6264ec8d5c8ffe8f`. This includes all handlers and the real observer and release calls. Both builds used Apple M4 Pro / Swift 6.3.3, `-O -whole-module-optimization`, the same module name, runner and separately compiled observer. The later catch-only generator change leaves these runtime bytes unchanged.

Raw commands, outputs, wrapper sources, assembly and hashes are in `../dense-generator-evidence/`. No new throughput timing was run: this maintenance change preserves the complete compiled timed path. No Linux run was added for the comment-only sieve change; existing Linux evidence remains scoped to adopted source `099e35a`.

## Scope

The compact loop experiment is separate, in PR #20. This change retains all explicit calls. Runtime helper extraction, a unified 128-bit handler and phase-profiler redesign remain deferred. No submission-package files or upstream repository settings were changed.

## Integration review follow-up

Commit `26c88ef` addresses Claude’s two non-blocking notes: the success message derives its ranges from the existing switch labels, and the rejected PR #20 entry is retained in the Experiments table rather than leading Current best. The canonical and compatibility `--check` commands both passed under the timing lock; `dense-generator-evidence/integration-checks.json` preserves the outputs and exact revision. The sieve is byte-identical to the previously reviewed PR head, and removing the two marker comments still restores adopted source exactly. No runtime or assembly change and no additional timing campaign.

Adopted via PR #21 merge commit `7be57ca`. The subsequent PR #24 integration rebuilt current-source phase diagnostics from the marker-comment source and passed all eight short wrapper checks; see `maintenance-integration-evidence/checks-2ee7b3a.json`.
