FROM swift:6.3.3 AS build
WORKDIR /app
COPY PrimeSieve.swift Benchmark.swift BenchmarkObserver.swift ./
RUN mkdir -p .build && \
    swiftc -O -parse-as-library -module-name BenchmarkObserver \
      -emit-module -emit-module-path .build/BenchmarkObserver.swiftmodule \
      -emit-object BenchmarkObserver.swift -o .build/BenchmarkObserver.o && \
    swiftc -O -whole-module-optimization -I .build \
      PrimeSieve.swift Benchmark.swift .build/BenchmarkObserver.o \
      -o /app/PrimeSwift
FROM swift:6.3.3-slim
WORKDIR /app
COPY --from=build /app/PrimeSwift /app/PrimeSwift
ENTRYPOINT ["/app/PrimeSwift"]
