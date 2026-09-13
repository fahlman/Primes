#!/bin/sh

set -eu
cd "$(dirname "$0")"

./PrimeSwift_1bit_u8/.build/release/PrimeSieveSwift

# The striped entry: single-threaded, then 4 threads, half the processors and all
# of them, each count once, the way the Rust entry reports its threaded runs.
striped=./PrimeSwift_1bitStriped_u8/.build/release/PrimeSieveSwift
cores=$(getconf _NPROCESSORS_ONLN)
half=$((cores / 2))
"$striped"
if [ "$cores" -ge 4 ]; then "$striped" --threads 4; fi
if [ "$half" -gt 4 ]; then "$striped" --threads "$half"; fi
if [ "$cores" -gt 4 ] && [ "$cores" -ne "$half" ]; then "$striped" --threads "$cores"; fi

./PrimeSwift_8bitBool/.build/release/PrimeSieveSwift
