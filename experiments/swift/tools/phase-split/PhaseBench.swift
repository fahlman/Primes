// Times each stage of a pass for reports/IndependentReview.md, with the same
// allocation-to-release boundary and opaque observer as Benchmark.swift. Five workloads
// rotate across three rounds of two seconds each, and medians are printed. Stage costs
// are differences between cumulative workloads. Build and run from experiments/swift:
//
//   mkdir -p .build
//   swiftc -O -parse-as-library -module-name BenchmarkObserver -emit-module \
//     -emit-module-path .build/BenchmarkObserver.swiftmodule \
//     -emit-object BenchmarkObserver.swift -o .build/BenchmarkObserver.o
//   swiftc -O -whole-module-optimization -I .build PrimeSieve.swift \
//     tools/phase-split/PhaseSieve.swift tools/phase-split/PhaseBench.swift \
//     .build/BenchmarkObserver.o -o .build/phase-split
//   .build/phase-split
import Dispatch
import Foundation
import BenchmarkObserver

@inline(never)
func fullPass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = PrimeSieve(limit: limit)
    sieve.runSieve()
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func densePass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = PhaseSieve(limit: limit)
    sieve.runDensePhase()
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func copiedFullPass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = PhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: .max)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func through63Pass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = PhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: 63)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func allocationPass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = PrimeSieve(limit: limit)
    return sieve.withStorage { observe($0, at: offset) }
}

func microsecondsPerPass(_ pass: (Int, Int) -> UInt64, seconds: UInt64) -> (Double, UInt64) {
    let limit = 1_000_000
    let byteCount = ((limit - 1) / 2 + 7) / 8
    var passes = 0
    var checksum: UInt64 = 0
    let start = DispatchTime.now().uptimeNanoseconds
    var elapsed: UInt64
    repeat {
        checksum &+= pass(limit, passes % byteCount)
        passes += 1
        elapsed = DispatchTime.now().uptimeNanoseconds - start
    } while elapsed < seconds * 1_000_000_000
    return (Double(elapsed) / 1_000 / Double(passes), checksum)
}

@main
struct PhaseBench {
    static func main() {
        let modes: [(String, (Int, Int) -> UInt64)] = [
            ("full pass", fullPass),
            ("copied full loop (control)", copiedFullPass),
            ("allocation, factors <= 63", through63Pass),
            ("allocation, 3/5/7, release", densePass),
            ("allocation and release only", allocationPass),
        ]
        var samples: [String: [Double]] = [:]
        for round in 0..<3 {
            for index in modes.indices {
                let (name, pass) = modes[(index + round) % modes.count]
                let (microseconds, checksum) = microsecondsPerPass(pass, seconds: 2)
                samples[name, default: []].append(microseconds)
                FileHandle.standardError.write(Data("round \(round + 1) \(name): \(microseconds) us (checksum \(checksum))\n".utf8))
            }
        }
        for (name, _) in modes {
            let sorted = samples[name]!.sorted()
            print(name.padding(toLength: 30, withPad: " ", startingAt: 0)
                  + String(format: "median %7.2f us/pass   (min %.2f, max %.2f)", sorted[1], sorted[0], sorted[2]))
        }
    }
}
