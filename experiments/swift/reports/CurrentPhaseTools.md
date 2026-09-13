# Current-source phase tooling

This maintenance change removes the need to update a checked-in profiling copy
after each production optimization. It changes no production sieve, benchmark,
observer, generated marking blocks, or build flags. Base revision:
`1d0522115846d8c6487d49a9bf0e60b18b9d8599`.

`GenerateCurrentPhaseSieve.swift` derives a current diagnostic with exactly three
reversible source substitutions: class name, cutoff parameter, and outer-loop
condition. It requires complete byte equality after reversing the changes and
records Git blob identities for production and generated input. The current
benchmark and verifier check both identities before and after execution. A
stale binary fails when its source inputs change or disappear. Generated files
belong in a new build directory, not in the repository.

The existing `PhaseSieve.swift` and `PhaseVerify.swift` remain byte-for-byte the
historical `8f108f5` reference and its independent Boolean verification suite.
The new verifier uses the explicit `HistoricalPhaseSieve8f108f5` alias for full
raw-buffer comparisons, retains the old case set, and adds cutoffs 109–114
around the current dense/sparse boundary. Old Linux automation and commands
continue to use the original paths.

The current runner adds the through-111 stage and uses the freshly generated
class throughout its partial workloads. Full flags are compared with production
before timing. Source checks and enumeration remain outside timed regions;
fresh allocation, initialization, marking, opaque observation and release remain
inside each pass. `--check` executes each wrapper once without timing trials.
Partial workloads remain diagnostics, not complete qualifying sieve passes.

Exact source candidate: `0c605a4d6d74a4f7515612035c1fdb51749fd0ca`, following implementation `adc74e0`. [PR #24](https://github.com/fahlman/Primes/pull/24). Status: verified and independently reviewed; ready for integration, unmerged. Production sieve, runner, observer and historical verifier/source are unchanged from the base.

## Completed verification

The central coordinator built and ran the new tools under the exclusive timing lock on Apple M4 Pro / Swift 6.3.3. Both AddressSanitizer and optimized WMO verification passed **66,845 partial/full flag checks over 2,305 limits**, including allocation zeroing, the independent Boolean reference, production/historical full raw-buffer equality including padding, and 78,498 primes at one million. These are two runs of the same checks, not 133,690 distinct cases.

The generated source reversed to exact production bytes after removing its three-line header and reversing the three substitutions. Production, runner, observer and both historical source/verifier files match the pinned base hashes. The current phase binary passed `--check` before and after verification: all eight wrappers executed once, full raw flags agreed, and source identities remained current. No five-second phase trials were run.

Expected-failure checks also passed, each exiting 1 with a clear error:

- Modifying the disposable generated input prevents the real phase binary from starting trials or writing output; restoring it restores validity.
- A disposable production copy passes its identity guard, then fails after modification. Actual production was never edited.
- Missing or ambiguous transformation anchors are rejected before creating generated output.
- Existing generated inputs and existing result files are preserved on refusal; invalid CLI arguments fail before any trial.

The main record contains 15 commands: 12 successful commands and three expected refusals. A separate guard record adds four expected refusals without rebuilding or repeating correctness runs. Both lock holds ended with the lock released. Raw commands, outputs, identities and hashes are in `../current-phase-evidence/verification-0c605a4.json` and `guard-checks-0c605a4.json`; the exact orchestration/support scripts and actual executable disassembly are preserved alongside them.

## Actual binary review

Independent Codex review inspected the built executable and the completed verification records. The production full wrapper retains actual initialization, production sieving, opaque observation and release. The six derived wrappers supply their cutoff to a shared body that performs initialization, current derived sieving, opaque observation and release. Allocation-only retains initialization, observation and release without marking. The shared initializer still allocates and zeroes the complete buffer; release reaches buffer deallocation. The production/full, allocation-only and shared derived wrappers are 30, 29 and 32 instructions respectively. Production runSieve is 907 instructions; the derived body is 931, reflecting the added cutoff. Exact review conclusions and evidence hashes are in `independent-review-0c605a4.json`.

Source identity checks, validation, enumeration and printing remain outside the timed pass and timing loop. Clock/runner overhead stays in the measurement as documented. The observer is a real call to the separately compiled module. This is a lifetime/workload review, not a claim of byte-identical production and diagnostic assembly or equivalent performance.

The inherited all-language CI runs 34721077194 and 34721078607 were cancelled because they do not exercise `experiments/swift`; the dedicated local checks above ran instead. New native Linux checks were not run for this diagnostic-only change, and no Linux compatibility claim is added. Existing production Linux evidence and historical validation entry points remain unchanged.

Commands and future profiling limitations are in the
[phase-tools README](../tools/phase-split/README.md). A new phase-timing campaign
is outside this maintenance task. No performance improvement or current phase
cost is claimed; all earlier reports remain historical evidence.

## Integration

Adopted in PR #24 merge commit `2ee7b3a`, following generator PR #21 merge `7be57ca`. Production retains the same marking source; only the generator's two 64-bit marker comments differ from `1d05221`. A fresh phase build generated identities from the merged source, and `--check` passed all eight wrappers with full raw-buffer equality and 78,498 primes. Independently reversing the three substitutions reproduced production exactly. `maintenance-integration-evidence/checks-2ee7b3a.json` records commands, identities, binary hash and lock cleanup. Prior ASan/WMO and actual-binary evidence remains applicable to unchanged tooling/runtime inputs; no full-suite repeat or timing campaign was added.

Retrieve the named records from the [phase-tool evidence archive](https://github.com/fahlman/Primes/tree/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/current-phase-evidence) and [integration checks archive](https://github.com/fahlman/Primes/blob/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift/maintenance-integration-evidence/checks-2ee7b3a.json).
