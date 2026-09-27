import Foundation
import ArgumentParser
import BenchmarkObserver

// Every timed pass allocates, initializes, calculates, observes, and releases its
// own sieve. The separate observer module keeps the completed storage observable.
@inline(never)
func completedPass(limit: Int, offset: Int) -> UInt64 {
    let sieve = PrimeSieve(limit: limit)
    sieve.runSieve()
    return sieve.withStorage { observe($0, at: offset) }
}

/// One thread's share of the benchmark: its own passes over its own sieves.
/// Workers share nothing but the limit and the running time.
/// Each worker is mutated only by the one thread that runs it, and the main thread
/// reads it only after `group.wait()`, so handing it to that thread is safe; Swift
/// cannot see that hand-off, hence `@unchecked`.
final class Worker: @unchecked Sendable {
    private(set) var passes = 0
    private(set) var checksum: UInt64 = 0
    private(set) var elapsed: UInt64 = 0

    func run(limit: Int, byteCount: Int, targetNanoseconds: UInt64) {
        let start = DispatchTime.now().uptimeNanoseconds
        repeat {
            // withStorage passes nil to the observer when the sieve has no bytes.
            let offset = byteCount == 0 ? 0 : passes % byteCount
            checksum &+= completedPass(limit: limit, offset: offset)
            passes += 1
            elapsed = DispatchTime.now().uptimeNanoseconds - start
        } while elapsed < targetNanoseconds
    }
}

struct PrimeSieveSwift: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate Primes")

    @Option(name: [.customLong("upper-limit"), .customShort("n")], help: "Compute all primes below this limit.")
    private var upperLimit = 1_000_000

    @Option(name: [.customLong("time"), .customShort("t")], help: "Minimum running time in seconds.")
    private var maxTime = 5.0

    @Option(name: [.customLong("list-results"), .customShort("l")], help: "List all computed primes.")
    private var listResults = false

    @Option(name: [.customLong("threads")], help: "Threads, each running its own sieves for the full time; 0 selects the active processor count.")
    private var threads = 1

    func validate() throws {
        guard upperLimit >= 0 else {
            throw ValidationError("The upper limit must be nonnegative.")
        }
        guard threads >= 0 else {
            throw ValidationError("The thread count must be nonnegative; 0 selects the active processor count.")
        }
        _ = try validatedNanoseconds(for: maxTime)
    }

    func run() throws {
        let limit = upperLimit
        let byteCount = PrimeSieve.storageLayout(for: limit).byteCount
        let targetNanoseconds = try validatedNanoseconds(for: maxTime)
        let threadCount = threads == 0 ? ProcessInfo.processInfo.activeProcessorCount : threads
        let workers = (0..<threadCount).map { _ in Worker() }
        if threadCount == 1 {
            workers[0].run(limit: limit, byteCount: byteCount, targetNanoseconds: targetNanoseconds)
        } else {
            // One thread per worker, each running the same loop for the same time.
            let group = DispatchGroup()
            for worker in workers {
                group.enter()
                let thread = Thread {
                    worker.run(limit: limit, byteCount: byteCount, targetNanoseconds: targetNanoseconds)
                    group.leave()
                }
                thread.start()
            }
            group.wait()
        }
        let passes = workers.reduce(0) { $0 + $1.passes }
        let checksum = workers.reduce(UInt64(0)) { $0 &+ $1.checksum }
        let duration = Double(workers.map(\.elapsed).max() ?? 0) / 1_000_000_000

        // Keep the benchmark's numeric bound unchanged. The class includes its
        // limit; the existing CLI lists and counts only primes below upperLimit.
        // Validation, enumeration, and printing are outside the timed interval.
        let check = PrimeSieve(limit: limit)
        check.runSieve()
        let inclusivePrimes = check.primes()
        // Sorted inclusive output can exceed the CLI's exclusive bound only at
        // its final element. Keep a slice instead of allocating a filtered array.
        let primes = inclusivePrimes.dropLast(inclusivePrimes.last == limit ? 1 : 0)
        let primeCounts = [
                     10:         4,
                    100:        25,
                  1_000:       168,
                 10_000:     1_229,
                100_000:     9_592,
              1_000_000:    78_498,
             10_000_000:   664_579,
            100_000_000: 5_761_455,
        ]
        let valid = primeCounts[limit].map { $0 == primes.count }
        if let valid, !valid {
            throw ValidationError("Unexpected prime count: \(primes.count) below \(limit).")
        }
        if listResults {
            FileHandle.standardError.write(Data((primes.map(String.init).joined(separator: ", ") + "\n").utf8))
        }
        let validation = valid.map { String($0) } ?? "unknown"
        let diagnostic = "Passes: \(passes), Time: \(duration), Avg: \(duration / Double(passes)), Threads: \(threadCount), Limit: \(limit), Count: \(primes.count), Valid: \(validation), Checksum: \(checksum)\n"
        FileHandle.standardError.write(Data(diagnostic.utf8))
        let label = threadCount == 1 ? "yellowcub_fahlman_striped_UInt8" : "yellowcub_fahlman_striped_UInt8_threaded"
        print("\(label);\(passes);\(duration);\(threadCount);algorithm=base,faithful=yes,bits=1")
    }
}

PrimeSieveSwift.main()
