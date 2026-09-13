# Swift authoring template and generator checks

The sieve's handwritten logic now lives in `tools/PrimeSieve.swift.in`; the
canonical generator inserts the two explicit switches and derives their runtime
dispatch bounds from the same factor metadata. The complete `PrimeSieve.swift`
remains committed and is compiled directly. No build-time generator is required.

Initial authoring candidate: `1f9e11e2bb9cf4db867dbe61c82357f4cce115a3`, against
adopted development `84d8a4fb0235ca4d5e8261a80877499e3b36b3ef`.

## Scope and source review

This implements refactor review items 1–3. The 323-line initial template replaces
only the two marked blocks with insertion lines and the two dispatch literals
with tokens. The initial compiled source, observer, benchmark and build flags are
unchanged. The rendered file still contains every odd-factor case and every
individual marking operation; classification remains `base,faithful=yes,bits=1`.

Codex reviewed the generator, template and checker independently of their author.
Review caught and corrected multiline-string indentation and the distinction
between Swift String equality and original file-byte equality before execution.
`--check` compares original Data with the complete rendered UTF-8 data. `--write`
validates the complete template and both existing source marker pairs before one
atomic full-file replacement. Manual output edits must move into the template.

The generator checks its supported dispatch shape, contiguous odd ranges and
scoped helper bit/storage widths. This is a narrow source contract, not a Swift
parser or a substitute for sieve correctness checks. The compatibility filename
forwards to the same implementation. Historical generators and evidence remain
unchanged at their original commits.

The reusable Swift checker uses disposable fixtures. It independently expands
emitted individual calls into absolute positions and compares them with a linear
sequence of multiples. It also checks full-source regeneration, corrupt blocks,
cutoff drift, malformed source/template markers, dispatch/helper changes, bad
arguments, failed-write preservation, Unicode byte differences and a source BOM.
It records each command's arguments and exit status as JSON and removes its own
fixtures. It does not execute the sieve.

## Verification

The exact initial execution and source hashes are recorded under
`authoring-refactor-evidence/1f9e11e/`. See `verification.json` and
`generator-checks.stdout` for actual outcomes and command exits. All 98 CLI
commands passed their expected exits. The independent schedules cover 54 odd
factors, 3,132 helper calls and 4,992 individual marks. The initial rendered
source is byte-identical to adopted development; fixture cleanup and owned lock
release passed. Swift 6.3.3 on the reference M4 Pro; no sieve was executed.

No throughput run is part of this authoring change. Byte-identical compiled source
and unchanged build inputs are the runtime-preservation evidence; no speedup is
claimed. Storage-layout integration is reviewed and verified separately.
