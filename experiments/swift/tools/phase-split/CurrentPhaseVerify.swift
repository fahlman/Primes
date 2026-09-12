// Verify freshly derived current diagnostics against an independent Boolean sieve.
// Full raw flags also agree with production and the preserved 8f108f5 reference.
import Foundation

// PhaseSieve.swift remains byte-for-byte the historical 8f108f5 implementation.
typealias HistoricalPhaseSieve8f108f5 = PhaseSieve

func reference(limit: Int, throughFactor cap: Int) -> [Bool] {
    var composite = [Bool](repeating: false, count: limit + 1)
    var p = 3
    while p <= limit / p && p <= cap {
        if !composite[p] {
            var multiple = p * p
            while multiple <= limit {
                composite[multiple] = true
                multiple += 2 * p
            }
        }
        p += 2
    }
    return composite
}

@main
struct CurrentPhaseVerify {
    static func main() throws {
        try CurrentPhaseBuild.identity.check()
        var limits = Set(0...1_024)
        // Both sides of squares and each dense case's first two full groups
        // (including 59's second group at limit 20,353).
        for p in stride(from: 3, through: 63, by: 2) {
            var aligned = (p * p - 3) / 2
            while aligned & 63 != 0 { aligned += p }
            for boundary in [p * p, 2 * aligned + 1,
                             2 * (aligned + 64 * p) + 1, 2 * (aligned + 128 * p) + 1] {
                for offset in -2...2 { limits.insert(max(0, boundary + offset)) }
            }
        }
        // Exercise derived 128-bit handlers and their sparse fallback around
        // alignment and first/second group edges, including the 111/113 transition.
        // Include the earlier byte-rounded boundary, which exercises padding.
        for p in stride(from: 65, through: 127, by: 2) {
            var aligned = (p * p - 3) / 2
            while aligned & 127 != 0 { aligned += p }
            for boundary in [p * p, 2 * aligned + 3,
                             2 * (aligned + 128 * p) - 13,
                             2 * (aligned + 128 * p) + 1,
                             2 * (aligned + 256 * p) - 13,
                             2 * (aligned + 256 * p) + 1] {
                for offset in -2...2 { limits.insert(boundary + offset) }
            }
        }
        limits.formUnion([4_488, 4_489, 4_490, 994_008, 994_009, 994_010,
                          999_999, 1_000_000, 1_000_001, 2_000_000])
        // Both sides of the dense cutoff 111 and first sparse prime 113,
        // plus sparse band edges 251, 257, 499 and 503.
        for square in [12_321, 12_769, 63_001, 66_049, 249_001, 253_009] {
            for offset in -2...2 { limits.insert(square + offset) }
        }
        var state: UInt64 = 0x5EED_0063
        for _ in 0..<100 {
            state = state &* 6_364_136_223_846_793_005 &+ 1
            limits.insert(Int(state % 100_001))
        }
        var checks = 0
        for limit in limits.sorted() {
            let oddCount = limit >= 3 ? (limit - 1) / 2 : 0
            let byteCount = (oddCount + 7) / 8
            // Odd, even and composite cutoffs around all dispatch transitions
            // and around the sparse band edges 251/257 and 499/503.
            for cap in [1, 2, 3, 4, 62, 63, 64, 65, 66, 67,
                        109, 110, 111, 112, 113, 114,
                        250, 251, 252, 253, 256, 257, 498, 499, 500, 501, 502, 503, Int.max] {
                let sieve = CurrentPhaseSieve(limit: limit)
                sieve.runSieve(throughFactor: cap)
                let expected = reference(limit: limit, throughFactor: cap)
                sieve.withStorage { storage in
                    precondition((storage == nil) == (byteCount == 0))
                    for bit in 0..<oddCount {
                        let value = storage!.load(fromByteOffset: bit >> 3, as: UInt8.self)
                        precondition((value & (UInt8(1) << (bit & 7)) != 0) == expected[2 * bit + 3],
                                     "Flag mismatch at limit \(limit), cap \(cap), bit \(bit)")
                    }
                }
                if cap == Int.max {
                    let production = PrimeSieve(limit: limit)
                    production.runSieve()
                    let historical = HistoricalPhaseSieve8f108f5(limit: limit)
                    historical.runSieve(throughFactor: .max)
                    if byteCount > 0 {
                        production.withStorage { expected in
                            sieve.withStorage { actual in
                                precondition(memcmp(expected!, actual!, byteCount) == 0,
                                             "Derived/production mismatch at limit \(limit)")
                            }
                        }
                        historical.withStorage { expected in
                            sieve.withStorage { actual in
                                precondition(memcmp(expected!, actual!, byteCount) == 0,
                                             "Derived/historical mismatch at limit \(limit)")
                            }
                        }
                    }
                    if limit == 1_000_000 { precondition(production.primes().count == 78_498) }
                }
                checks += 1
            }
            let allocated = CurrentPhaseSieve(limit: limit)
            allocated.withStorage { storage in
                for byte in 0..<byteCount {
                    precondition(storage!.load(fromByteOffset: byte, as: UInt8.self) == 0)
                }
            }
        }
        try CurrentPhaseBuild.identity.check()
        print("Passed \(checks) partial/full flag checks over \(limits.count) limits; allocation zeroing; production/historical full raw-buffer equality; 78,498 primes at 1,000,000.")
    }
}
