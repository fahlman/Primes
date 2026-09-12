# Unified 128-bit dense-handler review

Candidate: `9b2d9cb52aacc8ed69f47a1b1dab7181b85e578d`; adopted control: `1d0522115846d8c6487d49a9bf0e60b18b9d8599` (cutoff 111). PR #23. Status: tested and rejected for adoption; 13.3278 times the control duration; unmerged.

One explicit 128-bit handler covers all 55 odd factors 3–111, replacing factor 3's byte path and the 64-bit path. The generator emits 3,135 calls. PrimeSieve.swift falls from 3,679 to 3,576 physical lines. The old 65–111 cases and sparse path are unchanged. Each helper retains individual single-bit ORs, little-endian lane conversion and unaligned access. Runtime discovery and fresh per-pass state remain; classification stays `algorithm=base,faithful=yes,bits=1`, one thread.

## Correctness and bounds

Factors below 64 still stop at oddCount; larger factors use byteCount*8, preserving padding exactly. Each factor starts at p² and peels to 128-bit alignment. Odd p guarantees alignment within 127 marks. The chosen fullWords=bitEnd>>7 bound ensures every 16-byte chunk exists. Each group covers 128 consecutive multiples, then a bounded scalar tail completes the selected range. The normalized generator formula was independently checked across all 55 cases and all 3,135 calls; old 65–111 case bodies match exactly (the default diagnostic correctly names the expanded range).

All 16 central commands exited 0, including generator, observer/assembly builds and six actual ASan/WMO verifier runs. The independent Boolean/list checks passed through 10M. Expanded ExtraVerify retained all earlier inputs and checked 21,527 deduplicated 128-bit alignment/group/tail limits. Both PhaseVerify runs passed 62,054 partial/full checks over 2,698 limits, including exact raw padding against the unchanged historical reference. The lock was released. Source and code-generation review by another Codex agent found no correctness/classification blockers.

## Code generation

Same M4 Pro / Swift 6.3.3 and frozen benchmark context as the control; exact prior control assembly was reused only after verifying source/compiler/flags/harness/module identity. Timed controls were newly compiled alongside candidates.

The pass wrapper remains 30 instructions with real initializer, runSieve, opaque observer and release calls. Initialization/deallocation remain 23/11 instructions. runSieve shrinks 907→752 instructions, while the unified dense handler grows to 13,809 versus the old word+vector handlers’ 2,530+8,061. Its frame is 848 bytes versus 720 for the old vector helper. Direct SP/x29 memory instructions are 1,219 versus 597 combined in the old word/vector helpers; these are static counts, not measured dynamic spill costs.

Factors 3 and 5 retain dynamic per-bit loops, variable shifts/lane selection and stack temporaries; factor 7 folds into immediate/vector ORs. The new dense handler contains no helper calls. This material code-generation change requires timing; neither a speedup nor a slowdown is inferred from instruction counts.

## Registered timing and evidence

One serial `compare_optimizations.py` session compares adopted control, inline-helper candidate 06b24cb and this candidate, three rotated five-second trials each, with the exclusive lock and unique `--output`. A measured slowdown is rejected; overlapping ranges do not prove equivalent speed. Surviving runtime changes require actual submission SwiftPM and native Linux checks before adoption. No merge or upstream submission is part of this experiment.

Commands, outputs, hashes, complete candidate assembly and wrapper sources are in `../unified-dense-128-evidence/`. Inherited all-language CI runs 34720675608 and 34720677627 were cancelled because they do not test experiments/swift; dedicated checks above all ran.

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
