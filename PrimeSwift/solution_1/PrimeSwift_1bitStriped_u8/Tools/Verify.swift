@main
struct Verify {
    static func verifyStorageLayout() {
        // Explicit logical counts cover empty storage and both sides of byte
        // boundaries. The final case also checks the benchmark's observer range.
        let cases: [(limit: Int, odds: Int, bytes: Int)] = [
            (-2, 0, 0), (-1, 0, 0), (0, 0, 0), (1, 0, 0), (2, 0, 0),
            (3, 1, 1), (4, 1, 1), (5, 2, 1),
            (16, 7, 1), (17, 8, 1), (18, 8, 1), (19, 9, 2), (20, 9, 2),
            (31, 15, 2), (32, 15, 2), (33, 16, 2), (34, 16, 2),
            (35, 17, 3), (36, 17, 3),
            (255, 127, 16), (256, 127, 16), (257, 128, 16), (258, 128, 16),
            (259, 129, 17), (1_000_000, 499_999, 62_500),
        ]
        for test in cases {
            let layout = PrimeSieve.storageLayout(for: test.limit)
            precondition(layout.oddCount == test.odds && layout.byteCount == test.bytes,
                         "Incorrect storage layout at \(test.limit)")
            let sieve = PrimeSieve(limit: test.limit)
            sieve.withStorage { pointer in
                precondition((pointer == nil) == (test.bytes == 0))
                for byte in 0..<test.bytes {
                    precondition(pointer!.load(fromByteOffset: byte, as: UInt8.self) == 0)
                }
            }
        }
        // Extreme limits exercise arithmetic only, never enormous allocations.
        let empty = PrimeSieve.storageLayout(for: Int.min)
        precondition(empty.oddCount == 0 && empty.byteCount == 0)
        let largest = PrimeSieve.storageLayout(for: Int.max)
        precondition(largest.oddCount == Int.max / 2 && largest.byteCount == Int.max / 16 + 1)
        print("Passed: 25 storage layout/zeroing cases and Int.min/Int.max layout arithmetic.")
    }

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
        verifyStorageLayout()
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
