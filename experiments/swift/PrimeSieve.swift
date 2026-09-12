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
                for j in 0..<5 {
                    markWord(words, word + j, first: (5 - (64 * j) % 5) % 5, step: 5)
                }
                word += 5
            }
        case 7:
            while word + 7 <= fullWords {
                for j in 0..<7 {
                    markWord(words, word + j, first: (7 - (64 * j) % 7) % 7, step: 7)
                }
                word += 7
            }
        case 9:
            while word + 9 <= fullWords {
                for j in 0..<9 {
                    markWord(words, word + j, first: (9 - (64 * j) % 9) % 9, step: 9)
                }
                word += 9
            }
        case 11:
            while word + 11 <= fullWords {
                for j in 0..<11 {
                    markWord(words, word + j, first: (11 - (64 * j) % 11) % 11, step: 11)
                }
                word += 11
            }
        case 13:
            while word + 13 <= fullWords {
                for j in 0..<13 {
                    markWord(words, word + j, first: (13 - (64 * j) % 13) % 13, step: 13)
                }
                word += 13
            }
        case 15:
            while word + 15 <= fullWords {
                for j in 0..<15 {
                    markWord(words, word + j, first: (15 - (64 * j) % 15) % 15, step: 15)
                }
                word += 15
            }
        case 17:
            while word + 17 <= fullWords {
                for j in 0..<17 {
                    markWord(words, word + j, first: (17 - (64 * j) % 17) % 17, step: 17)
                }
                word += 17
            }
        case 19:
            while word + 19 <= fullWords {
                for j in 0..<19 {
                    markWord(words, word + j, first: (19 - (64 * j) % 19) % 19, step: 19)
                }
                word += 19
            }
        case 21:
            while word + 21 <= fullWords {
                for j in 0..<21 {
                    markWord(words, word + j, first: (21 - (64 * j) % 21) % 21, step: 21)
                }
                word += 21
            }
        case 23:
            while word + 23 <= fullWords {
                for j in 0..<23 {
                    markWord(words, word + j, first: (23 - (64 * j) % 23) % 23, step: 23)
                }
                word += 23
            }
        case 25:
            while word + 25 <= fullWords {
                for j in 0..<25 {
                    markWord(words, word + j, first: (25 - (64 * j) % 25) % 25, step: 25)
                }
                word += 25
            }
        case 27:
            while word + 27 <= fullWords {
                for j in 0..<27 {
                    markWord(words, word + j, first: (27 - (64 * j) % 27) % 27, step: 27)
                }
                word += 27
            }
        case 29:
            while word + 29 <= fullWords {
                for j in 0..<29 {
                    markWord(words, word + j, first: (29 - (64 * j) % 29) % 29, step: 29)
                }
                word += 29
            }
        case 31:
            while word + 31 <= fullWords {
                for j in 0..<31 {
                    markWord(words, word + j, first: (31 - (64 * j) % 31) % 31, step: 31)
                }
                word += 31
            }
        case 33:
            while word + 33 <= fullWords {
                for j in 0..<33 {
                    markWord(words, word + j, first: (33 - (64 * j) % 33) % 33, step: 33)
                }
                word += 33
            }
        case 35:
            while word + 35 <= fullWords {
                for j in 0..<35 {
                    markWord(words, word + j, first: (35 - (64 * j) % 35) % 35, step: 35)
                }
                word += 35
            }
        case 37:
            while word + 37 <= fullWords {
                for j in 0..<37 {
                    markWord(words, word + j, first: (37 - (64 * j) % 37) % 37, step: 37)
                }
                word += 37
            }
        case 39:
            while word + 39 <= fullWords {
                for j in 0..<39 {
                    markWord(words, word + j, first: (39 - (64 * j) % 39) % 39, step: 39)
                }
                word += 39
            }
        case 41:
            while word + 41 <= fullWords {
                for j in 0..<41 {
                    markWord(words, word + j, first: (41 - (64 * j) % 41) % 41, step: 41)
                }
                word += 41
            }
        case 43:
            while word + 43 <= fullWords {
                for j in 0..<43 {
                    markWord(words, word + j, first: (43 - (64 * j) % 43) % 43, step: 43)
                }
                word += 43
            }
        case 45:
            while word + 45 <= fullWords {
                for j in 0..<45 {
                    markWord(words, word + j, first: (45 - (64 * j) % 45) % 45, step: 45)
                }
                word += 45
            }
        case 47:
            while word + 47 <= fullWords {
                for j in 0..<47 {
                    markWord(words, word + j, first: (47 - (64 * j) % 47) % 47, step: 47)
                }
                word += 47
            }
        case 49:
            while word + 49 <= fullWords {
                for j in 0..<49 {
                    markWord(words, word + j, first: (49 - (64 * j) % 49) % 49, step: 49)
                }
                word += 49
            }
        case 51:
            while word + 51 <= fullWords {
                for j in 0..<51 {
                    markWord(words, word + j, first: (51 - (64 * j) % 51) % 51, step: 51)
                }
                word += 51
            }
        case 53:
            while word + 53 <= fullWords {
                for j in 0..<53 {
                    markWord(words, word + j, first: (53 - (64 * j) % 53) % 53, step: 53)
                }
                word += 53
            }
        case 55:
            while word + 55 <= fullWords {
                for j in 0..<55 {
                    markWord(words, word + j, first: (55 - (64 * j) % 55) % 55, step: 55)
                }
                word += 55
            }
        case 57:
            while word + 57 <= fullWords {
                for j in 0..<57 {
                    markWord(words, word + j, first: (57 - (64 * j) % 57) % 57, step: 57)
                }
                word += 57
            }
        case 59:
            while word + 59 <= fullWords {
                for j in 0..<59 {
                    markWord(words, word + j, first: (59 - (64 * j) % 59) % 59, step: 59)
                }
                word += 59
            }
        case 61:
            while word + 61 <= fullWords {
                for j in 0..<61 {
                    markWord(words, word + j, first: (61 - (64 * j) % 61) % 61, step: 61)
                }
                word += 61
            }
        case 63:
            while word + 63 <= fullWords {
                for j in 0..<63 {
                    markWord(words, word + j, first: (63 - (64 * j) % 63) % 63, step: 63)
                }
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
    /// Called only after the ordinary runtime candidate-bit test. No prime list or
    /// composite pattern is encoded: each generated case supplies bit offsets.
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

        // 128 consecutive marks span p complete 128-bit chunks. In chunk j,
        // the first mark is (-128 * j) mod p, followed by increments of p.
        // Group bounds require all 16 bytes of every load/store to exist.
        // BEGIN GENERATED DENSE 128
        switch p {
        case 65:
            while word + 65 <= fullWords {
                for j in 0..<65 {
                    markVectorWord(words, word + j, first: (65 - (128 * j) % 65) % 65, step: 65)
                }
                word += 65
            }
        case 67:
            while word + 67 <= fullWords {
                for j in 0..<67 {
                    markVectorWord(words, word + j, first: (67 - (128 * j) % 67) % 67, step: 67)
                }
                word += 67
            }
        case 69:
            while word + 69 <= fullWords {
                for j in 0..<69 {
                    markVectorWord(words, word + j, first: (69 - (128 * j) % 69) % 69, step: 69)
                }
                word += 69
            }
        case 71:
            while word + 71 <= fullWords {
                for j in 0..<71 {
                    markVectorWord(words, word + j, first: (71 - (128 * j) % 71) % 71, step: 71)
                }
                word += 71
            }
        case 73:
            while word + 73 <= fullWords {
                for j in 0..<73 {
                    markVectorWord(words, word + j, first: (73 - (128 * j) % 73) % 73, step: 73)
                }
                word += 73
            }
        case 75:
            while word + 75 <= fullWords {
                for j in 0..<75 {
                    markVectorWord(words, word + j, first: (75 - (128 * j) % 75) % 75, step: 75)
                }
                word += 75
            }
        case 77:
            while word + 77 <= fullWords {
                for j in 0..<77 {
                    markVectorWord(words, word + j, first: (77 - (128 * j) % 77) % 77, step: 77)
                }
                word += 77
            }
        case 79:
            while word + 79 <= fullWords {
                for j in 0..<79 {
                    markVectorWord(words, word + j, first: (79 - (128 * j) % 79) % 79, step: 79)
                }
                word += 79
            }
        case 81:
            while word + 81 <= fullWords {
                for j in 0..<81 {
                    markVectorWord(words, word + j, first: (81 - (128 * j) % 81) % 81, step: 81)
                }
                word += 81
            }
        case 83:
            while word + 83 <= fullWords {
                for j in 0..<83 {
                    markVectorWord(words, word + j, first: (83 - (128 * j) % 83) % 83, step: 83)
                }
                word += 83
            }
        case 85:
            while word + 85 <= fullWords {
                for j in 0..<85 {
                    markVectorWord(words, word + j, first: (85 - (128 * j) % 85) % 85, step: 85)
                }
                word += 85
            }
        case 87:
            while word + 87 <= fullWords {
                for j in 0..<87 {
                    markVectorWord(words, word + j, first: (87 - (128 * j) % 87) % 87, step: 87)
                }
                word += 87
            }
        case 89:
            while word + 89 <= fullWords {
                for j in 0..<89 {
                    markVectorWord(words, word + j, first: (89 - (128 * j) % 89) % 89, step: 89)
                }
                word += 89
            }
        case 91:
            while word + 91 <= fullWords {
                for j in 0..<91 {
                    markVectorWord(words, word + j, first: (91 - (128 * j) % 91) % 91, step: 91)
                }
                word += 91
            }
        case 93:
            while word + 93 <= fullWords {
                for j in 0..<93 {
                    markVectorWord(words, word + j, first: (93 - (128 * j) % 93) % 93, step: 93)
                }
                word += 93
            }
        case 95:
            while word + 95 <= fullWords {
                for j in 0..<95 {
                    markVectorWord(words, word + j, first: (95 - (128 * j) % 95) % 95, step: 95)
                }
                word += 95
            }
        case 97:
            while word + 97 <= fullWords {
                for j in 0..<97 {
                    markVectorWord(words, word + j, first: (97 - (128 * j) % 97) % 97, step: 97)
                }
                word += 97
            }
        case 99:
            while word + 99 <= fullWords {
                for j in 0..<99 {
                    markVectorWord(words, word + j, first: (99 - (128 * j) % 99) % 99, step: 99)
                }
                word += 99
            }
        case 101:
            while word + 101 <= fullWords {
                for j in 0..<101 {
                    markVectorWord(words, word + j, first: (101 - (128 * j) % 101) % 101, step: 101)
                }
                word += 101
            }
        case 103:
            while word + 103 <= fullWords {
                for j in 0..<103 {
                    markVectorWord(words, word + j, first: (103 - (128 * j) % 103) % 103, step: 103)
                }
                word += 103
            }
        case 105:
            while word + 105 <= fullWords {
                for j in 0..<105 {
                    markVectorWord(words, word + j, first: (105 - (128 * j) % 105) % 105, step: 105)
                }
                word += 105
            }
        case 107:
            while word + 107 <= fullWords {
                for j in 0..<107 {
                    markVectorWord(words, word + j, first: (107 - (128 * j) % 107) % 107, step: 107)
                }
                word += 107
            }
        case 109:
            while word + 109 <= fullWords {
                for j in 0..<109 {
                    markVectorWord(words, word + j, first: (109 - (128 * j) % 109) % 109, step: 109)
                }
                word += 109
            }
        case 111:
            while word + 111 <= fullWords {
                for j in 0..<111 {
                    markVectorWord(words, word + j, first: (111 - (128 * j) % 111) % 111, step: 111)
                }
                word += 111
            }
        default:
            preconditionFailure("Vector-dense marking requires an odd factor from 65 to 111")
        }
        // END GENERATED DENSE 128

        // At most 128 marks remain, including any partial chunk and byte padding.
        bit = word * 128
        while bit < bitEnd {
            bytes[bit >> 3] |= UInt8(1) << (bit & 7)
            bit += p
        }
    }

    /// A 128-bit local value with two UInt64 lanes. Each multiple receives its own
    /// single-bit OR; the compiler may combine those operations. Unaligned raw
    /// access avoids assuming the byte allocation has SIMD alignment. Convert each
    /// lane separately so the byte/bit order remains little-endian on every host.
    @inline(__always)
    private func markVectorWord(
        _ words: UnsafeMutableRawPointer, _ word: Int, first: Int, step p: Int
    ) {
        // Callers guarantee 0 <= word < byteCount / 16, hence
        // 16 * word <= byteCount - 16; wrapping cannot change the offset.
        let offset = word &* 16
        var value = words.loadUnaligned(fromByteOffset: offset, as: SIMD2<UInt64>.self)
        value[0] = UInt64(littleEndian: value[0])
        value[1] = UInt64(littleEndian: value[1])
        var bit = first
        while bit < 128 {
            value[bit >> 6] |= UInt64(1) << (bit & 63)
            bit += p
        }
        value[0] = value[0].littleEndian
        value[1] = value[1].littleEndian
        words.storeBytes(of: value, toByteOffset: offset, as: SIMD2<UInt64>.self)
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
