#!/bin/bash
# Builds the checks against ../Sieve.swift and runs them.
#   ./run.sh         correctness tests, optimized build
#   ./run.sh bench   timings: the previous bit-packed version vs. Sieve.swift, on 1 thread and all cores
#   ./run.sh asan    correctness tests in a debug build with AddressSanitizer (takes a couple of minutes)
#   ./run.sh tsan    multi-core runs under ThreadSanitizer
set -euo pipefail
cd "$(dirname "$0")"
sieve_file=../Sieve.swift

mkdir -p .build
# Only main.swift may contain top-level code, so build from a copy of Sieve.swift without its demo print.
sed '/^print(/d' "$sieve_file" > .build/Sieve.swift
sources=(.build/Sieve.swift OriginalSieve.swift main.swift)

case "${1:-test}" in
    test)  swiftc -O -wmo "${sources[@]}" -o .build/release && .build/release test ;;
    bench) swiftc -O -wmo "${sources[@]}" -o .build/release && .build/release bench ;;
    asan)  swiftc -Onone -sanitize=address "${sources[@]}" -o .build/asan && .build/asan test ;;
    tsan)  swiftc -O -sanitize=thread "${sources[@]}" -o .build/tsan && .build/tsan tsan ;;
    *)     echo "usage: $0 [test|bench|asan|tsan]" >&2; exit 2 ;;
esac
