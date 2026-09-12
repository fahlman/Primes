@main
struct Verify {
    static func reference(upTo limit: Int) -> [Int] {
        guard limit >= 2 else { return [] }
        var flags = [Bool](repeating: true, count: limit + 1)
        flags[0] = false
        flags[1] = false
        var p = 2
        while p <= limit / p {
            if flags[p] {
                for index in stride(from: p * p, through: limit, by: p) {
                    flags[index] = false
                }
            }
            p += 1
        }
        return flags.indices.filter { flags[$0] }
    }

    static func main() {
        let limits = Array(-2...2048) + [
            16_128, 16_129, 16_130,
            994_008, 994_009, 994_010,
            1_000_000, 10_000_000
        ]
        for limit in limits {
            let sieve = PrimeSieve(limit: limit)
            sieve.runSieve()
            let actual = sieve.primes()
            precondition(actual == reference(upTo: limit), "Incorrect primes at \(limit)")
            // Calling the marking pass again must preserve the same result.
            sieve.runSieve()
            precondition(sieve.primes() == actual)
            if limit == 1_000_000 { precondition(actual.count == 78_498) }
            if limit == 10_000_000 { precondition(actual.count == 664_579) }
        }
        print("Passed: complete prime arrays for every limit -2...2048, larger square boundaries, 1M, and 10M.")
    }
}
