# Shared storage layout review

Candidate `5cbc25e1c41d55e1a48db4737721e589e046b08e` centralizes logical storage sizing without changing the optimized benchmark assembly. The control is adopted development `84d8a4fb0235ca4d5e8261a80877499e3b36b3ef`. This is a maintenance change; no throughput comparison ran and no speedup is claimed. Adopted through [PR #27](https://github.com/fahlman/Primes/pull/27) in merge `b33b2fc0192b446c70369a9bd0dd7eacabb331c8`; the merged tree exactly matches reviewed head `34ebe8b`.

`PrimeSieve.storageLayout(for:)` returns a small `StorageLayout` value containing the logical odd-candidate count. Its computed `byteCount` uses the original quotient/remainder expression. Initialization stores limit, odd count and byte count in the original order, and benchmark setup uses the same API outside `completedPass`. The class still stores the same four fields. A zero-byte layout still allocates capacity one and exposes nil through `withStorage`; no cache or retained layout is introduced. Deinitialization, every marking method, enumeration, observer implementation and the `completedPass` body are unchanged. Source classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

The factory evaluates `(limit - 1) / 2` only when `limit >= 3`, so even `Int.min` is safe. Logical counts are nonnegative and at most `Int.max / 2`. Quotient plus a possible one computes the byte ceiling without overflow. The new verifier uses 25 fixed expected layouts, including empty storage and both sides of byte boundaries, checks every logical byte is initially zero, and tests `Int.min`/`Int.max` layout arithmetic without attempting huge allocations. Existing prime-list and repeated-marking checks remain.

## Assembly gate

The final candidate uses its actual committed `Benchmark.swift`, compiled with `-O -whole-module-optimization`, module name `PrimeSwift`, and the real observer compiled separately as in `run.sh`. The exact control assembly was reused from the preserved initial session after verifying its source, compiler and artifact hashes. The final candidate's complete assembly, including data and metadata, is byte-for-byte identical to that control:

```
5805244719327f8416f4885d2058037f5a226fad9c1e8fb89666c033312cbac5
```

All 32 complete emitted function bodies match, with no added functions. This covers the initializer, `completedPass`, marking kernels and `Benchmark.main`. The pass still calls the initializer, sieve, opaque observer and release. The separately compiled observer's actual object disassembly remains a nil check, byte load and return. Its raw object and disassembly hashes are recorded independently. No benchmark executable was run for throughput.

## Correctness and provenance

Final-source [verification record](../storage-layout-evidence/5cbc25e/verification.json) contains ten successful commands: compiler identification, separately compiled observer, candidate assembly, observer object inspection, and compilation/execution of Verify ASAN, Verify WMO and ExtraVerify ASAN. Verify passed all 25 storage layout/zeroing cases, extreme layout arithmetic, complete arrays for every limit -2...2048, larger square boundaries, 1M and 10M, and repeated marking. ExtraVerify passed exhaustive 2,049...30,000 limits, 11,382 wide alignment/group/tail limits, 500 random limits, 1,561 near-square limits, and 3,654 sparse boundary limits. ExtraVerify WMO and historical PhaseVerify were not rerun for this storage-only change.

The final assembly, Verify ASAN, Verify WMO and ExtraVerify ASAN compilations took 240.739, 256.909, 253.667 and 116.111 seconds in this session. Earlier preserved compilations were shorter. These are diagnostic command durations from different sessions, not a controlled compile-time comparison or evidence of a cause; no throughput conclusion follows.

Commands ran serially under an exclusively owned `/tmp/primes-timing.lock`. Exact arguments, exit codes, combined output, source/compiler hashes and before/after process snapshots are preserved. Audio assertions were recorded but were not an exclusion for these non-timing checks. Competing builds/tests/benchmarks were excluded. Final source identities and lock release were checked.

## Preserved earlier attempts

- `b992595413ec577a666ed0e79ba0ab9c8e836463` used an eager tuple and the original byte-count expression. Its Verify ASAN/WMO and ExtraVerify ASAN passed, but the initializer emitted 25 instructions versus the control's 23. Its other 31 complete functions matched. This source was not selected.
- The first `b992595` record stopped before any Swift command because the wrapper initially applied a benchmark audio exclusion to correctness. The second `b992595-checks` record ran only the Swift version command, then stopped on a wrapper argument-type error before compilation. Both failures remain unchanged. The completed third record is `b992595-checks-2`.
- `3d8477d3b171de164917184a74b0e1578907cefa` used the safe `(oddCount + 7) / 8` expression in the eager tuple. The initializer had the same 23 instructions, but one independent field store moved past the byte-count arithmetic. The strict gate stopped before that revision's correctness checks. No additional runtime change followed until the computed-layout value was authorized.
- Final `5cbc25e` restores the original expression in a computed property and passes exact assembly identity. All earlier source commits and evidence are retained; their checks are not substituted for final-source verification.

## Authoring integration

Merge `8293803b296a5a1d3f2c886f96e2bf229d6e30ce` incorporates the ready authoring branch at `5661fa4` and synchronizes only the template's class preamble with tested `5cbc25e`. The two dispatch tokens and generated-block insertion lines remain intact; the rest of the template is unchanged. Sieve, benchmark, observer, Verify and ExtraVerify bytes remain exact `5cbc25e`. Both canonical `generate-dense.swift --check PrimeSieve.swift` and compatibility `generate-dense-128.swift --check PrimeSieve.swift` passed their complete-file checks under a separately owned lock. [Integration record](../storage-layout-evidence/template-integration/verification.json). The earlier 98-case authoring suite remains in [its own report](AuthoringTemplateReview.md); only these two integration checks were rerun here.

## Evidence index

- [Final source checks and exact assembly](../storage-layout-evidence/5cbc25e/verification.json), [control assembly](../storage-layout-evidence/5cbc25e/control.s), [candidate assembly](../storage-layout-evidence/5cbc25e/candidate.s), [observer disassembly](../storage-layout-evidence/5cbc25e/observer-disassembly.txt).
- [Original completed attempt](../storage-layout-evidence/b992595-checks-2/verification.json), [audio preflight stop](../storage-layout-evidence/b992595/verification.json), [wrapper argument failure](../storage-layout-evidence/b992595-checks/verification.json), [eager-ceiling assembly gate stop](../storage-layout-evidence/3d8477d/verification.json).
- [Executed wrapper/support hashes](../storage-layout-evidence/execution-tools/sha256.json), [actual observer object provenance](../storage-layout-evidence/observer-objects/provenance.json). Each session preserves its own raw files and SHA-256 manifest. The two early wrapper failures retain their records; archived wrapper sources correspond to the later completed/gated sessions and integration.
