// Focused coverage for arbitrary 128-bit chunk exits. Existing verifiers remain
// unchanged. Compile with PrimeSieve.swift and tools/phase-split/PhaseSieve.swift;
// the historical PhaseSieve supplies the full raw-buffer reference, not timings.
import Foundation

@main
struct RecurrenceVerify {
    static func main() {
        var recurrenceChecks = 0
        var limits: Set<Int> = [1_000_000]

        func isPrime(_ value: Int) -> Bool {
            var factor = 2
            while factor <= value / factor {
                if value % factor == 0 { return false }
                factor += 1
            }
            return true
        }

        for p in stride(from: 65, through: 111, by: 2) {
            // Coprimality with 128 makes one p-chunk period visit every possible
            // first offset. Check all odd factors, including composite values.
            var first = 0
            var offsets = Set<Int>()
            for chunk in 0..<p {
                precondition(first >= 0 && first < p)
                precondition(first == (p - (128 * chunk) % p) % p)
                offsets.insert(first)
                let second = first + p
                let secondMask = UInt64(1) << (second - 64)
                if second < 128 {
                    precondition(secondMask.nonzeroBitCount == 1 &&
                                 secondMask.trailingZeroBitCount == second - 64)
                } else {
                    precondition(secondMask == 0, "Ordinary shift must zero an absent second mark")
                }
                let t = first + p - 128
                first = t < 0 ? t + p : t
                recurrenceChecks += 1
            }
            precondition(first == 0 && offsets.count == p)

            // Production discovers factors at runtime. For each active factor,
            // exercise all p possible chunk-exit residues after alignment.
            guard isPrime(p) else { continue }
            var aligned = (p * p - 3) / 2
            while aligned & 127 != 0 { aligned += p }
            for chunk in 1...p {
                let endBit = aligned + 128 * chunk
                // The complete chunk first exists at the byte-rounded limit
                // 2*endBit-13, before its final valid odd flag at 2*endBit+1.
                for boundary in [2 * endBit - 13, 2 * endBit + 1] {
                    for delta in -1...1 { limits.insert(boundary + delta) }
                }
            }
        }

        for limit in limits.sorted() {
            let production = PrimeSieve(limit: limit)
            production.runSieve()
            let reference = PhaseSieve(limit: limit)
            reference.runSieve(throughFactor: Int.max)
            let oddCount = (limit - 1) / 2
            let byteCount = (oddCount + 7) / 8
            production.withStorage { actual in
                reference.withStorage { expected in
                    precondition(memcmp(actual!, expected!, byteCount) == 0,
                                 "Recurrence raw-buffer mismatch at limit \(limit)")
                }
            }
        }
        print("Passed \(recurrenceChecks) recurrence/shift cases for every odd factor 65...111 and \(limits.count) arbitrary-chunk raw-buffer checks, including padding at 1,000,000.")
    }
}
