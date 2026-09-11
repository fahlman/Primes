# Optimizations from other Primes submissions

Reviewed September 11, 2026, against repository commit `22bfea9c7122c46dcda799020fccf5ae83fe667f`.

The best next experiments are **fusing the eight marking streams** and **specializing dense marking for small factors**. Both have source-level precedents in submissions classified `algorithm=base,faithful=yes`. Neither has been implemented or benchmarked in our Swift version during this review.

## Scope and comparison target

The review inspected selected implementations in Rust, C#, C++, Zig, Nim, Chapel, Julia, C, and Go. It focused on optimized marking paths and their classification, rather than attempting to audit every submission in the repository.

Our current Swift implementation uses a fresh class and dynamically allocated byte buffer for each pass. It stores one bit per odd candidate, discovers factors at runtime, and starts marking at p². Each factor has eight fixed-mask streams, each with a four-store unrolled loop. At a limit of 1,000,000, its flag buffer is 62,500 bytes.

The target remains a single-threaded `base,faithful=yes` implementation, timing allocation, initialization, sieving, and release. Faster prime-array construction would not improve that benchmark.

## 1. Fuse the eight streams — first experiment

Currently, Swift finishes one fixed-mask traversal before starting the next. Chapel, Rust, and Zig instead process eight consecutive odd multiples together, then advance the shared byte position by the factor. The individual writes are grouped in increasing address order. This changes traversal order, beyond the unrolling we already perform.

For Swift, compute eight relative byte offsets once per factor, perform eight individual bit updates per iteration, and advance the common base by p bytes. With our bit numbering and p² start, only four mask configurations are needed, selected by `p & 7`. That permits a small switch with literal masks while retaining runtime offsets and factor discovery. Chapel explicitly implements this pattern, although its general dispatch table includes additional unused cases. [Chapel marking loop](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeChapel/solution_1/primes.chpl#L43-L110), [Rust sparse marking](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeRust/solution_1/prime-sieve-rust/src/unrolled.rs#L242-L293)

The expected advantages are fewer separate traversals and better locality between nearby marks. The risk is increased register pressure from keeping multiple offsets live. It could be slower on the M4; this is a candidate, not a measured improvement. Preserve a bounded tail after the final complete eight-write group.

**Why first:** it retains our existing storage and single-bit operations, making the change small enough to evaluate independently.

## 2. Specialize dense marking — larger potential improvement

Small factors put several composite marks in each storage word. Rust, Nim, Julia, and Zig exploit that density: load a word, apply each single-bit operation to a local variable, and store the completed word once. Generated functions make offsets and single-bit masks compile-time constants. [Rust load/mark/store generator](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeRust/solution_1/helper-macros/src/lib.rs#L229-L250), [Nim generator](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeNim/solution_3/Primes.nim#L128-L157), [Julia generator](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeJulia/solution_4/primes.jl#L99-L115)

In Swift, begin with byte-based specializations for factors 3, 5, and 7. These are all odd factors below eight. If useful, extend the approach to aligned UInt64 storage and a bounded set of odd factor handlers, while retaining byte marking for sparse factors. Zig uses precisely this wide-dense/byte-sparse division. [Zig dense generation](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeZig/solution_3/src/unrolled.zig#L64-L152), [Zig dispatch](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeZig/solution_3/src/sieves.zig#L346-L364)

Generate individual marking operations, rather than a precombined composite mask or presieved buffer. Dispatch only after runtime factor discovery. If extending the threshold, generating handlers for every odd value avoids relying on prior knowledge of which values are prime; Chapel explains this distinction explicitly. [Chapel design and classification discussion](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeChapel/solution_1/README.md#L92-L99)

The costs are more source and machine code, plus potentially higher instruction-cache pressure. Wider access also needs correct alignment and Swift memory binding. Adapt the algorithm rather than copying its indexing: our first stored candidate is 3, and some implementations round the starting position backward or temporarily mark the factor itself. Our version should preserve p² and use bounded initial and final fragments, including at very small limits.

## Secondary ideas

| Idea | Evidence and Swift assessment |
|---|---|
| Combine object and flag allocation | C solution 5 allocates its header and flags together. A Swift ManagedBuffer subclass could hold runtime metadata and flags in one allocation. This preserves fresh class-owned state. Likely a smaller opportunity; the optimizer may already remove some object overhead. [C allocation](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeC/solution_5/src/sieve/sieve_manager.h#L6-L28), [Swift ManagedBuffer](https://developer.apple.com/documentation/swift/managedbuffer) |
| Allocate already-zeroed memory | Zig's selected allocator uses calloc. This could replace separate allocation and initialization, but its benefit is allocator-dependent at our buffer size. Retain fresh allocation on every pass. [Zig allocator](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeZig/solution_3/src/alloc.zig#L1-L47) |
| Process cache-sized blocks | C's base implementation processes blocks while retaining the full sieve. Lower priority here: live sysctl reports 128 KiB L1 data cache for this Mac's performance cores and 64 KiB for efficiency cores, versus our roughly 61 KiB buffer. Capacity alone does not guarantee residency, but it weakens the case for adding block bookkeeping at one million. [C block traversal](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeC/solution_5/src/sieve_base.c#L30-L57) |
| Find the next factor with trailing-zero count | C# scans flag words to jump to the next unmarked bit. Potential benefit is small because factor discovery stops near 1,000. Its relationship to the literal sequential-odd-check rule is less direct, so leave this behind the two stronger candidates. [C# factor search](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeCSharp/solution_4/SieveStride8.cs#L85-L102) |

## Classification matters more than labels

C++ solution 5 is labeled base, but its dense path builds masks containing several composite bits and later applies those masks in bulk, including an ARM vector path. Under the written individual-marking requirement, I would exclude that dense technique from our current work despite its label. Its independently useful sparse traversal does not require those masks. [C++ mask construction](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeCPP/solution_5/PrimeCPP_array.cpp#L328-L347), [ARM bulk application](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeCPP/solution_5/PrimeCPP_array.cpp#L543-L559)

Likewise, C's pattern-extension algorithm explicitly uses another category. Presieving, copying composite patterns, caching buffers between passes, and parallel execution do not belong in this equal-terms experiment. [C category explanation](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/PrimeC/solution_5/README.md#L12-L31)

The two leading proposals preserve runtime discovery, individual marking, and fresh dynamically sized state. Existing submissions provide precedent, but final classification depends on the actual implementation and maintainer review. [Repository rules](https://github.com/PlummersSoftwareLLC/Primes/blob/22bfea9c7122c46dcda799020fccf5ae83fe667f/CONTRIBUTING.md#L244-L300)

Recommended order: test stream fusion by itself, then dense specialization by itself, and combine them only if measurements support both. Use the existing correctness checks and equal-terms benchmark. This review made no changes to the Swift implementation and introduced no new performance claims.
