# Primes — Repository Instructions

Only upstream's requirements for Ryan's entry in `PrimeSwift/solution_1` are listed here. Everything else follows the shared `AGENTS.md`.

## Toolchain

- The entry builds and runs in Docker on Linux, because upstream's
  `CONTRIBUTING.md` requires a `Dockerfile` for every solution.

## Sieve rules

Read the Rules, Base algorithm, and Faithfulness sections of `CONTRIBUTING.md` at the repository root.

- Discover factors at run time by checking odd candidates in order, starting at 3. Stopping at √limit, starting at p², and inverted flags are allowed.
- Mark every composite with its own operation in the source.
- Every pass creates a fresh sieve instance that owns the complete state and a buffer allocated at run time and sized to the limit. Nothing survives into the next pass. The sieve uses no external dependencies.
- The completed flags are the result. A count or checksum alone is not.
- Output tags must match the code: `algorithm=base,faithful=yes,bits=1` and the thread count actually used. READMEs must describe what the code does.
- No sieve or benchmark logic lives outside Swift.

## Benchmark contract

- Limit 1,000,000, at least 5 seconds per run, 78,498 primes expected.
