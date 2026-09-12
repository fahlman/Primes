# Shared marking helpers review

Candidate: `06b24cba796ce60fae80e6823d9858ef014f1fe8`; adopted control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599` (cutoff 111). PR #22. Status: tested and rejected for adoption; flat with overlapping trial ranges; unmerged.

Three copies of the eight-mark sparse group use one inline local helper. Seven scalar phases use one inline helper with explicit endpoint, alignment and checked/wrapping options. The sieve shrinks from 3,679 to 3,670 physical lines; nonblank/noncomment handwritten lines fall from 232 to 218. Generated switches, dense geometry, all odd cases, runtime discovery, p² starts, fresh state, observer and verifier inputs are unchanged. Source still marks each multiple individually; classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

Independent Codex source review found no bounds, padding or arithmetic blocker. All 16 central commands exited 0: generator check, observer/assembly builds, and Verify/ExtraVerify/PhaseVerify under ASan and WMO. Both phase runs passed 53,015 checks over 2,305 limits, including full raw-buffer padding equality. The timing lock was released.

## Assembly

Same M4 Pro / Swift 6.3.3, frozen runner/observer and `-O -whole-module-optimization`; exact control assembly is reused from verified immutable evidence `8bb522f`, with matching source, compiler, flags, module name, harness and assembly hashes. No timing control is reused: timed candidates were compiled and run together.

| Instruction count | Control | Candidate |
|---|---:|---:|
| runSieve | 907 | 954 |
| 64-bit handler | 2,530 | 2,537 |
| 128-bit handler | 8,061 | 8,069 |

The runSieve frame grows from 240 to 272 bytes, with 50 to 56 stack accesses. After local-label normalization, 29 of 32 instruction bodies are unchanged. All four sparse main loops remain 51 instructions per 16 marks without stack access; no markGroup or markScalar call remains. The 30-instruction completedPass wrapper retains real initialization, sieve, observer and release calls. This is not assembly identity and therefore requires timing.

## Registered timing

One `compare_optimizations.py` session will compile and compare adopted control, helpers and unified128 candidate 9b2d9cb if both are admitted, three rotated five-second trials each, under the exclusive lock and unique `--output`. A measured slowdown is rejected. Overlapping ranges do not prove preserved speed. Any surviving runtime change needs the actual submission SwiftPM context and native Linux checks before adoption. No merges or upstream submission are included.

Raw evidence is in `../marking-helpers-evidence/`. Inherited all-language CI runs 34720673477 and 34720675555 were cancelled because they enumerate Prime*/Dockerfile and do not exercise experiments/swift; dedicated checks above were executed.

## Completed comparison and decision

The registered session completed on 2026-09-12 at 22:04:49 UTC, on Apple M4 Pro / Swift 6.3.3, with `-O -whole-module-optimization`, the frozen `25402d4` runner and separately compiled observer. All three executables were newly built before nine serial five-second trials under one exclusive timing-lock hold and unique `--output`. Orders were control/helpers/unified, helpers/unified/control, unified/control/helpers. Every variant occupied each position once. All nine trials validated 78,498 primes with the required one-thread/base/faithful/bits tags.

| Exact source | Median µs/sieve | Three-trial range, µs | Median passes/s | Throughput vs control |
|---|---:|---:|---:|---:|
| Adopted cutoff 111 `1d05221` | 38.989368 | 38.911773–39.084457 | 25,648.0 | control |
| Shared helpers `06b24cb` | 38.963242 | 38.880882–38.966878 | 25,665.2 | +0.0671% |
| Unified 128-bit `9b2d9cb` | 519.643315 | 517.089107–520.221286 | 1,924.4 | −92.4969% |

Helpers save 0.026127 µs at the median, but their range overlaps the control; this does not establish a gain or equivalent performance. Their assembly also failed the original identity criterion. The unified handler takes 13.3278 times as long, adding 480.653947 µs per sieve; every candidate trial is slower than every control trial. Its small-factor dynamic loops are a plausible explanation, not an isolated measurement of the cause.

Both runtime refactors are rejected for adoption: unified128 is slower, and the helper refactor failed assembly identity without establishing preserved speed in timing. Helpers did not violate the registered measured-slowdown rule; they are not selected given the user's speed priority and the inconclusive result. The source commits and evidence remain preserved, unmerged. No session was repeated to seek a win. The conditional actual-submission SwiftPM and native Linux gates were not reached; neither candidate is claimed tested in those contexts. Development remains at `1d05221`.

Pre/post snapshots show no competing build/test/benchmark process or media assertion. They do show `backupd` at 13.4% before compilation and 17.4% after timing. These endpoint-only snapshots do not establish an idle machine throughout, and three samples are not a significance or equivalence test. The tiny helper median difference is particularly inconclusive. These are M4 measurements only, against a development control; no upstream-baseline, Linux or Threadripper speed claim follows.

The raw session and provenance are preserved as `remaining-refactors-timing.json` and `remaining-refactors-timing-provenance.json` in this experiment's evidence directory. Provenance records candidate/review/verification hashes, source and runner identities, commands, raw output, binary hashes, conditions and lock release. The timing wrapper and its process/lock support are included. Independent Codex audit checked the raw samples, full rotation, hashes, pins and decision.
