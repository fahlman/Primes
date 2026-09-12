# PR #25: user-requested timing repeat

Status: **repeat passed verification and monitoring checks; retain rejection, closed and unmerged**. Every recurrence trial was slower than every control trial. This is a separate user-authorized session, not a pooled result or an attempt to select favorable trials. The [original report](VectorRecurrenceReview.md) and original evidence are preserved.

## Exact comparison

- Recurrence candidate: `616d0bdc184dd91c1dd30be0c7883f2880e057ce`.
- Development control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599`, still the current development head and adopted cutoff-111 sieve.
- Apple M4 Pro; macOS 26.6.2; Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3 clang-2100.1.1.101`).
- Unchanged `compare_optimizations.py`, frozen `25402d46ba991b39451724d3873d326626981e3f` runner and separate observer, identical `-O -whole-module-optimization`.
- One fresh six-trial session: control/candidate, candidate/control, control/candidate. All runs lasted at least five seconds and validated 78,498 primes, one thread and `algorithm=base,faithful=yes,bits=1` at limit 1,000,000.

The exclusive `/tmp/primes-timing.lock` covered fresh compilation and all trials; unique `--output` preserved earlier results; the lock was released. The comparison and monitoring wrapper both exited 0. Session including builds: September 12, 2026, 23:42:09–23:43:34 UTC.

## Measurements

| Version | Median µs/sieve | Three-trial range µs/sieve | Sieves/s from median |
|---|---:|---:|---:|
| Adopted cutoff 111 | 38.628090 | 38.482473–38.695233 | 25,887.90 |
| Runtime recurrence | 79.354072 | 79.264966–79.420509 | 12,601.75 |

The recurrence takes **2.054310 times as long**, delivers **51.321856% less throughput**, and adds **40.725982 µs per sieve**. Every candidate trial lost to every control trial. Retain the adopted explicit handlers and keep PR #25 closed. No merge, further timing session or conditional package/Linux test was performed.

The original session measured 39.041073 / 79.824913 µs, a 2.044639 duration ratio. Its pre-compilation snapshot recorded substantial backup and desktop activity. This repeat observes the same ordering under the newly recorded conditions; it does not isolate or quantify the earlier activity's effect. The sessions remain separate.

## Verification and conditions

Independent review confirmed that the PR head preserves all twelve runtime/build/verification files from the exact reviewed candidate. Prior source and assembly admission, all 19 successful verification commands and all eight verifier runs therefore remain applicable. Those full correctness suites were not duplicated for a request to repeat timing; each fresh benchmark run performed its normal validation.

Both fresh executables are byte-identical to the originals: control SHA256 `31fd5e6de9f702f99f86fa54e14b6c8655abb2b057977be4fce4d08ebc391b4f`, recurrence SHA256 `b2e4d91a9a012c79dd5cd8d47fb2532dad094334003c0113aabc6604c8ba7a51`. No sieve, runner, observer or verifier source changed. This repeat does not add compile-time measurements or update the original single-build observations.

All 16 five-second samples and the endpoint checks recorded Time Machine idle and no audio assertions. Every sampled compiler/benchmark process had recorded parent ancestry to the owned comparison process; Swift frontend children with separate process groups were correctly identified. No unidentified competing build/test/benchmark or sampler error was observed. No backup command was needed.

Desktop/OS activity remained. The initial snapshot recorded two `corespotlightd` processes at 86.8% and 84.7% CPU. During the six benchmark samples WindowServer ranged about 12–29% CPU and Codex Renderer about 3–7%. Periodic observations are not continuous tracing and cannot prove zero interference or absence of human desktop use. Three rotations of two variants are also not fully position-balanced. The consistent separation supports retaining rejection; it is not a statistical significance claim, a new upstream-baseline comparison or a prediction for Linux/Threadripper.

## Evidence

New files in `../vector-recurrence-retest-evidence/`: `protocol.json`, exact executed `time_retest.py`, `timing-2026-09-12T234209.874361Z.json`, `provenance-2026-09-12T234209.874361Z.json`, and `audit.json`. The wrapper imports unchanged `vector-recurrence-evidence/primes_run_support.py`. Its SHA256 is `ea0be2830110dd8979c85570ed8f6bd30f18746c634d28e5442b85c2927924e0`.

The independent audit checks calculations, sample validity and order, exact source/compiler/harness identities, original and fresh binary hashes, recorded process ancestry and conditions, and lock cleanup. All original evidence files remain byte-identical. Upstream submission remains paused.
