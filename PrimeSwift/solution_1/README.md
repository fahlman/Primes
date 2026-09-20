# Swift solutions by j-f1, yellowcub, and fahlman

![Algorithm](https://img.shields.io/badge/Algorithm-base-green)
![Faithfulness](https://img.shields.io/badge/Faithful-yes-green)
![Parallelism](https://img.shields.io/badge/Parallel-no-green)
![Parallelism](https://img.shields.io/badge/Parallel-yes-green)
![Bit count](https://img.shields.io/badge/Bits-1-green)
![Bit count](https://img.shields.io/badge/Bits-8-yellowgreen)

This is a collection of three sieve implementations in Swift:

1. **8-bit Bool** (`PrimeSwift_8bitBool`) stores one Boolean per odd candidate in a
   buffer. Sieving clears each composite flag from the factor's square.
2. **Packed UInt8** (`PrimeSwift_1bit_u8`) stores eight odd candidates per byte.
   Sieving clears individual bits using a table of the eight single-bit masks.
3. **Striped UInt8** (`PrimeSwift_1bitStriped_u8`) stores eight odd candidates per
   byte, using generated handlers for small factors and sixteen marks per loop
   iteration for larger factors. Each source operation marks one composite.

All three discover factors at runtime and allocate a fresh sieve for each pass.

Credits:

1. j-f1 — original implementation and code arrangement.
2. yellowcub — performance improvements and one-bit implementations.
3. fahlman — dense and sparse marking improvements, with assistance from Claude
   and Codex.

Ideas for striped marking come from mike-barber's [Rust](../../PrimeRust/solution_1),
GordonBGood's [Nim](../../PrimeNim/solution_3), [Julia](../../PrimeJulia/solution_4)
and [Chapel](../../PrimeChapel/solution_1), and ManDeJan, ityonemo and SpexGuy's
[Zig](../../PrimeZig/solution_3) entries.
fahlman's contributions are licensed under BSD-3-Clause.

## Run instructions

With Swift 6.3.3, build and run from this folder:

```sh
swift build -c release -Xswiftc -O -Xswiftc -whole-module-optimization --package-path PrimeSwift_1bit_u8
swift build -c release -Xswiftc -O -Xswiftc -whole-module-optimization --package-path PrimeSwift_1bitStriped_u8
swift build -c release -Xswiftc -O -Xswiftc -whole-module-optimization --package-path PrimeSwift_8bitBool
./run.sh
```

`run.sh` runs the implementations sequentially. Each run defaults to at least five
seconds with a limit of 1,000,000. Use an executable's `--help` for its options.

The striped executable also supports `--threads N` (`0` selects all active
processors). Each worker runs independent sieves. `run.sh` follows the
single-threaded run with 4 threads when available, then half-machine and
full-machine counts when greater than 4.

Or use Docker:

```sh
docker build -t prime-swift .
docker run --rm prime-swift
```

The x86-64 Docker image targets Haswell and requires a compatible CPU. The arm64
build uses the default target.

For striped source changes, edit the [template](PrimeSwift_1bitStriped_u8/Tools/PrimeSieve.swift.in)
and [generator](PrimeSwift_1bitStriped_u8/Tools/generate-dense.swift), whose usage
comments document `--write` (regenerate the whole file) and `--check` (verify it).
Builds compile the committed generated source. [Verify.swift](PrimeSwift_1bitStriped_u8/Tools/Verify.swift)
contains the correctness-check commands.

## Output

Example benchmark records from `./run.sh` on an Apple M4 Pro
(macOS 26.6.2, Swift 6.3.3, 14 active processors):

```text
yellowcub_1bit_UInt8;14909;5.0002559423446655;1;algorithm=base,faithful=yes,bits=1
yellowcub_fahlman_striped_UInt8;134395;5.000032708;1;algorithm=base,faithful=yes,bits=1
yellowcub_fahlman_striped_UInt8_threaded;500783;5.000035792;4;algorithm=base,faithful=yes,bits=1
yellowcub_fahlman_striped_UInt8_threaded;839613;5.000039125;7;algorithm=base,faithful=yes,bits=1
yellowcub_fahlman_striped_UInt8_threaded;1329486;5.000046167;14;algorithm=base,faithful=yes,bits=1
j-f1_yellowcub_bool;16720;5.000118970870972;1;algorithm=base,faithful=yes,bits=8
```
