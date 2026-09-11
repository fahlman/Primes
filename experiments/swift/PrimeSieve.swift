/// An odd-only Eratosthenes sieve with byte-striped composite marking.
/// Every instance owns a freshly allocated sieve; no sieve state is cached.
final class PrimeSieve {
    private let limit: Int
    private let oddCount: Int
    private let byteCount: Int
    private let storage: UnsafeMutablePointer<UInt8>

    init(limit: Int) {
        self.limit = limit
        oddCount = limit >= 3 ? (limit - 1) / 2 : 0
        byteCount = oddCount / 8 + (oddCount % 8 == 0 ? 0 : 1)
        storage = .allocate(capacity: max(1, byteCount))
        storage.initialize(repeating: 0, count: byteCount)
    }

    deinit {
        storage.deinitialize(count: byteCount)
        storage.deallocate()
    }

    func runSieve() {
        let bytes = storage
        let end = byteCount
        var p = 3

        while p <= limit / p {
            let candidate = (p - 3) / 2
            if bytes[candidate >> 3] & (UInt8(1) << (candidate & 7)) == 0 {
                // Consecutive odd multiples differ by p bit positions. Eight
                // interleaved streams each keep a fixed mask and advance p bytes.
                var start = (p * p - 3) / 2
                let p2 = p + p
                let p3 = p2 + p
                let p4 = p3 + p
                let unrolledEnd = end - p3

                for _ in 0..<8 {
                    let mask = UInt8(1) << (start & 7)
                    var byte = start >> 3

                    while byte < unrolledEnd {
                        bytes[byte] |= mask
                        bytes[byte + p] |= mask
                        bytes[byte + p2] |= mask
                        bytes[byte + p3] |= mask
                        byte += p4
                    }
                    while byte < end {
                        bytes[byte] |= mask
                        byte += p
                    }
                    start += p
                }
            }
            p += 2
        }
    }

    func primes() -> [Int] {
        guard limit >= 2 else { return [] }
        var result = [2]
        for byte in 0..<byteCount {
            var candidates = ~storage[byte]
            if byte == byteCount - 1, oddCount & 7 != 0 {
                candidates &= (UInt8(1) << (oddCount & 7)) - 1
            }
            while candidates != 0 {
                let index = byte * 8 + candidates.trailingZeroBitCount
                result.append(index * 2 + 3)
                candidates &= candidates - 1
            }
        }
        return result
    }

    func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
        body(byteCount == 0 ? nil : UnsafeRawPointer(storage))
    }
}
