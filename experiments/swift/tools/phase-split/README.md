# Current-source phase diagnostics

Future profiling uses `CurrentPhaseSieve`, generated from the current
`PrimeSieve.swift` at build time. Production source, benchmark and observer are
unchanged. The checked-in `PhaseSieve.swift` remains the independent historical
`8f108f5` reference; it is **not** an input to the current phase benchmark.
Existing historical verification and Linux validation paths remain available.

## Derivation and stale-source protection

`GenerateCurrentPhaseSieve.swift` requires exactly one occurrence of each of
three source anchors. It changes only the class name, the `runSieve` signature
to accept a factor cutoff, and the outer discovery-loop condition to apply that
cutoff. It reverses the substitutions and requires byte equality with production
before writing a new build-input directory. An unsupported source shape fails
closed and requires review of the transformation. The generated source also has
a three-line identity comment header; it is never maintained by hand.

The generator writes `CurrentPhaseSieve.swift`, `CurrentPhaseIdentity.swift` and
`source-identity.json`. Metadata records absolute production/derived paths and
Git blob identities (which include Git's object header; they are not SHA256 file
hashes). The runner and new verifier rehash both source files before and after
work, outside any timed region. A stale binary refuses changed or missing
source inputs. Keep the generated inputs beside the binary; rebuild after
moving the checkout or changing production. Git is required for identity checks;
there is no new package dependency.

This prevents using the historical copy as the current benchmark by accident:
`PhaseBench.swift` now requires `CurrentPhaseSieve` and its generated identity,
and will not compile with only `PhaseSieve.swift`. Source identity does not
establish equivalent machine code or prove the binary's build provenance;
record the compiler commands, binary hashes and assembly review as usual.

## Build and short checks

From `experiments/swift`, exclusively acquire and own the timing lock described
in [AGENTS.md](../../AGENTS.md) before any compilation or execution. Release
only your own lock in a `finally`/trap. No competing builds, tests, benchmarks
or media. The script checks lock presence; the caller remains responsible for
ownership. Use a new directory for each build so existing inputs and evidence
are not overwritten:

```sh
mkdir -p .build
sh tools/phase-split/build-current.sh .build/UNIQUE_PHASE_BUILD
.build/UNIQUE_PHASE_BUILD/phase-current --check
```

The build script compiles the generator, derives fresh input, compiles the opaque
observer as a separate module, and builds the phase runner with
`-O -whole-module-optimization`. It does not run diagnostic workloads. `--check`
validates full-buffer equality and 78,498 primes at one million, then executes
each of the eight wrappers once. It emits no timing samples and does not
replace the partial-flag verifier.

Compile and run `CurrentPhaseVerify.swift` with both AddressSanitizer and the
benchmark optimization flags, using the same generated input:

```sh
phase_build_dir=.build/UNIQUE_PHASE_BUILD
swiftc -O -sanitize=address PrimeSieve.swift \
  "$phase_build_dir/inputs/CurrentPhaseSieve.swift" \
  "$phase_build_dir/inputs/CurrentPhaseIdentity.swift" \
  tools/phase-split/PhaseSourceGuard.swift tools/phase-split/PhaseSieve.swift \
  tools/phase-split/CurrentPhaseVerify.swift -o "$phase_build_dir/verify-current-asan"
"$phase_build_dir/verify-current-asan"
swiftc -O -whole-module-optimization PrimeSieve.swift \
  "$phase_build_dir/inputs/CurrentPhaseSieve.swift" \
  "$phase_build_dir/inputs/CurrentPhaseIdentity.swift" \
  tools/phase-split/PhaseSourceGuard.swift tools/phase-split/PhaseSieve.swift \
  tools/phase-split/CurrentPhaseVerify.swift -o "$phase_build_dir/verify-current"
"$phase_build_dir/verify-current"
```

Every valid odd flag is compared with an independent Boolean sieve stopped at
the same factor. Full raw buffers, including padding, must agree with both
production and `HistoricalPhaseSieve8f108f5` (an explicit versioned alias for the
preserved source). The suite retains the historical limits and cutoffs and adds
109–114 around the current dense-111/sparse-113 transition. It checks allocation
zeroing, small limits, prime-square and dense alignment/group boundaries, varied
limits, and the known one-million count. The unchanged `PhaseVerify.swift`
continues to support the original verification command independently:

```sh
swiftc -O -whole-module-optimization PrimeSieve.swift \
  tools/phase-split/PhaseSieve.swift tools/phase-split/PhaseVerify.swift \
  -o "$phase_build_dir/verify-historical"
"$phase_build_dir/verify-historical"
```

Use `-O -sanitize=address` in place of WMO for its original ASan check.
At exact candidate `0c605a4`, current verification passed 66,845 checks over
2,305 limits under both ASan and WMO. Actual binary review, short wrapper checks
and stale-input/overwrite refusals passed. See the [verification record](../../reports/CurrentPhaseTools.md).
No new phase timings are claimed.

## Future timing and interpretation

A timing campaign requires explicit scope, verification and independent review
of the committed diagnostic first. Inspect the complete timed path, including
the real separately compiled observer call and release in every wrapper. Use
`--check` for the short tooling check; **do not start the following campaign as
part of maintaining these tools**:

```sh
.build/UNIQUE_PHASE_BUILD/phase-current --output UNIQUE_RESULTS.json
```

Eight cumulative modes run serially for five seconds each across three rotated
rounds: allocation only, through factors 3, 63, **111**, 251 and 499, derived full,
and production full. That is 24 runs and at least 120 seconds of timed work.
Three rotations do not fully balance eight positions. All modes include fresh
allocation/zeroing, opaque observation and release; clock and runner overhead
are included. Source checks, validation, enumeration and printing are outside
timing. Schema version 2 records both source identities plus every sample's
order, duration, pass count and checksum. The output path is required and
existing results are never overwritten. Preserve exact revisions, source/binary
hashes, compiler, hardware, commands and conditions with the JSON.

Partial modes are diagnostics, not complete qualifying sieves; their checksums
are not prime counts. The generated full sieve retains the production source's
`base,faithful=yes,bits=1`, single-thread marking mechanics, with an additional
runtime factor cutoff. Classification is source-based. Differences of cumulative
medians estimate stage costs, including factor discovery and effects of stopping
early; they are not timers inside one production pass. At the current cutoff,
63→111 covers the 128-bit stage and the higher bands use the sparse kernel.

Predeclared interpretation criterion: if the derived-full median differs from
production by more than 3%, report the mismatch and avoid fine attribution of
the production total. Passing that screen does not establish identical codegen
for partial modes. Compiler specialization, code layout, cache state, drift and
desktop noise remain limitations. No optimization gain follows from this tool;
use `compare_optimizations.py` under the normal benchmark contract for that
claim, and never combine ratios from separate sessions.

## Preserved historical reference and results

`PhaseSieve.swift` is the unchanged diagnostic copy of production `8f108f5`,
merged in `703dc12` and unchanged in development `1edbea7`. Only its class name,
method signature and cutoff condition differ from that revision, plus its
six-line historical header. Its companion `PhaseVerify.swift` is also unchanged.
The versioned alias in the current verifier identifies its historical role
without renaming files used by prior verification and Linux automation.

The [B breakdown](../../reports/FusedSparseBandBreakdown.md) records the
`56ad42b` copy, 21 timing samples and the passing 3% full-copy control. The
[earlier through-63 breakdown](../../reports/PhaseBreakdownThrough63.md) and
[earlier sparse-band report](https://github.com/fahlman/Primes/blob/a7fc27f8c53a29215a5bc54c73f4bcd8e80186b6/experiments/swift/reports/SparseBandBreakdown.md)
describe `19aa38a`. These are historical evidence, not current phase measurements.
The old seven-mode benchmark is retained in Git history; new commands above use
freshly derived current source.

The following operation counts describe historical B only:

At 1,000,000, the three sparse bands differ in factor count, stride and loop
length. Counts of B's source byte writes, with one fused traversal per factor:

| Band | Factor loops | Byte writes | Rounded writes per factor loop |
|---|---:|---:|---:|
| 67–251 | 36 | 132,120 | 3,670 |
| 257–499 | 41 | 48,828 | 1,191 |
| 503–997 | 73 | 23,431 | 321 |

Writes include repeated composite marks and final-byte padding. They are source
operations, not unique composites or measured hardware stores. The eight
per-factor bit phases are fused; the old counts of 288/328/584 independent
streams do not describe B. Stride, address order and tail share vary between
bands, so normalized band costs do not isolate a universal per-loop overhead.
