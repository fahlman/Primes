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
                if p < 64 {
                    if p == 3 {
                        markDenseMultiples(of: p)
                    } else {
                        markWordDenseMultiples(of: p)
                    }
                    p += 2
                    continue
                }

                if p < 112 {
                    markVectorDenseMultiples(of: p)
                    p += 2
                    continue
                }

                // Factors above 111 leave at most one multiple in each 64-bit word.
                // Eight consecutive multiples fall on all eight bit offsets within
                // a byte, and their byte offsets repeat every p bytes, so one loop
                // marks two groups of eight multiples per iteration, each with its own single-bit
                // mask. The first multiple, p², falls at bit offset 7 when p ≡ 1 or
                // 7 (mod 8) and at 3 when p ≡ 3 or 5, which fixes the masks; these
                // four cases cover every odd factor.
                let start = (p * p - 3) / 2
                switch p & 7 {
                case 1:
                    markSparseMultiples(bytes, end: end, start: start, step: p,
                                        0x80, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40)
                case 3:
                    markSparseMultiples(bytes, end: end, start: start, step: p,
                                        0x08, 0x40, 0x02, 0x10, 0x80, 0x04, 0x20, 0x01)
                case 5:
                    markSparseMultiples(bytes, end: end, start: start, step: p,
                                        0x08, 0x01, 0x20, 0x04, 0x80, 0x10, 0x02, 0x40)
                default: // p & 7 == 7
                    markSparseMultiples(bytes, end: end, start: start, step: p,
                                        0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01)
                }
            }
            p += 2
        }
    }

    /// Fused byte marking for odd factors above 111, from bit `start` onward. Each
    /// iteration marks two groups of eight multiples, each group visiting every
    /// bit offset with its single-bit mask `m0`...`m7`. Their byte offsets
    /// `r1`...`r7` repeat every p bytes. Each multiple gets its own OR.
    @inline(__always)
    private func markSparseMultiples(
        _ bytes: UnsafeMutablePointer<UInt8>, end: Int, start: Int, step p: Int,
        _ m0: UInt8, _ m1: UInt8, _ m2: UInt8, _ m3: UInt8,
        _ m4: UInt8, _ m5: UInt8, _ m6: UInt8, _ m7: UInt8
    ) {
        let bit = start & 7
        let r1 = (bit + p) >> 3
        let r2 = (bit + 2 * p) >> 3
        let r3 = (bit + 3 * p) >> 3
        let r4 = (bit + 4 * p) >> 3
        let r5 = (bit + 5 * p) >> 3
        let r6 = (bit + 6 * p) >> 3
        let r7 = (bit + 7 * p) >> 3
        let groupEnd = end - r7
        let doubleGroupEnd = groupEnd - p
        var byte = start >> 3

        // Wrapping additions change no result here; they only drop overflow checks.
        // The byte index stays below end + p and the bit index below 8 * end + p,
        // both far from Int.max.
        // The second group's last address is byte + p + r7, bounded by end.
        // Advance the index between groups while reusing the eight source offsets.
        while byte < doubleGroupEnd {
            bytes[byte] |= m0
            bytes[byte &+ r1] |= m1
            bytes[byte &+ r2] |= m2
            bytes[byte &+ r3] |= m3
            bytes[byte &+ r4] |= m4
            bytes[byte &+ r5] |= m5
            bytes[byte &+ r6] |= m6
            bytes[byte &+ r7] |= m7
            byte &+= p

            bytes[byte] |= m0
            bytes[byte &+ r1] |= m1
            bytes[byte &+ r2] |= m2
            bytes[byte &+ r3] |= m3
            bytes[byte &+ r4] |= m4
            bytes[byte &+ r5] |= m5
            bytes[byte &+ r6] |= m6
            bytes[byte &+ r7] |= m7
            byte &+= p
        }

        // At most one complete eight-mark group remains before the scalar tail.
        if byte < groupEnd {
            bytes[byte] |= m0
            bytes[byte &+ r1] |= m1
            bytes[byte &+ r2] |= m2
            bytes[byte &+ r3] |= m3
            bytes[byte &+ r4] |= m4
            bytes[byte &+ r5] |= m5
            bytes[byte &+ r6] |= m6
            bytes[byte &+ r7] |= m7
            byte &+= p
        }

        // At most seven multiples remain. Like the group loop, the tail runs to the
        // end of the last byte, so it can also set padding bits past the last
        // candidate; enumeration ignores them.
        let bitEnd = end << 3
        var index = (byte << 3) + bit
        while index < bitEnd {
            bytes[index >> 3] |= UInt8(1) << (index & 7)
            index &+= p
        }
    }

    /// Dense marking on bytes for factor 3.
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
        default:
            preconditionFailure("Byte-dense marking requires factor 3")
        }

        // At most eight marks remain, including any partial final byte.
        bit = byte * 8
        while bit < oddCount {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
    }

    /// Dense marking on 64-bit words for odd factors 5 through 63. Together with the
    /// byte handler for 3, every odd value below 64 has a case, so no primality is
    /// assumed; the composite values 9, 15, 21, 25, 27, 33, 35, 39, 45, 49, 51, 55,
    /// 57, and 63 never reach this function.
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
        case 5:
            while word + 5 <= fullWords {
                markWord(words, word, first: 0, step: 5)
                markWord(words, word + 1, first: 1, step: 5)
                markWord(words, word + 2, first: 2, step: 5)
                markWord(words, word + 3, first: 3, step: 5)
                markWord(words, word + 4, first: 4, step: 5)
                word += 5
            }
        case 7:
            while word + 7 <= fullWords {
                markWord(words, word, first: 0, step: 7)
                markWord(words, word + 1, first: 6, step: 7)
                markWord(words, word + 2, first: 5, step: 7)
                markWord(words, word + 3, first: 4, step: 7)
                markWord(words, word + 4, first: 3, step: 7)
                markWord(words, word + 5, first: 2, step: 7)
                markWord(words, word + 6, first: 1, step: 7)
                word += 7
            }
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
        case 15:
            while word + 15 <= fullWords {
                markWord(words, word, first: 0, step: 15)
                markWord(words, word + 1, first: 11, step: 15)
                markWord(words, word + 2, first: 7, step: 15)
                markWord(words, word + 3, first: 3, step: 15)
                markWord(words, word + 4, first: 14, step: 15)
                markWord(words, word + 5, first: 10, step: 15)
                markWord(words, word + 6, first: 6, step: 15)
                markWord(words, word + 7, first: 2, step: 15)
                markWord(words, word + 8, first: 13, step: 15)
                markWord(words, word + 9, first: 9, step: 15)
                markWord(words, word + 10, first: 5, step: 15)
                markWord(words, word + 11, first: 1, step: 15)
                markWord(words, word + 12, first: 12, step: 15)
                markWord(words, word + 13, first: 8, step: 15)
                markWord(words, word + 14, first: 4, step: 15)
                word += 15
            }
        case 17:
            while word + 17 <= fullWords {
                markWord(words, word, first: 0, step: 17)
                markWord(words, word + 1, first: 4, step: 17)
                markWord(words, word + 2, first: 8, step: 17)
                markWord(words, word + 3, first: 12, step: 17)
                markWord(words, word + 4, first: 16, step: 17)
                markWord(words, word + 5, first: 3, step: 17)
                markWord(words, word + 6, first: 7, step: 17)
                markWord(words, word + 7, first: 11, step: 17)
                markWord(words, word + 8, first: 15, step: 17)
                markWord(words, word + 9, first: 2, step: 17)
                markWord(words, word + 10, first: 6, step: 17)
                markWord(words, word + 11, first: 10, step: 17)
                markWord(words, word + 12, first: 14, step: 17)
                markWord(words, word + 13, first: 1, step: 17)
                markWord(words, word + 14, first: 5, step: 17)
                markWord(words, word + 15, first: 9, step: 17)
                markWord(words, word + 16, first: 13, step: 17)
                word += 17
            }
        case 19:
            while word + 19 <= fullWords {
                markWord(words, word, first: 0, step: 19)
                markWord(words, word + 1, first: 12, step: 19)
                markWord(words, word + 2, first: 5, step: 19)
                markWord(words, word + 3, first: 17, step: 19)
                markWord(words, word + 4, first: 10, step: 19)
                markWord(words, word + 5, first: 3, step: 19)
                markWord(words, word + 6, first: 15, step: 19)
                markWord(words, word + 7, first: 8, step: 19)
                markWord(words, word + 8, first: 1, step: 19)
                markWord(words, word + 9, first: 13, step: 19)
                markWord(words, word + 10, first: 6, step: 19)
                markWord(words, word + 11, first: 18, step: 19)
                markWord(words, word + 12, first: 11, step: 19)
                markWord(words, word + 13, first: 4, step: 19)
                markWord(words, word + 14, first: 16, step: 19)
                markWord(words, word + 15, first: 9, step: 19)
                markWord(words, word + 16, first: 2, step: 19)
                markWord(words, word + 17, first: 14, step: 19)
                markWord(words, word + 18, first: 7, step: 19)
                word += 19
            }
        case 21:
            while word + 21 <= fullWords {
                markWord(words, word, first: 0, step: 21)
                markWord(words, word + 1, first: 20, step: 21)
                markWord(words, word + 2, first: 19, step: 21)
                markWord(words, word + 3, first: 18, step: 21)
                markWord(words, word + 4, first: 17, step: 21)
                markWord(words, word + 5, first: 16, step: 21)
                markWord(words, word + 6, first: 15, step: 21)
                markWord(words, word + 7, first: 14, step: 21)
                markWord(words, word + 8, first: 13, step: 21)
                markWord(words, word + 9, first: 12, step: 21)
                markWord(words, word + 10, first: 11, step: 21)
                markWord(words, word + 11, first: 10, step: 21)
                markWord(words, word + 12, first: 9, step: 21)
                markWord(words, word + 13, first: 8, step: 21)
                markWord(words, word + 14, first: 7, step: 21)
                markWord(words, word + 15, first: 6, step: 21)
                markWord(words, word + 16, first: 5, step: 21)
                markWord(words, word + 17, first: 4, step: 21)
                markWord(words, word + 18, first: 3, step: 21)
                markWord(words, word + 19, first: 2, step: 21)
                markWord(words, word + 20, first: 1, step: 21)
                word += 21
            }
        case 23:
            while word + 23 <= fullWords {
                markWord(words, word, first: 0, step: 23)
                markWord(words, word + 1, first: 5, step: 23)
                markWord(words, word + 2, first: 10, step: 23)
                markWord(words, word + 3, first: 15, step: 23)
                markWord(words, word + 4, first: 20, step: 23)
                markWord(words, word + 5, first: 2, step: 23)
                markWord(words, word + 6, first: 7, step: 23)
                markWord(words, word + 7, first: 12, step: 23)
                markWord(words, word + 8, first: 17, step: 23)
                markWord(words, word + 9, first: 22, step: 23)
                markWord(words, word + 10, first: 4, step: 23)
                markWord(words, word + 11, first: 9, step: 23)
                markWord(words, word + 12, first: 14, step: 23)
                markWord(words, word + 13, first: 19, step: 23)
                markWord(words, word + 14, first: 1, step: 23)
                markWord(words, word + 15, first: 6, step: 23)
                markWord(words, word + 16, first: 11, step: 23)
                markWord(words, word + 17, first: 16, step: 23)
                markWord(words, word + 18, first: 21, step: 23)
                markWord(words, word + 19, first: 3, step: 23)
                markWord(words, word + 20, first: 8, step: 23)
                markWord(words, word + 21, first: 13, step: 23)
                markWord(words, word + 22, first: 18, step: 23)
                word += 23
            }
        case 25:
            while word + 25 <= fullWords {
                markWord(words, word, first: 0, step: 25)
                markWord(words, word + 1, first: 11, step: 25)
                markWord(words, word + 2, first: 22, step: 25)
                markWord(words, word + 3, first: 8, step: 25)
                markWord(words, word + 4, first: 19, step: 25)
                markWord(words, word + 5, first: 5, step: 25)
                markWord(words, word + 6, first: 16, step: 25)
                markWord(words, word + 7, first: 2, step: 25)
                markWord(words, word + 8, first: 13, step: 25)
                markWord(words, word + 9, first: 24, step: 25)
                markWord(words, word + 10, first: 10, step: 25)
                markWord(words, word + 11, first: 21, step: 25)
                markWord(words, word + 12, first: 7, step: 25)
                markWord(words, word + 13, first: 18, step: 25)
                markWord(words, word + 14, first: 4, step: 25)
                markWord(words, word + 15, first: 15, step: 25)
                markWord(words, word + 16, first: 1, step: 25)
                markWord(words, word + 17, first: 12, step: 25)
                markWord(words, word + 18, first: 23, step: 25)
                markWord(words, word + 19, first: 9, step: 25)
                markWord(words, word + 20, first: 20, step: 25)
                markWord(words, word + 21, first: 6, step: 25)
                markWord(words, word + 22, first: 17, step: 25)
                markWord(words, word + 23, first: 3, step: 25)
                markWord(words, word + 24, first: 14, step: 25)
                word += 25
            }
        case 27:
            while word + 27 <= fullWords {
                markWord(words, word, first: 0, step: 27)
                markWord(words, word + 1, first: 17, step: 27)
                markWord(words, word + 2, first: 7, step: 27)
                markWord(words, word + 3, first: 24, step: 27)
                markWord(words, word + 4, first: 14, step: 27)
                markWord(words, word + 5, first: 4, step: 27)
                markWord(words, word + 6, first: 21, step: 27)
                markWord(words, word + 7, first: 11, step: 27)
                markWord(words, word + 8, first: 1, step: 27)
                markWord(words, word + 9, first: 18, step: 27)
                markWord(words, word + 10, first: 8, step: 27)
                markWord(words, word + 11, first: 25, step: 27)
                markWord(words, word + 12, first: 15, step: 27)
                markWord(words, word + 13, first: 5, step: 27)
                markWord(words, word + 14, first: 22, step: 27)
                markWord(words, word + 15, first: 12, step: 27)
                markWord(words, word + 16, first: 2, step: 27)
                markWord(words, word + 17, first: 19, step: 27)
                markWord(words, word + 18, first: 9, step: 27)
                markWord(words, word + 19, first: 26, step: 27)
                markWord(words, word + 20, first: 16, step: 27)
                markWord(words, word + 21, first: 6, step: 27)
                markWord(words, word + 22, first: 23, step: 27)
                markWord(words, word + 23, first: 13, step: 27)
                markWord(words, word + 24, first: 3, step: 27)
                markWord(words, word + 25, first: 20, step: 27)
                markWord(words, word + 26, first: 10, step: 27)
                word += 27
            }
        case 29:
            while word + 29 <= fullWords {
                markWord(words, word, first: 0, step: 29)
                markWord(words, word + 1, first: 23, step: 29)
                markWord(words, word + 2, first: 17, step: 29)
                markWord(words, word + 3, first: 11, step: 29)
                markWord(words, word + 4, first: 5, step: 29)
                markWord(words, word + 5, first: 28, step: 29)
                markWord(words, word + 6, first: 22, step: 29)
                markWord(words, word + 7, first: 16, step: 29)
                markWord(words, word + 8, first: 10, step: 29)
                markWord(words, word + 9, first: 4, step: 29)
                markWord(words, word + 10, first: 27, step: 29)
                markWord(words, word + 11, first: 21, step: 29)
                markWord(words, word + 12, first: 15, step: 29)
                markWord(words, word + 13, first: 9, step: 29)
                markWord(words, word + 14, first: 3, step: 29)
                markWord(words, word + 15, first: 26, step: 29)
                markWord(words, word + 16, first: 20, step: 29)
                markWord(words, word + 17, first: 14, step: 29)
                markWord(words, word + 18, first: 8, step: 29)
                markWord(words, word + 19, first: 2, step: 29)
                markWord(words, word + 20, first: 25, step: 29)
                markWord(words, word + 21, first: 19, step: 29)
                markWord(words, word + 22, first: 13, step: 29)
                markWord(words, word + 23, first: 7, step: 29)
                markWord(words, word + 24, first: 1, step: 29)
                markWord(words, word + 25, first: 24, step: 29)
                markWord(words, word + 26, first: 18, step: 29)
                markWord(words, word + 27, first: 12, step: 29)
                markWord(words, word + 28, first: 6, step: 29)
                word += 29
            }
        case 31:
            while word + 31 <= fullWords {
                markWord(words, word, first: 0, step: 31)
                markWord(words, word + 1, first: 29, step: 31)
                markWord(words, word + 2, first: 27, step: 31)
                markWord(words, word + 3, first: 25, step: 31)
                markWord(words, word + 4, first: 23, step: 31)
                markWord(words, word + 5, first: 21, step: 31)
                markWord(words, word + 6, first: 19, step: 31)
                markWord(words, word + 7, first: 17, step: 31)
                markWord(words, word + 8, first: 15, step: 31)
                markWord(words, word + 9, first: 13, step: 31)
                markWord(words, word + 10, first: 11, step: 31)
                markWord(words, word + 11, first: 9, step: 31)
                markWord(words, word + 12, first: 7, step: 31)
                markWord(words, word + 13, first: 5, step: 31)
                markWord(words, word + 14, first: 3, step: 31)
                markWord(words, word + 15, first: 1, step: 31)
                markWord(words, word + 16, first: 30, step: 31)
                markWord(words, word + 17, first: 28, step: 31)
                markWord(words, word + 18, first: 26, step: 31)
                markWord(words, word + 19, first: 24, step: 31)
                markWord(words, word + 20, first: 22, step: 31)
                markWord(words, word + 21, first: 20, step: 31)
                markWord(words, word + 22, first: 18, step: 31)
                markWord(words, word + 23, first: 16, step: 31)
                markWord(words, word + 24, first: 14, step: 31)
                markWord(words, word + 25, first: 12, step: 31)
                markWord(words, word + 26, first: 10, step: 31)
                markWord(words, word + 27, first: 8, step: 31)
                markWord(words, word + 28, first: 6, step: 31)
                markWord(words, word + 29, first: 4, step: 31)
                markWord(words, word + 30, first: 2, step: 31)
                word += 31
            }
        case 33:
            while word + 33 <= fullWords {
                markWord(words, word, first: 0, step: 33)
                markWord(words, word + 1, first: 2, step: 33)
                markWord(words, word + 2, first: 4, step: 33)
                markWord(words, word + 3, first: 6, step: 33)
                markWord(words, word + 4, first: 8, step: 33)
                markWord(words, word + 5, first: 10, step: 33)
                markWord(words, word + 6, first: 12, step: 33)
                markWord(words, word + 7, first: 14, step: 33)
                markWord(words, word + 8, first: 16, step: 33)
                markWord(words, word + 9, first: 18, step: 33)
                markWord(words, word + 10, first: 20, step: 33)
                markWord(words, word + 11, first: 22, step: 33)
                markWord(words, word + 12, first: 24, step: 33)
                markWord(words, word + 13, first: 26, step: 33)
                markWord(words, word + 14, first: 28, step: 33)
                markWord(words, word + 15, first: 30, step: 33)
                markWord(words, word + 16, first: 32, step: 33)
                markWord(words, word + 17, first: 1, step: 33)
                markWord(words, word + 18, first: 3, step: 33)
                markWord(words, word + 19, first: 5, step: 33)
                markWord(words, word + 20, first: 7, step: 33)
                markWord(words, word + 21, first: 9, step: 33)
                markWord(words, word + 22, first: 11, step: 33)
                markWord(words, word + 23, first: 13, step: 33)
                markWord(words, word + 24, first: 15, step: 33)
                markWord(words, word + 25, first: 17, step: 33)
                markWord(words, word + 26, first: 19, step: 33)
                markWord(words, word + 27, first: 21, step: 33)
                markWord(words, word + 28, first: 23, step: 33)
                markWord(words, word + 29, first: 25, step: 33)
                markWord(words, word + 30, first: 27, step: 33)
                markWord(words, word + 31, first: 29, step: 33)
                markWord(words, word + 32, first: 31, step: 33)
                word += 33
            }
        case 35:
            while word + 35 <= fullWords {
                markWord(words, word, first: 0, step: 35)
                markWord(words, word + 1, first: 6, step: 35)
                markWord(words, word + 2, first: 12, step: 35)
                markWord(words, word + 3, first: 18, step: 35)
                markWord(words, word + 4, first: 24, step: 35)
                markWord(words, word + 5, first: 30, step: 35)
                markWord(words, word + 6, first: 1, step: 35)
                markWord(words, word + 7, first: 7, step: 35)
                markWord(words, word + 8, first: 13, step: 35)
                markWord(words, word + 9, first: 19, step: 35)
                markWord(words, word + 10, first: 25, step: 35)
                markWord(words, word + 11, first: 31, step: 35)
                markWord(words, word + 12, first: 2, step: 35)
                markWord(words, word + 13, first: 8, step: 35)
                markWord(words, word + 14, first: 14, step: 35)
                markWord(words, word + 15, first: 20, step: 35)
                markWord(words, word + 16, first: 26, step: 35)
                markWord(words, word + 17, first: 32, step: 35)
                markWord(words, word + 18, first: 3, step: 35)
                markWord(words, word + 19, first: 9, step: 35)
                markWord(words, word + 20, first: 15, step: 35)
                markWord(words, word + 21, first: 21, step: 35)
                markWord(words, word + 22, first: 27, step: 35)
                markWord(words, word + 23, first: 33, step: 35)
                markWord(words, word + 24, first: 4, step: 35)
                markWord(words, word + 25, first: 10, step: 35)
                markWord(words, word + 26, first: 16, step: 35)
                markWord(words, word + 27, first: 22, step: 35)
                markWord(words, word + 28, first: 28, step: 35)
                markWord(words, word + 29, first: 34, step: 35)
                markWord(words, word + 30, first: 5, step: 35)
                markWord(words, word + 31, first: 11, step: 35)
                markWord(words, word + 32, first: 17, step: 35)
                markWord(words, word + 33, first: 23, step: 35)
                markWord(words, word + 34, first: 29, step: 35)
                word += 35
            }
        case 37:
            while word + 37 <= fullWords {
                markWord(words, word, first: 0, step: 37)
                markWord(words, word + 1, first: 10, step: 37)
                markWord(words, word + 2, first: 20, step: 37)
                markWord(words, word + 3, first: 30, step: 37)
                markWord(words, word + 4, first: 3, step: 37)
                markWord(words, word + 5, first: 13, step: 37)
                markWord(words, word + 6, first: 23, step: 37)
                markWord(words, word + 7, first: 33, step: 37)
                markWord(words, word + 8, first: 6, step: 37)
                markWord(words, word + 9, first: 16, step: 37)
                markWord(words, word + 10, first: 26, step: 37)
                markWord(words, word + 11, first: 36, step: 37)
                markWord(words, word + 12, first: 9, step: 37)
                markWord(words, word + 13, first: 19, step: 37)
                markWord(words, word + 14, first: 29, step: 37)
                markWord(words, word + 15, first: 2, step: 37)
                markWord(words, word + 16, first: 12, step: 37)
                markWord(words, word + 17, first: 22, step: 37)
                markWord(words, word + 18, first: 32, step: 37)
                markWord(words, word + 19, first: 5, step: 37)
                markWord(words, word + 20, first: 15, step: 37)
                markWord(words, word + 21, first: 25, step: 37)
                markWord(words, word + 22, first: 35, step: 37)
                markWord(words, word + 23, first: 8, step: 37)
                markWord(words, word + 24, first: 18, step: 37)
                markWord(words, word + 25, first: 28, step: 37)
                markWord(words, word + 26, first: 1, step: 37)
                markWord(words, word + 27, first: 11, step: 37)
                markWord(words, word + 28, first: 21, step: 37)
                markWord(words, word + 29, first: 31, step: 37)
                markWord(words, word + 30, first: 4, step: 37)
                markWord(words, word + 31, first: 14, step: 37)
                markWord(words, word + 32, first: 24, step: 37)
                markWord(words, word + 33, first: 34, step: 37)
                markWord(words, word + 34, first: 7, step: 37)
                markWord(words, word + 35, first: 17, step: 37)
                markWord(words, word + 36, first: 27, step: 37)
                word += 37
            }
        case 39:
            while word + 39 <= fullWords {
                markWord(words, word, first: 0, step: 39)
                markWord(words, word + 1, first: 14, step: 39)
                markWord(words, word + 2, first: 28, step: 39)
                markWord(words, word + 3, first: 3, step: 39)
                markWord(words, word + 4, first: 17, step: 39)
                markWord(words, word + 5, first: 31, step: 39)
                markWord(words, word + 6, first: 6, step: 39)
                markWord(words, word + 7, first: 20, step: 39)
                markWord(words, word + 8, first: 34, step: 39)
                markWord(words, word + 9, first: 9, step: 39)
                markWord(words, word + 10, first: 23, step: 39)
                markWord(words, word + 11, first: 37, step: 39)
                markWord(words, word + 12, first: 12, step: 39)
                markWord(words, word + 13, first: 26, step: 39)
                markWord(words, word + 14, first: 1, step: 39)
                markWord(words, word + 15, first: 15, step: 39)
                markWord(words, word + 16, first: 29, step: 39)
                markWord(words, word + 17, first: 4, step: 39)
                markWord(words, word + 18, first: 18, step: 39)
                markWord(words, word + 19, first: 32, step: 39)
                markWord(words, word + 20, first: 7, step: 39)
                markWord(words, word + 21, first: 21, step: 39)
                markWord(words, word + 22, first: 35, step: 39)
                markWord(words, word + 23, first: 10, step: 39)
                markWord(words, word + 24, first: 24, step: 39)
                markWord(words, word + 25, first: 38, step: 39)
                markWord(words, word + 26, first: 13, step: 39)
                markWord(words, word + 27, first: 27, step: 39)
                markWord(words, word + 28, first: 2, step: 39)
                markWord(words, word + 29, first: 16, step: 39)
                markWord(words, word + 30, first: 30, step: 39)
                markWord(words, word + 31, first: 5, step: 39)
                markWord(words, word + 32, first: 19, step: 39)
                markWord(words, word + 33, first: 33, step: 39)
                markWord(words, word + 34, first: 8, step: 39)
                markWord(words, word + 35, first: 22, step: 39)
                markWord(words, word + 36, first: 36, step: 39)
                markWord(words, word + 37, first: 11, step: 39)
                markWord(words, word + 38, first: 25, step: 39)
                word += 39
            }
        case 41:
            while word + 41 <= fullWords {
                markWord(words, word, first: 0, step: 41)
                markWord(words, word + 1, first: 18, step: 41)
                markWord(words, word + 2, first: 36, step: 41)
                markWord(words, word + 3, first: 13, step: 41)
                markWord(words, word + 4, first: 31, step: 41)
                markWord(words, word + 5, first: 8, step: 41)
                markWord(words, word + 6, first: 26, step: 41)
                markWord(words, word + 7, first: 3, step: 41)
                markWord(words, word + 8, first: 21, step: 41)
                markWord(words, word + 9, first: 39, step: 41)
                markWord(words, word + 10, first: 16, step: 41)
                markWord(words, word + 11, first: 34, step: 41)
                markWord(words, word + 12, first: 11, step: 41)
                markWord(words, word + 13, first: 29, step: 41)
                markWord(words, word + 14, first: 6, step: 41)
                markWord(words, word + 15, first: 24, step: 41)
                markWord(words, word + 16, first: 1, step: 41)
                markWord(words, word + 17, first: 19, step: 41)
                markWord(words, word + 18, first: 37, step: 41)
                markWord(words, word + 19, first: 14, step: 41)
                markWord(words, word + 20, first: 32, step: 41)
                markWord(words, word + 21, first: 9, step: 41)
                markWord(words, word + 22, first: 27, step: 41)
                markWord(words, word + 23, first: 4, step: 41)
                markWord(words, word + 24, first: 22, step: 41)
                markWord(words, word + 25, first: 40, step: 41)
                markWord(words, word + 26, first: 17, step: 41)
                markWord(words, word + 27, first: 35, step: 41)
                markWord(words, word + 28, first: 12, step: 41)
                markWord(words, word + 29, first: 30, step: 41)
                markWord(words, word + 30, first: 7, step: 41)
                markWord(words, word + 31, first: 25, step: 41)
                markWord(words, word + 32, first: 2, step: 41)
                markWord(words, word + 33, first: 20, step: 41)
                markWord(words, word + 34, first: 38, step: 41)
                markWord(words, word + 35, first: 15, step: 41)
                markWord(words, word + 36, first: 33, step: 41)
                markWord(words, word + 37, first: 10, step: 41)
                markWord(words, word + 38, first: 28, step: 41)
                markWord(words, word + 39, first: 5, step: 41)
                markWord(words, word + 40, first: 23, step: 41)
                word += 41
            }
        case 43:
            while word + 43 <= fullWords {
                markWord(words, word, first: 0, step: 43)
                markWord(words, word + 1, first: 22, step: 43)
                markWord(words, word + 2, first: 1, step: 43)
                markWord(words, word + 3, first: 23, step: 43)
                markWord(words, word + 4, first: 2, step: 43)
                markWord(words, word + 5, first: 24, step: 43)
                markWord(words, word + 6, first: 3, step: 43)
                markWord(words, word + 7, first: 25, step: 43)
                markWord(words, word + 8, first: 4, step: 43)
                markWord(words, word + 9, first: 26, step: 43)
                markWord(words, word + 10, first: 5, step: 43)
                markWord(words, word + 11, first: 27, step: 43)
                markWord(words, word + 12, first: 6, step: 43)
                markWord(words, word + 13, first: 28, step: 43)
                markWord(words, word + 14, first: 7, step: 43)
                markWord(words, word + 15, first: 29, step: 43)
                markWord(words, word + 16, first: 8, step: 43)
                markWord(words, word + 17, first: 30, step: 43)
                markWord(words, word + 18, first: 9, step: 43)
                markWord(words, word + 19, first: 31, step: 43)
                markWord(words, word + 20, first: 10, step: 43)
                markWord(words, word + 21, first: 32, step: 43)
                markWord(words, word + 22, first: 11, step: 43)
                markWord(words, word + 23, first: 33, step: 43)
                markWord(words, word + 24, first: 12, step: 43)
                markWord(words, word + 25, first: 34, step: 43)
                markWord(words, word + 26, first: 13, step: 43)
                markWord(words, word + 27, first: 35, step: 43)
                markWord(words, word + 28, first: 14, step: 43)
                markWord(words, word + 29, first: 36, step: 43)
                markWord(words, word + 30, first: 15, step: 43)
                markWord(words, word + 31, first: 37, step: 43)
                markWord(words, word + 32, first: 16, step: 43)
                markWord(words, word + 33, first: 38, step: 43)
                markWord(words, word + 34, first: 17, step: 43)
                markWord(words, word + 35, first: 39, step: 43)
                markWord(words, word + 36, first: 18, step: 43)
                markWord(words, word + 37, first: 40, step: 43)
                markWord(words, word + 38, first: 19, step: 43)
                markWord(words, word + 39, first: 41, step: 43)
                markWord(words, word + 40, first: 20, step: 43)
                markWord(words, word + 41, first: 42, step: 43)
                markWord(words, word + 42, first: 21, step: 43)
                word += 43
            }
        case 45:
            while word + 45 <= fullWords {
                markWord(words, word, first: 0, step: 45)
                markWord(words, word + 1, first: 26, step: 45)
                markWord(words, word + 2, first: 7, step: 45)
                markWord(words, word + 3, first: 33, step: 45)
                markWord(words, word + 4, first: 14, step: 45)
                markWord(words, word + 5, first: 40, step: 45)
                markWord(words, word + 6, first: 21, step: 45)
                markWord(words, word + 7, first: 2, step: 45)
                markWord(words, word + 8, first: 28, step: 45)
                markWord(words, word + 9, first: 9, step: 45)
                markWord(words, word + 10, first: 35, step: 45)
                markWord(words, word + 11, first: 16, step: 45)
                markWord(words, word + 12, first: 42, step: 45)
                markWord(words, word + 13, first: 23, step: 45)
                markWord(words, word + 14, first: 4, step: 45)
                markWord(words, word + 15, first: 30, step: 45)
                markWord(words, word + 16, first: 11, step: 45)
                markWord(words, word + 17, first: 37, step: 45)
                markWord(words, word + 18, first: 18, step: 45)
                markWord(words, word + 19, first: 44, step: 45)
                markWord(words, word + 20, first: 25, step: 45)
                markWord(words, word + 21, first: 6, step: 45)
                markWord(words, word + 22, first: 32, step: 45)
                markWord(words, word + 23, first: 13, step: 45)
                markWord(words, word + 24, first: 39, step: 45)
                markWord(words, word + 25, first: 20, step: 45)
                markWord(words, word + 26, first: 1, step: 45)
                markWord(words, word + 27, first: 27, step: 45)
                markWord(words, word + 28, first: 8, step: 45)
                markWord(words, word + 29, first: 34, step: 45)
                markWord(words, word + 30, first: 15, step: 45)
                markWord(words, word + 31, first: 41, step: 45)
                markWord(words, word + 32, first: 22, step: 45)
                markWord(words, word + 33, first: 3, step: 45)
                markWord(words, word + 34, first: 29, step: 45)
                markWord(words, word + 35, first: 10, step: 45)
                markWord(words, word + 36, first: 36, step: 45)
                markWord(words, word + 37, first: 17, step: 45)
                markWord(words, word + 38, first: 43, step: 45)
                markWord(words, word + 39, first: 24, step: 45)
                markWord(words, word + 40, first: 5, step: 45)
                markWord(words, word + 41, first: 31, step: 45)
                markWord(words, word + 42, first: 12, step: 45)
                markWord(words, word + 43, first: 38, step: 45)
                markWord(words, word + 44, first: 19, step: 45)
                word += 45
            }
        case 47:
            while word + 47 <= fullWords {
                markWord(words, word, first: 0, step: 47)
                markWord(words, word + 1, first: 30, step: 47)
                markWord(words, word + 2, first: 13, step: 47)
                markWord(words, word + 3, first: 43, step: 47)
                markWord(words, word + 4, first: 26, step: 47)
                markWord(words, word + 5, first: 9, step: 47)
                markWord(words, word + 6, first: 39, step: 47)
                markWord(words, word + 7, first: 22, step: 47)
                markWord(words, word + 8, first: 5, step: 47)
                markWord(words, word + 9, first: 35, step: 47)
                markWord(words, word + 10, first: 18, step: 47)
                markWord(words, word + 11, first: 1, step: 47)
                markWord(words, word + 12, first: 31, step: 47)
                markWord(words, word + 13, first: 14, step: 47)
                markWord(words, word + 14, first: 44, step: 47)
                markWord(words, word + 15, first: 27, step: 47)
                markWord(words, word + 16, first: 10, step: 47)
                markWord(words, word + 17, first: 40, step: 47)
                markWord(words, word + 18, first: 23, step: 47)
                markWord(words, word + 19, first: 6, step: 47)
                markWord(words, word + 20, first: 36, step: 47)
                markWord(words, word + 21, first: 19, step: 47)
                markWord(words, word + 22, first: 2, step: 47)
                markWord(words, word + 23, first: 32, step: 47)
                markWord(words, word + 24, first: 15, step: 47)
                markWord(words, word + 25, first: 45, step: 47)
                markWord(words, word + 26, first: 28, step: 47)
                markWord(words, word + 27, first: 11, step: 47)
                markWord(words, word + 28, first: 41, step: 47)
                markWord(words, word + 29, first: 24, step: 47)
                markWord(words, word + 30, first: 7, step: 47)
                markWord(words, word + 31, first: 37, step: 47)
                markWord(words, word + 32, first: 20, step: 47)
                markWord(words, word + 33, first: 3, step: 47)
                markWord(words, word + 34, first: 33, step: 47)
                markWord(words, word + 35, first: 16, step: 47)
                markWord(words, word + 36, first: 46, step: 47)
                markWord(words, word + 37, first: 29, step: 47)
                markWord(words, word + 38, first: 12, step: 47)
                markWord(words, word + 39, first: 42, step: 47)
                markWord(words, word + 40, first: 25, step: 47)
                markWord(words, word + 41, first: 8, step: 47)
                markWord(words, word + 42, first: 38, step: 47)
                markWord(words, word + 43, first: 21, step: 47)
                markWord(words, word + 44, first: 4, step: 47)
                markWord(words, word + 45, first: 34, step: 47)
                markWord(words, word + 46, first: 17, step: 47)
                word += 47
            }
        case 49:
            while word + 49 <= fullWords {
                markWord(words, word, first: 0, step: 49)
                markWord(words, word + 1, first: 34, step: 49)
                markWord(words, word + 2, first: 19, step: 49)
                markWord(words, word + 3, first: 4, step: 49)
                markWord(words, word + 4, first: 38, step: 49)
                markWord(words, word + 5, first: 23, step: 49)
                markWord(words, word + 6, first: 8, step: 49)
                markWord(words, word + 7, first: 42, step: 49)
                markWord(words, word + 8, first: 27, step: 49)
                markWord(words, word + 9, first: 12, step: 49)
                markWord(words, word + 10, first: 46, step: 49)
                markWord(words, word + 11, first: 31, step: 49)
                markWord(words, word + 12, first: 16, step: 49)
                markWord(words, word + 13, first: 1, step: 49)
                markWord(words, word + 14, first: 35, step: 49)
                markWord(words, word + 15, first: 20, step: 49)
                markWord(words, word + 16, first: 5, step: 49)
                markWord(words, word + 17, first: 39, step: 49)
                markWord(words, word + 18, first: 24, step: 49)
                markWord(words, word + 19, first: 9, step: 49)
                markWord(words, word + 20, first: 43, step: 49)
                markWord(words, word + 21, first: 28, step: 49)
                markWord(words, word + 22, first: 13, step: 49)
                markWord(words, word + 23, first: 47, step: 49)
                markWord(words, word + 24, first: 32, step: 49)
                markWord(words, word + 25, first: 17, step: 49)
                markWord(words, word + 26, first: 2, step: 49)
                markWord(words, word + 27, first: 36, step: 49)
                markWord(words, word + 28, first: 21, step: 49)
                markWord(words, word + 29, first: 6, step: 49)
                markWord(words, word + 30, first: 40, step: 49)
                markWord(words, word + 31, first: 25, step: 49)
                markWord(words, word + 32, first: 10, step: 49)
                markWord(words, word + 33, first: 44, step: 49)
                markWord(words, word + 34, first: 29, step: 49)
                markWord(words, word + 35, first: 14, step: 49)
                markWord(words, word + 36, first: 48, step: 49)
                markWord(words, word + 37, first: 33, step: 49)
                markWord(words, word + 38, first: 18, step: 49)
                markWord(words, word + 39, first: 3, step: 49)
                markWord(words, word + 40, first: 37, step: 49)
                markWord(words, word + 41, first: 22, step: 49)
                markWord(words, word + 42, first: 7, step: 49)
                markWord(words, word + 43, first: 41, step: 49)
                markWord(words, word + 44, first: 26, step: 49)
                markWord(words, word + 45, first: 11, step: 49)
                markWord(words, word + 46, first: 45, step: 49)
                markWord(words, word + 47, first: 30, step: 49)
                markWord(words, word + 48, first: 15, step: 49)
                word += 49
            }
        case 51:
            while word + 51 <= fullWords {
                markWord(words, word, first: 0, step: 51)
                markWord(words, word + 1, first: 38, step: 51)
                markWord(words, word + 2, first: 25, step: 51)
                markWord(words, word + 3, first: 12, step: 51)
                markWord(words, word + 4, first: 50, step: 51)
                markWord(words, word + 5, first: 37, step: 51)
                markWord(words, word + 6, first: 24, step: 51)
                markWord(words, word + 7, first: 11, step: 51)
                markWord(words, word + 8, first: 49, step: 51)
                markWord(words, word + 9, first: 36, step: 51)
                markWord(words, word + 10, first: 23, step: 51)
                markWord(words, word + 11, first: 10, step: 51)
                markWord(words, word + 12, first: 48, step: 51)
                markWord(words, word + 13, first: 35, step: 51)
                markWord(words, word + 14, first: 22, step: 51)
                markWord(words, word + 15, first: 9, step: 51)
                markWord(words, word + 16, first: 47, step: 51)
                markWord(words, word + 17, first: 34, step: 51)
                markWord(words, word + 18, first: 21, step: 51)
                markWord(words, word + 19, first: 8, step: 51)
                markWord(words, word + 20, first: 46, step: 51)
                markWord(words, word + 21, first: 33, step: 51)
                markWord(words, word + 22, first: 20, step: 51)
                markWord(words, word + 23, first: 7, step: 51)
                markWord(words, word + 24, first: 45, step: 51)
                markWord(words, word + 25, first: 32, step: 51)
                markWord(words, word + 26, first: 19, step: 51)
                markWord(words, word + 27, first: 6, step: 51)
                markWord(words, word + 28, first: 44, step: 51)
                markWord(words, word + 29, first: 31, step: 51)
                markWord(words, word + 30, first: 18, step: 51)
                markWord(words, word + 31, first: 5, step: 51)
                markWord(words, word + 32, first: 43, step: 51)
                markWord(words, word + 33, first: 30, step: 51)
                markWord(words, word + 34, first: 17, step: 51)
                markWord(words, word + 35, first: 4, step: 51)
                markWord(words, word + 36, first: 42, step: 51)
                markWord(words, word + 37, first: 29, step: 51)
                markWord(words, word + 38, first: 16, step: 51)
                markWord(words, word + 39, first: 3, step: 51)
                markWord(words, word + 40, first: 41, step: 51)
                markWord(words, word + 41, first: 28, step: 51)
                markWord(words, word + 42, first: 15, step: 51)
                markWord(words, word + 43, first: 2, step: 51)
                markWord(words, word + 44, first: 40, step: 51)
                markWord(words, word + 45, first: 27, step: 51)
                markWord(words, word + 46, first: 14, step: 51)
                markWord(words, word + 47, first: 1, step: 51)
                markWord(words, word + 48, first: 39, step: 51)
                markWord(words, word + 49, first: 26, step: 51)
                markWord(words, word + 50, first: 13, step: 51)
                word += 51
            }
        case 53:
            while word + 53 <= fullWords {
                markWord(words, word, first: 0, step: 53)
                markWord(words, word + 1, first: 42, step: 53)
                markWord(words, word + 2, first: 31, step: 53)
                markWord(words, word + 3, first: 20, step: 53)
                markWord(words, word + 4, first: 9, step: 53)
                markWord(words, word + 5, first: 51, step: 53)
                markWord(words, word + 6, first: 40, step: 53)
                markWord(words, word + 7, first: 29, step: 53)
                markWord(words, word + 8, first: 18, step: 53)
                markWord(words, word + 9, first: 7, step: 53)
                markWord(words, word + 10, first: 49, step: 53)
                markWord(words, word + 11, first: 38, step: 53)
                markWord(words, word + 12, first: 27, step: 53)
                markWord(words, word + 13, first: 16, step: 53)
                markWord(words, word + 14, first: 5, step: 53)
                markWord(words, word + 15, first: 47, step: 53)
                markWord(words, word + 16, first: 36, step: 53)
                markWord(words, word + 17, first: 25, step: 53)
                markWord(words, word + 18, first: 14, step: 53)
                markWord(words, word + 19, first: 3, step: 53)
                markWord(words, word + 20, first: 45, step: 53)
                markWord(words, word + 21, first: 34, step: 53)
                markWord(words, word + 22, first: 23, step: 53)
                markWord(words, word + 23, first: 12, step: 53)
                markWord(words, word + 24, first: 1, step: 53)
                markWord(words, word + 25, first: 43, step: 53)
                markWord(words, word + 26, first: 32, step: 53)
                markWord(words, word + 27, first: 21, step: 53)
                markWord(words, word + 28, first: 10, step: 53)
                markWord(words, word + 29, first: 52, step: 53)
                markWord(words, word + 30, first: 41, step: 53)
                markWord(words, word + 31, first: 30, step: 53)
                markWord(words, word + 32, first: 19, step: 53)
                markWord(words, word + 33, first: 8, step: 53)
                markWord(words, word + 34, first: 50, step: 53)
                markWord(words, word + 35, first: 39, step: 53)
                markWord(words, word + 36, first: 28, step: 53)
                markWord(words, word + 37, first: 17, step: 53)
                markWord(words, word + 38, first: 6, step: 53)
                markWord(words, word + 39, first: 48, step: 53)
                markWord(words, word + 40, first: 37, step: 53)
                markWord(words, word + 41, first: 26, step: 53)
                markWord(words, word + 42, first: 15, step: 53)
                markWord(words, word + 43, first: 4, step: 53)
                markWord(words, word + 44, first: 46, step: 53)
                markWord(words, word + 45, first: 35, step: 53)
                markWord(words, word + 46, first: 24, step: 53)
                markWord(words, word + 47, first: 13, step: 53)
                markWord(words, word + 48, first: 2, step: 53)
                markWord(words, word + 49, first: 44, step: 53)
                markWord(words, word + 50, first: 33, step: 53)
                markWord(words, word + 51, first: 22, step: 53)
                markWord(words, word + 52, first: 11, step: 53)
                word += 53
            }
        case 55:
            while word + 55 <= fullWords {
                markWord(words, word, first: 0, step: 55)
                markWord(words, word + 1, first: 46, step: 55)
                markWord(words, word + 2, first: 37, step: 55)
                markWord(words, word + 3, first: 28, step: 55)
                markWord(words, word + 4, first: 19, step: 55)
                markWord(words, word + 5, first: 10, step: 55)
                markWord(words, word + 6, first: 1, step: 55)
                markWord(words, word + 7, first: 47, step: 55)
                markWord(words, word + 8, first: 38, step: 55)
                markWord(words, word + 9, first: 29, step: 55)
                markWord(words, word + 10, first: 20, step: 55)
                markWord(words, word + 11, first: 11, step: 55)
                markWord(words, word + 12, first: 2, step: 55)
                markWord(words, word + 13, first: 48, step: 55)
                markWord(words, word + 14, first: 39, step: 55)
                markWord(words, word + 15, first: 30, step: 55)
                markWord(words, word + 16, first: 21, step: 55)
                markWord(words, word + 17, first: 12, step: 55)
                markWord(words, word + 18, first: 3, step: 55)
                markWord(words, word + 19, first: 49, step: 55)
                markWord(words, word + 20, first: 40, step: 55)
                markWord(words, word + 21, first: 31, step: 55)
                markWord(words, word + 22, first: 22, step: 55)
                markWord(words, word + 23, first: 13, step: 55)
                markWord(words, word + 24, first: 4, step: 55)
                markWord(words, word + 25, first: 50, step: 55)
                markWord(words, word + 26, first: 41, step: 55)
                markWord(words, word + 27, first: 32, step: 55)
                markWord(words, word + 28, first: 23, step: 55)
                markWord(words, word + 29, first: 14, step: 55)
                markWord(words, word + 30, first: 5, step: 55)
                markWord(words, word + 31, first: 51, step: 55)
                markWord(words, word + 32, first: 42, step: 55)
                markWord(words, word + 33, first: 33, step: 55)
                markWord(words, word + 34, first: 24, step: 55)
                markWord(words, word + 35, first: 15, step: 55)
                markWord(words, word + 36, first: 6, step: 55)
                markWord(words, word + 37, first: 52, step: 55)
                markWord(words, word + 38, first: 43, step: 55)
                markWord(words, word + 39, first: 34, step: 55)
                markWord(words, word + 40, first: 25, step: 55)
                markWord(words, word + 41, first: 16, step: 55)
                markWord(words, word + 42, first: 7, step: 55)
                markWord(words, word + 43, first: 53, step: 55)
                markWord(words, word + 44, first: 44, step: 55)
                markWord(words, word + 45, first: 35, step: 55)
                markWord(words, word + 46, first: 26, step: 55)
                markWord(words, word + 47, first: 17, step: 55)
                markWord(words, word + 48, first: 8, step: 55)
                markWord(words, word + 49, first: 54, step: 55)
                markWord(words, word + 50, first: 45, step: 55)
                markWord(words, word + 51, first: 36, step: 55)
                markWord(words, word + 52, first: 27, step: 55)
                markWord(words, word + 53, first: 18, step: 55)
                markWord(words, word + 54, first: 9, step: 55)
                word += 55
            }
        case 57:
            while word + 57 <= fullWords {
                markWord(words, word, first: 0, step: 57)
                markWord(words, word + 1, first: 50, step: 57)
                markWord(words, word + 2, first: 43, step: 57)
                markWord(words, word + 3, first: 36, step: 57)
                markWord(words, word + 4, first: 29, step: 57)
                markWord(words, word + 5, first: 22, step: 57)
                markWord(words, word + 6, first: 15, step: 57)
                markWord(words, word + 7, first: 8, step: 57)
                markWord(words, word + 8, first: 1, step: 57)
                markWord(words, word + 9, first: 51, step: 57)
                markWord(words, word + 10, first: 44, step: 57)
                markWord(words, word + 11, first: 37, step: 57)
                markWord(words, word + 12, first: 30, step: 57)
                markWord(words, word + 13, first: 23, step: 57)
                markWord(words, word + 14, first: 16, step: 57)
                markWord(words, word + 15, first: 9, step: 57)
                markWord(words, word + 16, first: 2, step: 57)
                markWord(words, word + 17, first: 52, step: 57)
                markWord(words, word + 18, first: 45, step: 57)
                markWord(words, word + 19, first: 38, step: 57)
                markWord(words, word + 20, first: 31, step: 57)
                markWord(words, word + 21, first: 24, step: 57)
                markWord(words, word + 22, first: 17, step: 57)
                markWord(words, word + 23, first: 10, step: 57)
                markWord(words, word + 24, first: 3, step: 57)
                markWord(words, word + 25, first: 53, step: 57)
                markWord(words, word + 26, first: 46, step: 57)
                markWord(words, word + 27, first: 39, step: 57)
                markWord(words, word + 28, first: 32, step: 57)
                markWord(words, word + 29, first: 25, step: 57)
                markWord(words, word + 30, first: 18, step: 57)
                markWord(words, word + 31, first: 11, step: 57)
                markWord(words, word + 32, first: 4, step: 57)
                markWord(words, word + 33, first: 54, step: 57)
                markWord(words, word + 34, first: 47, step: 57)
                markWord(words, word + 35, first: 40, step: 57)
                markWord(words, word + 36, first: 33, step: 57)
                markWord(words, word + 37, first: 26, step: 57)
                markWord(words, word + 38, first: 19, step: 57)
                markWord(words, word + 39, first: 12, step: 57)
                markWord(words, word + 40, first: 5, step: 57)
                markWord(words, word + 41, first: 55, step: 57)
                markWord(words, word + 42, first: 48, step: 57)
                markWord(words, word + 43, first: 41, step: 57)
                markWord(words, word + 44, first: 34, step: 57)
                markWord(words, word + 45, first: 27, step: 57)
                markWord(words, word + 46, first: 20, step: 57)
                markWord(words, word + 47, first: 13, step: 57)
                markWord(words, word + 48, first: 6, step: 57)
                markWord(words, word + 49, first: 56, step: 57)
                markWord(words, word + 50, first: 49, step: 57)
                markWord(words, word + 51, first: 42, step: 57)
                markWord(words, word + 52, first: 35, step: 57)
                markWord(words, word + 53, first: 28, step: 57)
                markWord(words, word + 54, first: 21, step: 57)
                markWord(words, word + 55, first: 14, step: 57)
                markWord(words, word + 56, first: 7, step: 57)
                word += 57
            }
        case 59:
            while word + 59 <= fullWords {
                markWord(words, word, first: 0, step: 59)
                markWord(words, word + 1, first: 54, step: 59)
                markWord(words, word + 2, first: 49, step: 59)
                markWord(words, word + 3, first: 44, step: 59)
                markWord(words, word + 4, first: 39, step: 59)
                markWord(words, word + 5, first: 34, step: 59)
                markWord(words, word + 6, first: 29, step: 59)
                markWord(words, word + 7, first: 24, step: 59)
                markWord(words, word + 8, first: 19, step: 59)
                markWord(words, word + 9, first: 14, step: 59)
                markWord(words, word + 10, first: 9, step: 59)
                markWord(words, word + 11, first: 4, step: 59)
                markWord(words, word + 12, first: 58, step: 59)
                markWord(words, word + 13, first: 53, step: 59)
                markWord(words, word + 14, first: 48, step: 59)
                markWord(words, word + 15, first: 43, step: 59)
                markWord(words, word + 16, first: 38, step: 59)
                markWord(words, word + 17, first: 33, step: 59)
                markWord(words, word + 18, first: 28, step: 59)
                markWord(words, word + 19, first: 23, step: 59)
                markWord(words, word + 20, first: 18, step: 59)
                markWord(words, word + 21, first: 13, step: 59)
                markWord(words, word + 22, first: 8, step: 59)
                markWord(words, word + 23, first: 3, step: 59)
                markWord(words, word + 24, first: 57, step: 59)
                markWord(words, word + 25, first: 52, step: 59)
                markWord(words, word + 26, first: 47, step: 59)
                markWord(words, word + 27, first: 42, step: 59)
                markWord(words, word + 28, first: 37, step: 59)
                markWord(words, word + 29, first: 32, step: 59)
                markWord(words, word + 30, first: 27, step: 59)
                markWord(words, word + 31, first: 22, step: 59)
                markWord(words, word + 32, first: 17, step: 59)
                markWord(words, word + 33, first: 12, step: 59)
                markWord(words, word + 34, first: 7, step: 59)
                markWord(words, word + 35, first: 2, step: 59)
                markWord(words, word + 36, first: 56, step: 59)
                markWord(words, word + 37, first: 51, step: 59)
                markWord(words, word + 38, first: 46, step: 59)
                markWord(words, word + 39, first: 41, step: 59)
                markWord(words, word + 40, first: 36, step: 59)
                markWord(words, word + 41, first: 31, step: 59)
                markWord(words, word + 42, first: 26, step: 59)
                markWord(words, word + 43, first: 21, step: 59)
                markWord(words, word + 44, first: 16, step: 59)
                markWord(words, word + 45, first: 11, step: 59)
                markWord(words, word + 46, first: 6, step: 59)
                markWord(words, word + 47, first: 1, step: 59)
                markWord(words, word + 48, first: 55, step: 59)
                markWord(words, word + 49, first: 50, step: 59)
                markWord(words, word + 50, first: 45, step: 59)
                markWord(words, word + 51, first: 40, step: 59)
                markWord(words, word + 52, first: 35, step: 59)
                markWord(words, word + 53, first: 30, step: 59)
                markWord(words, word + 54, first: 25, step: 59)
                markWord(words, word + 55, first: 20, step: 59)
                markWord(words, word + 56, first: 15, step: 59)
                markWord(words, word + 57, first: 10, step: 59)
                markWord(words, word + 58, first: 5, step: 59)
                word += 59
            }
        case 61:
            while word + 61 <= fullWords {
                markWord(words, word, first: 0, step: 61)
                markWord(words, word + 1, first: 58, step: 61)
                markWord(words, word + 2, first: 55, step: 61)
                markWord(words, word + 3, first: 52, step: 61)
                markWord(words, word + 4, first: 49, step: 61)
                markWord(words, word + 5, first: 46, step: 61)
                markWord(words, word + 6, first: 43, step: 61)
                markWord(words, word + 7, first: 40, step: 61)
                markWord(words, word + 8, first: 37, step: 61)
                markWord(words, word + 9, first: 34, step: 61)
                markWord(words, word + 10, first: 31, step: 61)
                markWord(words, word + 11, first: 28, step: 61)
                markWord(words, word + 12, first: 25, step: 61)
                markWord(words, word + 13, first: 22, step: 61)
                markWord(words, word + 14, first: 19, step: 61)
                markWord(words, word + 15, first: 16, step: 61)
                markWord(words, word + 16, first: 13, step: 61)
                markWord(words, word + 17, first: 10, step: 61)
                markWord(words, word + 18, first: 7, step: 61)
                markWord(words, word + 19, first: 4, step: 61)
                markWord(words, word + 20, first: 1, step: 61)
                markWord(words, word + 21, first: 59, step: 61)
                markWord(words, word + 22, first: 56, step: 61)
                markWord(words, word + 23, first: 53, step: 61)
                markWord(words, word + 24, first: 50, step: 61)
                markWord(words, word + 25, first: 47, step: 61)
                markWord(words, word + 26, first: 44, step: 61)
                markWord(words, word + 27, first: 41, step: 61)
                markWord(words, word + 28, first: 38, step: 61)
                markWord(words, word + 29, first: 35, step: 61)
                markWord(words, word + 30, first: 32, step: 61)
                markWord(words, word + 31, first: 29, step: 61)
                markWord(words, word + 32, first: 26, step: 61)
                markWord(words, word + 33, first: 23, step: 61)
                markWord(words, word + 34, first: 20, step: 61)
                markWord(words, word + 35, first: 17, step: 61)
                markWord(words, word + 36, first: 14, step: 61)
                markWord(words, word + 37, first: 11, step: 61)
                markWord(words, word + 38, first: 8, step: 61)
                markWord(words, word + 39, first: 5, step: 61)
                markWord(words, word + 40, first: 2, step: 61)
                markWord(words, word + 41, first: 60, step: 61)
                markWord(words, word + 42, first: 57, step: 61)
                markWord(words, word + 43, first: 54, step: 61)
                markWord(words, word + 44, first: 51, step: 61)
                markWord(words, word + 45, first: 48, step: 61)
                markWord(words, word + 46, first: 45, step: 61)
                markWord(words, word + 47, first: 42, step: 61)
                markWord(words, word + 48, first: 39, step: 61)
                markWord(words, word + 49, first: 36, step: 61)
                markWord(words, word + 50, first: 33, step: 61)
                markWord(words, word + 51, first: 30, step: 61)
                markWord(words, word + 52, first: 27, step: 61)
                markWord(words, word + 53, first: 24, step: 61)
                markWord(words, word + 54, first: 21, step: 61)
                markWord(words, word + 55, first: 18, step: 61)
                markWord(words, word + 56, first: 15, step: 61)
                markWord(words, word + 57, first: 12, step: 61)
                markWord(words, word + 58, first: 9, step: 61)
                markWord(words, word + 59, first: 6, step: 61)
                markWord(words, word + 60, first: 3, step: 61)
                word += 61
            }
        case 63:
            while word + 63 <= fullWords {
                markWord(words, word, first: 0, step: 63)
                markWord(words, word + 1, first: 62, step: 63)
                markWord(words, word + 2, first: 61, step: 63)
                markWord(words, word + 3, first: 60, step: 63)
                markWord(words, word + 4, first: 59, step: 63)
                markWord(words, word + 5, first: 58, step: 63)
                markWord(words, word + 6, first: 57, step: 63)
                markWord(words, word + 7, first: 56, step: 63)
                markWord(words, word + 8, first: 55, step: 63)
                markWord(words, word + 9, first: 54, step: 63)
                markWord(words, word + 10, first: 53, step: 63)
                markWord(words, word + 11, first: 52, step: 63)
                markWord(words, word + 12, first: 51, step: 63)
                markWord(words, word + 13, first: 50, step: 63)
                markWord(words, word + 14, first: 49, step: 63)
                markWord(words, word + 15, first: 48, step: 63)
                markWord(words, word + 16, first: 47, step: 63)
                markWord(words, word + 17, first: 46, step: 63)
                markWord(words, word + 18, first: 45, step: 63)
                markWord(words, word + 19, first: 44, step: 63)
                markWord(words, word + 20, first: 43, step: 63)
                markWord(words, word + 21, first: 42, step: 63)
                markWord(words, word + 22, first: 41, step: 63)
                markWord(words, word + 23, first: 40, step: 63)
                markWord(words, word + 24, first: 39, step: 63)
                markWord(words, word + 25, first: 38, step: 63)
                markWord(words, word + 26, first: 37, step: 63)
                markWord(words, word + 27, first: 36, step: 63)
                markWord(words, word + 28, first: 35, step: 63)
                markWord(words, word + 29, first: 34, step: 63)
                markWord(words, word + 30, first: 33, step: 63)
                markWord(words, word + 31, first: 32, step: 63)
                markWord(words, word + 32, first: 31, step: 63)
                markWord(words, word + 33, first: 30, step: 63)
                markWord(words, word + 34, first: 29, step: 63)
                markWord(words, word + 35, first: 28, step: 63)
                markWord(words, word + 36, first: 27, step: 63)
                markWord(words, word + 37, first: 26, step: 63)
                markWord(words, word + 38, first: 25, step: 63)
                markWord(words, word + 39, first: 24, step: 63)
                markWord(words, word + 40, first: 23, step: 63)
                markWord(words, word + 41, first: 22, step: 63)
                markWord(words, word + 42, first: 21, step: 63)
                markWord(words, word + 43, first: 20, step: 63)
                markWord(words, word + 44, first: 19, step: 63)
                markWord(words, word + 45, first: 18, step: 63)
                markWord(words, word + 46, first: 17, step: 63)
                markWord(words, word + 47, first: 16, step: 63)
                markWord(words, word + 48, first: 15, step: 63)
                markWord(words, word + 49, first: 14, step: 63)
                markWord(words, word + 50, first: 13, step: 63)
                markWord(words, word + 51, first: 12, step: 63)
                markWord(words, word + 52, first: 11, step: 63)
                markWord(words, word + 53, first: 10, step: 63)
                markWord(words, word + 54, first: 9, step: 63)
                markWord(words, word + 55, first: 8, step: 63)
                markWord(words, word + 56, first: 7, step: 63)
                markWord(words, word + 57, first: 6, step: 63)
                markWord(words, word + 58, first: 5, step: 63)
                markWord(words, word + 59, first: 4, step: 63)
                markWord(words, word + 60, first: 3, step: 63)
                markWord(words, word + 61, first: 2, step: 63)
                markWord(words, word + 62, first: 1, step: 63)
                word += 63
            }
        default:
            preconditionFailure("Word-dense marking requires an odd factor from 5 to 63")
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

    /// Dense marking on 128-bit chunks for every odd factor from 65 through 111.
    /// Called only after the ordinary runtime candidate-bit test. Each chunk has
    /// one or two multiples; their offsets advance by a runtime recurrence.
    private func markVectorDenseMultiples(of p: Int) {
        let bytes = storage
        // Match the former sparse path through the entire last allocated byte,
        // including padding (for example 1,000,001 is marked by factor 101).
        let bitEnd = byteCount << 3
        var bit = (p * p - 3) / 2

        // Odd p is coprime to 128: at most 127 individual marks reach a boundary.
        while bit < bitEnd && bit & 127 != 0 {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
        guard bit < bitEnd else { return }

        let words = UnsafeMutableRawPointer(bytes)
        var word = bit >> 7
        let fullWords = byteCount >> 4
        var first = 0

        while word < fullWords {
            // 0 <= word < byteCount / 16, so 16 * word <= byteCount - 16.
            // The wrapping offset is exact; unaligned access needs no SIMD alignment.
            let offset = word &* 16
            var value = words.loadUnaligned(fromByteOffset: offset, as: SIMD2<UInt64>.self)
            value[0] = UInt64(littleEndian: value[0])
            value[1] = UInt64(littleEndian: value[1])

            // 0 <= first < p < 128 keeps the first lane index in 0...1.
            value[first >> 6] |= UInt64(1) << (first & 63)
            // p > 64 puts a possible second mark in lane 1. Ordinary << yields
            // zero for shifts >= 64, so an out-of-chunk second mark changes no bit.
            value[1] |= UInt64(1) << (first + p - 64)

            value[0] = value[0].littleEndian
            value[1] = value[1].littleEndian
            words.storeBytes(of: value, toByteOffset: offset, as: SIMD2<UInt64>.self)

            // Consume one mark if first+p >= 128, otherwise two. Since 64 < p
            // < 128, the next chunk's first mark again lies in 0..<p.
            let t = first + p - 128
            first = t < 0 ? t + p : t
            word += 1
        }

        // An arbitrary chunk can end the loop. Resume at its next unmarked
        // multiple, not its bit zero; at most two marks fit in the partial chunk.
        bit = word * 128 + first
        while bit < bitEnd {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
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
