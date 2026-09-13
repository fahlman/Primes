#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
swift_package=../../PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8
if [ "$#" -ne 1 ]; then
    echo "Usage: sh phase-split/build-current.sh NEW_BUILD_DIRECTORY (from fork/swift)" >&2
    exit 2
fi
if [ ! -f /tmp/primes-timing.lock ]; then
    echo "Acquire and own /tmp/primes-timing.lock before building; see ../../AGENTS.md." >&2
    exit 2
fi
# Presence is a guard, not proof of ownership; the calling agent must own the lock.
mkdir "$1"
phase_build_dir=$(cd "$1" && pwd)
swiftc -O phase-split/PhaseSourceGuard.swift \
    phase-split/GenerateCurrentPhaseSieve.swift -o "$phase_build_dir/generate-current-phase"
"$phase_build_dir/generate-current-phase" --source "$swift_package/Sources/PrimeSieveSwift/PrimeSieve.swift" --output "$phase_build_dir/inputs"
swiftc -O -parse-as-library -module-name BenchmarkObserver -emit-module \
    -emit-module-path "$phase_build_dir/BenchmarkObserver.swiftmodule" \
    -emit-object "$swift_package/Sources/BenchmarkObserver/BenchmarkObserver.swift" -o "$phase_build_dir/BenchmarkObserver.o"
swiftc -O -whole-module-optimization -I "$phase_build_dir" "$swift_package/Sources/PrimeSieveSwift/PrimeSieve.swift" \
    "$phase_build_dir/inputs/CurrentPhaseSieve.swift" \
    "$phase_build_dir/inputs/CurrentPhaseIdentity.swift" \
    phase-split/PhaseSourceGuard.swift phase-split/PhaseBench.swift \
    "$phase_build_dir/BenchmarkObserver.o" -o "$phase_build_dir/phase-current"
printf 'Built %s/phase-current; no diagnostic workloads have been run.\n' "$phase_build_dir"
