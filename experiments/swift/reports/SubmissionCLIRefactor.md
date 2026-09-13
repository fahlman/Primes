# Prepared Swift package refactors

This fork-only review record covers the remaining CLI refactors and their
integration with the reviewed authoring template and storage layout. The upstream
submission stays paused. The prepared package payload contains only files under
`PrimeSwift/solution_1`; this report and raw evidence are published separately.

## Exact source

Base package: `890909588f311f9314933d0517e07416310a7c7b`.

- `7cac1af2303386749cf951aa54eae0e76bf300e4`: one throwing duration conversion,
  used by validation and immediately before timing. It preserves finite and
  nonnegative checks, upward nanosecond rounding and the UInt64 representability
  boundary, with no cached configuration state.
- `37912a9cf1ba7204b6c8ec3e767dc70ac6f4a69d`: keep the inclusive prime array and
  use a slice for the existing exclusive CLI limit, dropping only a matching final
  element. The numeric limit passed to the timed sieve remains unchanged.
- `1164f13`: integrate exact storage source/verifier `5cbc25e` and the authoring
  generator/template/shim from `1f9e11e`; the caller uses the shared storage count.
- Final source `b826fc6af66835d67494c7d0646fc7d596a2ccc8`: package-specific generator
  usage comments. The executable generator body is unchanged.

Root Codex reviewed the separate CLI changes and exact integration. The core and
verifier match the storage candidate byte for byte. The template differs from the
initial authoring template only in the accepted class preamble. Source after
`deinit`, the completedPass body, timed loop, observer, compiler settings, package
dependencies, Dockerfile, other entries and ExtraVerify remain unchanged.

The duration helper runs before the timer. Result slicing and printing run after
it. The storage refactor has separate byte-identical full-assembly evidence.
Classification remains `algorithm=base,faithful=yes,bits=1`: runtime discovery,
individual composite marks, fresh per-pass class-owned storage, one thread and a
real separately compiled observer are preserved. No throughput gain is claimed.

## Validation scope

The focused package bracket builds release and release with AddressSanitizer,
checks the actual CLI at empty/prime-endpoint/default limits, invalid durations
and fractional nanoseconds, directly probes conversion near its representability
boundary without running huge durations, and inspects the real observer call and
release in the emitted executable. Package generator checks use both filenames
and a disposable write target. The identical standalone core/verifier use the
storage candidate's correctness bracket rather than duplicating it here.

The [final verification](../submission-cli-refactor-evidence/b826fc6/verification.json)
passed all 41 commands: 29 successful exits and 12 expected argument-error exits
(64). Release and ASan each passed 14 CLI cases, including exact empty lists,
prime endpoints and the complete 78,498-element list below one million. All 19
direct duration probes and six generator commands passed. The actual release
completedPass contains real initializer, sieve, opaque observer and release
calls. Final source hashes are unchanged and the owned lock was released.

[Source proof](../submission-cli-refactor-evidence/b826fc6/integration-source-proof-b826fc6.json),
[pass disassembly](../submission-cli-refactor-evidence/b826fc6/completedPass.txt),
and [artifact hashes](../submission-cli-refactor-evidence/b826fc6/sha256.json)
are preserved with the raw command logs. Root independently audited every
recorded command exit and log hash, plus the harness/probe/source-proof and
prior control-record hashes. This is actual package behavior verification, not
a claim of whole-package assembly identity. The separate storage evidence
establishes byte identity for the complete experimental benchmark assembly. Native Linux/Docker package validation and a current direct upstream
performance comparison are separate submission work; this refactor bracket does
not provide either result.
