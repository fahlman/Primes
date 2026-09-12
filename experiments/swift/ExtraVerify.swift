// Extra correctness checks for PrimeSieve, complementing Verify.swift. Compares complete
// prime lists with one reference sieve at every limit from 2,049 to 20,000, at 500 seeded
// random limits from 2,049 to 2,000,000, and at every limit within 3 of a prime square up
// to 2,000,000. Run from experiments/swift:
//
//   mkdir -p .build
//   swiftc -O -sanitize=address PrimeSieve.swift ExtraVerify.swift -o .build/extra-verify-asan
//   .build/extra-verify-asan

struct SplitMix64 {
    var state: UInt64
    mutating func next() -> UInt64 {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }
}

@main
struct ExtraVerify {
    static func main() {
        let maxLimit = 2_000_000
        var composite = [Bool](repeating: false, count: maxLimit + 1)
        var p = 2
        while p * p <= maxLimit {
            if !composite[p] {
                for m in stride(from: p * p, through: maxLimit, by: p) { composite[m] = true }
            }
            p += 1
        }
        let allPrimes = (2...maxLimit).filter { !composite[$0] }

        func expected(_ limit: Int) -> ArraySlice<Int> {
            var lo = 0, hi = allPrimes.count
            while lo < hi {
                let mid = (lo + hi) / 2
                if allPrimes[mid] <= limit { lo = mid + 1 } else { hi = mid }
            }
            return allPrimes[..<lo]
        }
        func check(_ limit: Int) {
            let sieve = PrimeSieve(limit: limit)
            sieve.runSieve()
            precondition(sieve.primes().elementsEqual(expected(limit)), "Incorrect primes at \(limit)")
        }

        // Every limit where dense word groups first appear, with every tail length.
        for limit in 2_049...20_000 {
            check(limit)
        }
        var rng = SplitMix64(state: 0x5EED)
        for _ in 0..<500 {
            check(2_049 + Int(rng.next() % UInt64(maxLimit - 2_049)))
        }
        var squareLimits = 0
        for q in allPrimes where q * q <= maxLimit {
            for limit in (q * q - 3)...(q * q + 3) {
                check(limit)
                squareLimits += 1
            }
        }
        print("Passed: every limit in 2,049...20,000, 500 random limits in 2,049...2,000,000, and \(squareLimits) limits within 3 of every prime square up to 2,000,000.")
    }
}
