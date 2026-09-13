#!/bin/sh
set -eu
cd "$(dirname "$0")"
swift_package=../../PrimeSwift/solution_1/PrimeSwift_1bitStriped_u8
mkdir -p .build
swiftc -O -parse-as-library -module-name BenchmarkObserver \
  -emit-module -emit-module-path .build/BenchmarkObserver.swiftmodule \
  -emit-object "$swift_package/Sources/BenchmarkObserver/BenchmarkObserver.swift" -o .build/BenchmarkObserver.o
swiftc -O -whole-module-optimization -I .build \
  "$swift_package/Sources/PrimeSieveSwift/PrimeSieve.swift" Benchmark.swift .build/BenchmarkObserver.o \
  -o .build/PrimeSwift
exec .build/PrimeSwift
