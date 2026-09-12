# Sparse-stream experiment 8: independent review and timing

**Recommend B (`8f108f5`), the fused sparse loops.** It measured **40.806 µs/pass**, saving **2.453 µs** against development `4483965`: **6.01% more throughput** and **5.67% less time per sieve**. It also beat A by **4.27% throughput**, saving **1.743 µs/pass**. Every B trial was faster than every A and development trial, so the agreed tie-breaker in favor of A is not needed.

Both source reviews and all required correctness checks passed. A also improved over development in this session, but by less. These are measurements on Apple M4 Pro / Swift 6.3.3; the exact gains are provisional under desktop activity. **Neither candidate has been merged by this review.**

## Compared revisions and timings

Both A and B were reviewed against development, even though B's commit follows A and replaces its sparse-loop implementation.

| Variant | Exact commit | Trial 1 µs | Trial 2 µs | Trial 3 µs | Median µs | Throughput vs development |
|---|---|---:|---:|---:|---:|---:|
| development | [`4483965`](https://github.com/fahlman/Primes/commit/4483965cedbf9cbe293caa84201474e92d5b2c6d) | 43.192 | 43.259 | 43.274 | **43.259** | +0.00% |
| a-eight-writes | [`47b4af1`](https://github.com/fahlman/Primes/commit/47b4af1cfbce8761585ee379ba4baabd58445a56) | 42.519 | 42.552 | 42.549 | **42.549** | +1.67% |
| b-fused | [`8f108f5`](https://github.com/fahlman/Primes/commit/8f108f5dfe48d3c79bbe06d147a4097039635dc4) | 40.761 | 40.809 | 40.806 | **40.806** | +6.01% |

A saves **0.711 µs/pass**, with **1.67% more throughput**. B's slowest trial was still **4.19% higher throughput than A's fastest** and **5.84% higher than development's fastest**. The nine trial ranges do not overlap between any pair of variants. Median throughputs are approximately 23,116, 23,503 and 24,506 passes/s for development, A and B, respectively.

The current development revision is an optimization control, not the upstream baseline. No upstream implementation was timed here, and no ratios from historical sessions are combined.

## Source review

Codex reviewed the exact commits, supported by separate independent Codex subagent reviews of A and B. The [review was posted on PR #11 before timing](https://github.com/fahlman/Primes/pull/11#issuecomment-5644491291).

**A — eight writes per fixed-mask stream.** `byte < end-7*p` proves all eight writes stay inside storage. Advancing by `8*p` leaves the next index below `end+p`, preserving the wrapping bound. The scalar tail resumes at the next untouched stream position. All eight streams retain the original bit coverage and padding behavior.

**B — fused streams above 63.** For every odd residue mod 8, the literal single-bit masks match `1 << ((start+j*p)&7)`, j=0…7. Group g writes exactly the multiples at `start+(8*g+j)*p`; advancing the base by p bytes preserves the phase. The `end-r7` group bound protects the largest address. The scalar tail resumes at the next multiple, performs at most seven writes below `end*8`, and preserves the original streams' final-byte padding marks. The existing runtime square-root guard makes p² safe; the offset and wrapping-index arithmetic remains representable.

Both leave sequential runtime odd-factor discovery, p² starts, dense handlers, allocation, enumeration, benchmark and observer unchanged. Each source write marks one bit; B's four residue cases cover all odd values and encode no primality knowledge. Fresh class-owned storage and one thread remain. **No source blocker was found for `algorithm=base,faithful=yes,bits=1`.** This is a source-classification argument, not a guarantee of upstream acceptance.

A nonblocking PR-description count was corrected: B now makes **515 tail writes**, **26,298 source loop-condition evaluations** and **204,379 total sparse writes** at one million. The extra tail mark is padding number 1,000,001, from factor 101. The earlier 514/26,297 figures described the tail that stopped before padding. No source change was needed.

## Executed verification and assembly

For **each** exact candidate, Codex ran:

- `Verify.swift` with `-O -sanitize=address` and `-O -whole-module-optimization`: complete prime arrays at every limit −2…2,048, larger square boundaries, one million and ten million.
- `ExtraVerify.swift` with ASAN: every limit 2,049…30,000, 500 deterministic random limits up to two million, and 1,561 cases near prime squares.
- The unchanged `PhaseVerify.swift` with ASAN and WMO: **16,511 partial/full flag checks over 1,501 limits**, allocation zeroing, exact full-buffer identity to the adopted `19aa38a` diagnostic copy including padding, and 78,498 primes at one million.

Every compiler and verification command exited zero. Command lines, source hashes, outputs and statuses are in the shared verification JSON. The development source was unchanged and served as the timing/assembly control; its historical correctness suite was not rerun redundantly.

| Code-generation evidence | Development | A | B |
|---|---:|---:|---:|
| runSieve instructions | 246 | 276 | 566 |
| Sparse writes per inner iteration | 4 | 8 | 8 |
| Instructions per inner iteration | 16 | 34 | 27 per residue loop |
| Branches per inner iteration | 2 | 1 | 1 |
| Dense-word helper instructions | 2,530 | 2,530 | 2,530 |

A uses seven explicit address additions per iteration: one initial base/index addition and six chained additions of p; its last access uses indexed addressing. B has four specialized sparse loops, each with eight `ldrb`/`orr`/`strb` triples using prepared base registers and immediate single-bit masks, plus index advance, comparison and branch. No sparse inner loop accesses the stack.

The dense-word helper bodies are byte-identical as assembly text across the three inspection builds (SHA-256 `3b2481b4ebc73d612947b89f9b6e4915cb3436db142516cbdc6dc6924ef0367d`). Every completed-pass path retains a real separately compiled observer call followed by release. No `@inline(never)` directive was added to a dense handler.

These facts support the interpretation but do not isolate the cause of the gains. A improves despite having more instructions per write; loop shape, address generation, register use and memory order matter together. No explicit-base-pointer A variant, outlining experiment, or additional timing bracket was added.

## Timing protocol and conditions

One exclusive `/tmp/primes-timing.lock` hold covered **2026-09-12 07:35:32–07:38:38 UTC**, including compilation. First the PR #10 diagnostic ran 21 five-second trials; then `compare_optimizations.py` compiled all three variants and ran nine serial five-second trials. Each invocation used a unique `--output`. The lock was removed in `finally`.

The optimization comparison began at 07:37:31 UTC, including compilation. It used the frozen runner and separately compiled observer from **`25402d46ba991b39451724d3873d326626981e3f`**, unchanged except each candidate's printed label. All sieve builds used `-O -whole-module-optimization`; the separate observer used `-O`. Allocation, initialization, sieve work, opaque observation and release were timed; validation, enumeration and printing were excluded.

Run order: (1) development, A, B; (2) A, B, development; (3) B, development, A. All nine runs lasted at least five seconds, exited zero, validated 78,498 primes and reported one thread with `algorithm=base,faithful=yes,bits=1`. Hardware was Apple M4 Pro, macOS 26.6.2 (25G83), Apple Swift 6.3.3 (`swiftlang-6.3.3.1.3`, `clang-2100.1.1.101`), arm64.

No competing build/test/benchmark process or audio assertion appeared in snapshots before/after the measured sections. Desktop activity remained: before the comparison, WindowServer was 10.3% CPU and Codex Renderer 2.9%; afterward 10.9% and 6.8%, with an indexing worker at 9.2%. These are snapshots rather than continuous monitoring or benchmark averages. This is one rotated session, not evidence for Threadripper/Linux performance or a guaranteed future percentage.

## Related band diagnostic and integration

The [band report](SparseBandBreakdown.md) measures development, not B: approximately **18.777 µs** for factors 67–251, **7.156 µs** for 257–499 and **3.518 µs** for 503–997. Normalized costs per source write are close (0.142/0.147/0.150 ns), and cumulative subtraction/noise limits fine interpretation. A per-mark/per-stream fit cannot predict this A/B result: stream count is confounded with factor count, and both A and development have the same mark/stream counts despite different loop control.

B is recommended for integration on the measured machine. PR #11 remains unmerged pending the user's integration decision. The old phase copy still represents `19aa38a`; after adopting a different sparse loop, refresh and re-review it before using it to profile that implementation. Identical output bits do not establish timing-code fidelity.

## Evidence

- [Raw optimization samples](../sparse-stream-results-8f108f5.json)
- [Shared verification, source hashes, assembly excerpts, calculations and session record](../sparse-stream-verification-8f108f5.json)
- [PR #11](https://github.com/fahlman/Primes/pull/11)
