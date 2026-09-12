# Shared marking helpers review

Candidate: `06b24cba796ce60fae80e6823d9858ef014f1fe8`; adopted control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599` (cutoff 111). PR #22. Status: source and correctness review passed; admitted to timing; unmerged.

Three copies of the eight-mark sparse group use one inline local helper. Seven scalar phases use one inline helper with explicit endpoint, alignment and checked/wrapping options. The sieve shrinks from 3,679 to 3,670 physical lines; nonblank/noncomment handwritten lines fall from 232 to 218. Generated switches, dense geometry, all odd cases, runtime discovery, p² starts, fresh state, observer and verifier inputs are unchanged. Source still marks each multiple individually; classification remains `algorithm=base,faithful=yes,bits=1`, one thread.

Independent Codex source review found no bounds, padding or arithmetic blocker. All 16 central commands exited 0: generator check, observer/assembly builds, and Verify/ExtraVerify/PhaseVerify under ASan and WMO. Both phase runs passed 53,015 checks over 2,305 limits, including full raw-buffer padding equality. The timing lock was released.

## Assembly

Same M4 Pro / Swift 6.3.3, frozen runner/observer and `-O -whole-module-optimization`; exact control assembly is reused from verified immutable evidence `8bb522f`, with matching source, compiler, flags, module name, harness and assembly hashes. No timing control is reused: timed candidates will compile and run together.

| Instruction count | Control | Candidate |
|---|---:|---:|
| runSieve | 907 | 954 |
| 64-bit handler | 2,530 | 2,537 |
| 128-bit handler | 8,061 | 8,069 |

The runSieve frame grows from 240 to 272 bytes, with 50 to 56 stack accesses. After local-label normalization, 29 of 32 instruction bodies are unchanged. All four sparse main loops remain 51 instructions per 16 marks without stack access; no markGroup or markScalar call remains. The 30-instruction completedPass wrapper retains real initialization, sieve, observer and release calls. This is not assembly identity and therefore requires timing.

## Registered timing

One `compare_optimizations.py` session will compile and compare adopted control, helpers and unified128 candidate 9b2d9cb if both are admitted, three rotated five-second trials each, under the exclusive lock and unique `--output`. A measured slowdown is rejected. Overlapping ranges do not prove preserved speed. Any surviving runtime change needs the actual submission SwiftPM context and native Linux checks before adoption. No merges or upstream submission are included.

Raw evidence is in `../marking-helpers-evidence/`. Inherited all-language CI runs 34720673477 and 34720675555 were cancelled because they enumerate Prime*/Dockerfile and do not exercise experiments/swift; dedicated checks above were executed.
