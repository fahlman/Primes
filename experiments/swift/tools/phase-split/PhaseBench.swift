// Cumulative diagnostics derived from current production. See README.md here.
// Every workload includes fresh allocation/zeroing, opaque observation and release.
// Eight modes rotate across three rounds of five seconds; partial modes are not
// complete sieves. Subtract cumulative medians only as approximate stage costs.
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
func derivedFullPass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: .max)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func through499Pass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: 499)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func through251Pass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: 251)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func through111Pass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: 111)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func through63Pass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: 63)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func through3Pass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    sieve.runSieve(throughFactor: 3)
    return sieve.withStorage { observe($0, at: offset) }
}

@inline(never)
func allocationPass(_ limit: Int, _ offset: Int) -> UInt64 {
    let sieve = CurrentPhaseSieve(limit: limit)
    return sieve.withStorage { observe($0, at: offset) }
}

struct Sample: Encodable {
    let round: Int
    let position: Int
    let mode: String
    let passes: Int
    let elapsedNanoseconds: UInt64
    let microsecondsPerPass: Double
    let checksum: UInt64
}

struct Results: Encodable {
    let schemaVersion = 2
    let limit = 1_000_000
    let secondsPerRun = 5
    let rounds = 3
    let fullValidationPrimeCount: Int
    let fullDerivedBytesEqual: Bool
    let sourceIdentity: PhaseSourceIdentity
    let samples: [Sample]
}

func measure(_ pass: (Int, Int) -> UInt64, mode: String, round: Int, position: Int) -> Sample {
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
    } while elapsed < 5_000_000_000
    return Sample(round: round, position: position, mode: mode, passes: passes,
                  elapsedNanoseconds: elapsed,
                  microsecondsPerPass: Double(elapsed) / 1_000 / Double(passes), checksum: checksum)
}

@main
struct PhaseBench {
    static func main() throws {
        let arguments = CommandLine.arguments
        let checkOnly = arguments.count == 2 && arguments[1] == "--check"
        guard checkOnly || (arguments.count == 3 && arguments[1] == "--output") else {
            throw phaseSourceError("Usage: phase-current --check | --output UNIQUE_RESULTS.json")
        }
        let output = checkOnly ? nil : URL(fileURLWithPath: arguments[2])
        if let output = output {
            precondition(!FileManager.default.fileExists(atPath: output.path), "Refusing to overwrite results")
        }
        try CurrentPhaseBuild.identity.check()
        // Source checks, validation and enumeration are all outside timing.
        let fullCount: Int = {
            let sieve = PrimeSieve(limit: 1_000_000)
            sieve.runSieve()
            let copy = CurrentPhaseSieve(limit: 1_000_000)
            copy.runSieve(throughFactor: .max)
            let equal = sieve.withStorage { expected in
                copy.withStorage { actual in memcmp(expected!, actual!, 62_500) == 0 }
            }
            precondition(equal, "Derived full flags differ from production")
            return sieve.primes().count
        }()
        precondition(fullCount == 78_498)
        let modes: [(String, (Int, Int) -> UInt64)] = [
            ("production_full", fullPass),
            ("derived_full", derivedFullPass),
            ("through_499", through499Pass),
            ("through_251", through251Pass),
            ("through_111", through111Pass),
            ("through_63", through63Pass),
            ("through_3", through3Pass),
            ("allocation_only", allocationPass),
        ]
        if checkOnly {
            // One execution of each wrapper; this is a smoke check, not timing
            // evidence or a substitute for CurrentPhaseVerify's partial checks.
            for (name, pass) in modes {
                print("\(name): checksum \(pass(1_000_000, 62_499))")
            }
            try CurrentPhaseBuild.identity.check()
            print("Checked all eight wrappers; full raw flags agree; 78,498 primes; source identities unchanged. No timed trials run.")
            return
        }
        var samples: [Sample] = []
        for round in 0..<3 {
            for position in modes.indices {
                let (name, pass) = modes[(position + round) % modes.count]
                let sample = measure(pass, mode: name, round: round + 1, position: position + 1)
                samples.append(sample)
                FileHandle.standardError.write(Data("round \(sample.round) \(name): \(sample.microsecondsPerPass) us/pass; \(sample.passes) passes; checksum \(sample.checksum)\n".utf8))
            }
        }
        try CurrentPhaseBuild.identity.check()
        let results = Results(fullValidationPrimeCount: fullCount, fullDerivedBytesEqual: true,
                              sourceIdentity: CurrentPhaseBuild.identity, samples: samples)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        try encoder.encode(results).write(to: output!, options: .withoutOverwriting)
        for (name, _) in modes {
            let sorted = samples.filter { $0.mode == name }.map(\.microsecondsPerPass).sorted()
            print(name.padding(toLength: 20, withPad: " ", startingAt: 0)
                  + String(format: "median %8.3f us/pass (min %.3f, max %.3f)", sorted[1], sorted[0], sorted[2]))
        }
    }
}
