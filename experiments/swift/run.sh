#!/bin/sh
set -eu
cd "$(dirname "$0")"
mkdir -p .build
swiftc -O -parse-as-library -module-name BenchmarkObserver \
  -emit-module -emit-module-path .build/BenchmarkObserver.swiftmodule \
  -emit-object BenchmarkObserver.swift -o .build/BenchmarkObserver.o
swiftc -O -whole-module-optimization -I .build \
  PrimeSieve.swift Benchmark.swift .build/BenchmarkObserver.o \
  -o .build/PrimeSwift
exec .build/PrimeSwift
