# Equal-terms Swift sieve comparison

This records the original baseline at `25402d4`. See [OptimizationResults.md](OptimizationResults.md) for subsequent experiments.

The target is achieved on this Mac: the unrolled implementation beats all three repository Swift versions while retaining `base,faithful=yes`, single-threaded operation.

| Implementation | Median milliseconds per pass | Our throughput advantage |
|---|---:|---:|
| Repository: Boolean | 0.292488 | 2.43× |
| Repository: packed UInt8 | 0.351134 | 2.91× |
| Repository: striped UInt8 | 0.208603 | 1.73× |
| Our unrolled Swift | 0.120461 | — |

All times measure fresh allocation, initialization, sieving, observation, and release, through one million. Prime-list generation is outside the timed section. All four use the same Swift 6.3.3 optimization flags, opaque Swift observer, and five-second runner on Apple M4 Pro. Each was run three times in rotated order. All twelve executions validated 78,498 primes and exited successfully.

The retained implementation is the previously verified unrolled class. The proposed direct-array and cached-per-instance square-root changes did not demonstrate a reliable sieve-kernel improvement, so they were not adopted. Wheel and other submission categories remain deferred.

Raw samples, the reproducible comparison script, source, and methodology are included in the [parent experiment directory](https://github.com/fahlman/Primes/tree/dc3f8cfbbb9d2df7b3e42fbba55d11366933ccee/experiments/swift). The Dockerfile is included but Docker execution has not been tested on this machine.
