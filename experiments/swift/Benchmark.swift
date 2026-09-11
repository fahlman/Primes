import Foundation
import BenchmarkObserver

// The sieve is allocated, initialized, calculated, observed, and released
// within every invocation. No sieve state survives into the next pass.
@inline(never)
func completedPass(limit: Int, offset: Int) -> UInt64 {
    let sieve = PrimeSieve(limit: limit)
    sieve.runSieve()
    return sieve.withStorage { observe($0, at: offset) }
}

@main
struct Benchmark {
    static func main() {
        let limit = 1_000_000
        let byteCount = ((limit - 1) / 2 + 7) / 8

        // Validation is outside the timed section.
        let check = PrimeSieve(limit: limit)
        check.runSieve()
        precondition(check.primes().count == 78_498)

        var passes = 0
        var checksum: UInt64 = 0
        let start = DispatchTime.now().uptimeNanoseconds
        var elapsed: UInt64
        repeat {
            checksum &+= completedPass(limit: limit, offset: passes % byteCount)
            passes += 1
            elapsed = DispatchTime.now().uptimeNanoseconds - start
        } while elapsed < 5_000_000_000

        let seconds = Double(elapsed) / 1_000_000_000
        // stdout uses the repository's required result format.
        print("fahlman_swift_dense_striped;\(passes);\(seconds);1;algorithm=base,faithful=yes,bits=1")
        FileHandle.standardError.write(Data("Validated: 78498 primes; checksum: \(checksum)\n".utf8))
    }
}
