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

Implementation is committed for independent review. No builds, generator
execution, Swift verification, assembly inspection or timing were performed by
the implementing agent. Those checks are pending under the coordinating agent's
lock. The bounded acceptance work is:

1. Confirm unchanged production and historical-reference bytes and inspect the
   exact three substitutions in freshly generated input.
2. Build the new tool with the separately compiled observer; run current partial
   verification with ASan and WMO while retaining the original verification.
3. Exercise generator refusal for missing/ambiguous anchors, changed-source
   detection and unique-output protection using disposable build inputs.
4. Run `--check` and inspect the complete timed path, observer calls and release.

Commands and future profiling limitations are in the
[phase-tools README](../tools/phase-split/README.md). A new phase-timing campaign
is outside this maintenance task. No performance improvement or current phase
cost is claimed; all earlier reports remain historical evidence.
