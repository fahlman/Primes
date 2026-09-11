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
                if p < 8 {
                    markDenseMultiples(of: p)
                    p += 2
                    continue
                }
                if p < 14 {
                    markWordDenseMultiples(of: p)
                    p += 2
                    continue
                }

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

    private func markDenseMultiples(of p: Int) {
        let bytes = storage
        var bit = (p * p - 3) / 2

        // Odd p is coprime to 8, so at most seven marks reach a byte boundary.
        while bit < oddCount && bit & 7 != 0 {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
        guard bit < oddCount else { return }

        var byte = bit >> 3
        let fullBytes = oddCount >> 3

        // From a byte boundary, eight successive marks are at 0, p, ... 7p.
        // They span p bytes; the next mark starts the next p-byte group.
        // Apply each single-bit mask locally, then store each byte once.
        switch p {
        case 3:
            while byte <= fullBytes - 3 {
                var value = bytes[byte]
                value |= 0x01
                value |= 0x08
                value |= 0x40
                bytes[byte] = value

                value = bytes[byte + 1]
                value |= 0x02
                value |= 0x10
                value |= 0x80
                bytes[byte + 1] = value

                value = bytes[byte + 2]
                value |= 0x04
                value |= 0x20
                bytes[byte + 2] = value
                byte += 3
            }
        case 5:
            while byte <= fullBytes - 5 {
                var value = bytes[byte]
                value |= 0x01
                value |= 0x20
                bytes[byte] = value

                value = bytes[byte + 1]
                value |= 0x04
                value |= 0x80
                bytes[byte + 1] = value

                value = bytes[byte + 2]
                value |= 0x10
                bytes[byte + 2] = value

                value = bytes[byte + 3]
                value |= 0x02
                value |= 0x40
                bytes[byte + 3] = value

                value = bytes[byte + 4]
                value |= 0x08
                bytes[byte + 4] = value
                byte += 5
            }
        case 7:
            while byte <= fullBytes - 7 {
                var value = bytes[byte]
                value |= 0x01
                value |= 0x80
                bytes[byte] = value

                value = bytes[byte + 1]
                value |= 0x40
                bytes[byte + 1] = value

                value = bytes[byte + 2]
                value |= 0x20
                bytes[byte + 2] = value

                value = bytes[byte + 3]
                value |= 0x10
                bytes[byte + 3] = value

                value = bytes[byte + 4]
                value |= 0x08
                bytes[byte + 4] = value

                value = bytes[byte + 5]
                value |= 0x04
                bytes[byte + 5] = value

                value = bytes[byte + 6]
                value |= 0x02
                bytes[byte + 6] = value
                byte += 7
            }
        default:
            preconditionFailure("Dense marking requires factor 3, 5, or 7")
        }

        // At most eight marks remain, including any partial final byte.
        bit = byte * 8
        while bit < oddCount {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
    }

    /// Dense marking on 64-bit words for factors 9, 11, and 13. Every odd value in
    /// that range has a case, so no primality is assumed; 9 is composite and never
    /// reaches this function.
    private func markWordDenseMultiples(of p: Int) {
        let bytes = storage
        var bit = (p * p - 3) / 2

        // Odd p is coprime to 64, so at most 63 marks reach a word boundary.
        while bit < oddCount && bit & 63 != 0 {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
        guard bit < oddCount else { return }

        let words = UnsafeMutableRawPointer(bytes)
        var word = bit >> 6
        let fullWords = oddCount >> 6

        // From a word boundary, 64 successive marks at 0, p, ... 63p span p words;
        // the next mark starts the next p-word group. Each markWord call marks the
        // multiples in one word individually and stores that word once. `first` is
        // the bit offset of that word's first multiple.
        switch p {
        case 9:
            while word + 9 <= fullWords {
                markWord(words, word, first: 0, step: 9)
                markWord(words, word + 1, first: 8, step: 9)
                markWord(words, word + 2, first: 7, step: 9)
                markWord(words, word + 3, first: 6, step: 9)
                markWord(words, word + 4, first: 5, step: 9)
                markWord(words, word + 5, first: 4, step: 9)
                markWord(words, word + 6, first: 3, step: 9)
                markWord(words, word + 7, first: 2, step: 9)
                markWord(words, word + 8, first: 1, step: 9)
                word += 9
            }
        case 11:
            while word + 11 <= fullWords {
                markWord(words, word, first: 0, step: 11)
                markWord(words, word + 1, first: 2, step: 11)
                markWord(words, word + 2, first: 4, step: 11)
                markWord(words, word + 3, first: 6, step: 11)
                markWord(words, word + 4, first: 8, step: 11)
                markWord(words, word + 5, first: 10, step: 11)
                markWord(words, word + 6, first: 1, step: 11)
                markWord(words, word + 7, first: 3, step: 11)
                markWord(words, word + 8, first: 5, step: 11)
                markWord(words, word + 9, first: 7, step: 11)
                markWord(words, word + 10, first: 9, step: 11)
                word += 11
            }
        case 13:
            while word + 13 <= fullWords {
                markWord(words, word, first: 0, step: 13)
                markWord(words, word + 1, first: 1, step: 13)
                markWord(words, word + 2, first: 2, step: 13)
                markWord(words, word + 3, first: 3, step: 13)
                markWord(words, word + 4, first: 4, step: 13)
                markWord(words, word + 5, first: 5, step: 13)
                markWord(words, word + 6, first: 6, step: 13)
                markWord(words, word + 7, first: 7, step: 13)
                markWord(words, word + 8, first: 8, step: 13)
                markWord(words, word + 9, first: 9, step: 13)
                markWord(words, word + 10, first: 10, step: 13)
                markWord(words, word + 11, first: 11, step: 13)
                markWord(words, word + 12, first: 12, step: 13)
                word += 13
            }
        default:
            preconditionFailure("Word-dense marking requires factor 9, 11, or 13")
        }

        // Fewer than p complete words remain, plus any partial final word.
        bit = word * 64
        while bit < oddCount {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
    }

    /// Marks each multiple of p within one 64-bit word individually, starting at
    /// bit `first`, then stores the word once. The word is read and written
    /// little-endian, so its bit i is bit i & 7 of its byte i >> 3, as elsewhere.
    @inline(__always)
    private func markWord(_ words: UnsafeMutableRawPointer, _ word: Int, first: Int, step p: Int) {
        let offset = word * 8
        var value = UInt64(littleEndian: words.loadUnaligned(fromByteOffset: offset, as: UInt64.self))
        var bit = first
        while bit < 64 {
            value |= 1 << bit
            bit += p
        }
        words.storeBytes(of: value.littleEndian, toByteOffset: offset, as: UInt64.self)
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
