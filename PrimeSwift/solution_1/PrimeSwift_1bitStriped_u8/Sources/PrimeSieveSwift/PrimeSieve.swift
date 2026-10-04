/// An odd-only Eratosthenes sieve with byte-striped composite marking.
/// Every instance owns a freshly allocated sieve; no sieve state is cached.
final class PrimeSieve {
    private let limit: Int
    private let oddCount: Int
    private let byteCount: Int
    private let storage: UnsafeMutablePointer<UInt8>

    /// Logical counts only; an empty sieve still allocates one physical byte.
    struct StorageLayout {
        let oddCount: Int

        var byteCount: Int {
            @inline(__always) get {
                oddCount / 8 + (oddCount % 8 == 0 ? 0 : 1)
            }
        }
    }

    @inline(__always)
    static func storageLayout(for limit: Int) -> StorageLayout {
        StorageLayout(oddCount: limit >= 3 ? (limit - 1) / 2 : 0)
    }

    init(limit: Int) {
        let layout = Self.storageLayout(for: limit)
        self.limit = limit
        oddCount = layout.oddCount
        byteCount = layout.byteCount
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
        // the next mark starts the next p-word group. Each case names its factor as
        // a compile-time constant, so WordDense gets its own copy for that factor.
        switch p {
        case 5: WordDense<5>.markGroups(words, &word, fullWords: fullWords)
        case 7: WordDense<7>.markGroups(words, &word, fullWords: fullWords)
        case 9: WordDense<9>.markGroups(words, &word, fullWords: fullWords)
        case 11: WordDense<11>.markGroups(words, &word, fullWords: fullWords)
        case 13: WordDense<13>.markGroups(words, &word, fullWords: fullWords)
        case 15: WordDense<15>.markGroups(words, &word, fullWords: fullWords)
        case 17: WordDense<17>.markGroups(words, &word, fullWords: fullWords)
        case 19: WordDense<19>.markGroups(words, &word, fullWords: fullWords)
        case 21: WordDense<21>.markGroups(words, &word, fullWords: fullWords)
        case 23: WordDense<23>.markGroups(words, &word, fullWords: fullWords)
        case 25: WordDense<25>.markGroups(words, &word, fullWords: fullWords)
        case 27: WordDense<27>.markGroups(words, &word, fullWords: fullWords)
        case 29: WordDense<29>.markGroups(words, &word, fullWords: fullWords)
        case 31: WordDense<31>.markGroups(words, &word, fullWords: fullWords)
        case 33: WordDense<33>.markGroups(words, &word, fullWords: fullWords)
        case 35: WordDense<35>.markGroups(words, &word, fullWords: fullWords)
        case 37: WordDense<37>.markGroups(words, &word, fullWords: fullWords)
        case 39: WordDense<39>.markGroups(words, &word, fullWords: fullWords)
        case 41: WordDense<41>.markGroups(words, &word, fullWords: fullWords)
        case 43: WordDense<43>.markGroups(words, &word, fullWords: fullWords)
        case 45: WordDense<45>.markGroups(words, &word, fullWords: fullWords)
        case 47: WordDense<47>.markGroups(words, &word, fullWords: fullWords)
        case 49: WordDense<49>.markGroups(words, &word, fullWords: fullWords)
        case 51: WordDense<51>.markGroups(words, &word, fullWords: fullWords)
        case 53: WordDense<53>.markGroups(words, &word, fullWords: fullWords)
        case 55: WordDense<55>.markGroups(words, &word, fullWords: fullWords)
        case 57: WordDense<57>.markGroups(words, &word, fullWords: fullWords)
        case 59: WordDense<59>.markGroups(words, &word, fullWords: fullWords)
        case 61: WordDense<61>.markGroups(words, &word, fullWords: fullWords)
        case 63: WordDense<63>.markGroups(words, &word, fullWords: fullWords)
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

    /// Dense marking on 128-bit chunks for every odd factor from 65 through 111.
    /// Called only after the ordinary runtime candidate-bit test. No prime list or
    /// composite pattern is encoded: VectorDense derives each bit offset from p.
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

        // 128 consecutive marks span p complete 128-bit chunks. Group bounds
        // require all 16 bytes of every load/store to exist. Each case names its
        // factor as a compile-time constant, as in markWordDenseMultiples.
        switch p {
        case 65: VectorDense<65>.markGroups(words, &word, fullWords: fullWords)
        case 67: VectorDense<67>.markGroups(words, &word, fullWords: fullWords)
        case 69: VectorDense<69>.markGroups(words, &word, fullWords: fullWords)
        case 71: VectorDense<71>.markGroups(words, &word, fullWords: fullWords)
        case 73: VectorDense<73>.markGroups(words, &word, fullWords: fullWords)
        case 75: VectorDense<75>.markGroups(words, &word, fullWords: fullWords)
        case 77: VectorDense<77>.markGroups(words, &word, fullWords: fullWords)
        case 79: VectorDense<79>.markGroups(words, &word, fullWords: fullWords)
        case 81: VectorDense<81>.markGroups(words, &word, fullWords: fullWords)
        case 83: VectorDense<83>.markGroups(words, &word, fullWords: fullWords)
        case 85: VectorDense<85>.markGroups(words, &word, fullWords: fullWords)
        case 87: VectorDense<87>.markGroups(words, &word, fullWords: fullWords)
        case 89: VectorDense<89>.markGroups(words, &word, fullWords: fullWords)
        case 91: VectorDense<91>.markGroups(words, &word, fullWords: fullWords)
        case 93: VectorDense<93>.markGroups(words, &word, fullWords: fullWords)
        case 95: VectorDense<95>.markGroups(words, &word, fullWords: fullWords)
        case 97: VectorDense<97>.markGroups(words, &word, fullWords: fullWords)
        case 99: VectorDense<99>.markGroups(words, &word, fullWords: fullWords)
        case 101: VectorDense<101>.markGroups(words, &word, fullWords: fullWords)
        case 103: VectorDense<103>.markGroups(words, &word, fullWords: fullWords)
        case 105: VectorDense<105>.markGroups(words, &word, fullWords: fullWords)
        case 107: VectorDense<107>.markGroups(words, &word, fullWords: fullWords)
        case 109: VectorDense<109>.markGroups(words, &word, fullWords: fullWords)
        case 111: VectorDense<111>.markGroups(words, &word, fullWords: fullWords)
        default:
            preconditionFailure("Vector-dense marking requires an odd factor from 65 to 111")
        }

        // At most 128 marks remain, including any partial chunk and byte padding.
        bit = word * 128
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

/// Dense marking for one odd factor p from 5 through 63 on 64-bit words. Each
/// factor gets its own specialized copy, in which p and every bit offset below are
/// constants, so the compiler can unroll a group and merge each word's marks.
private enum WordDense<let p: Int> {
    /// Marks complete p-word groups from `word`, whose bit 0 holds a multiple, while
    /// a whole group fits below `fullWords`. Word j of a group has its first
    /// multiple at bit (-64 * j) mod p.
    @inline(__always)
    static func markGroups(_ words: UnsafeMutableRawPointer, _ word: inout Int, fullWords: Int) {
        while word + p <= fullWords {
            var chunk = 0
            while chunk < p {
                markWord(words, word + chunk, first: (p - (64 * chunk) % p) % p)
                chunk += 1
            }
            word += p
        }
    }

    /// Marks each multiple of p within one 64-bit word individually, starting at
    /// bit `first`, then stores the word once. The word is read and written
    /// little-endian, so its bit i is bit i & 7 of its byte i >> 3, as elsewhere.
    @inline(__always)
    private static func markWord(_ words: UnsafeMutableRawPointer, _ word: Int, first: Int) {
        let offset = word * 8
        var value = UInt64(littleEndian: words.loadUnaligned(fromByteOffset: offset, as: UInt64.self))
        var bit = first
        while bit < 64 {
            value |= 1 << bit
            bit += p
        }
        words.storeBytes(of: value.littleEndian, toByteOffset: offset, as: UInt64.self)
    }
}

/// Dense marking for one odd factor p from 65 through 111 on 128-bit chunks, with
/// the same per-factor specialization as `WordDense`.
private enum VectorDense<let p: Int> {
    /// Marks complete p-chunk groups from `word`, whose bit 0 holds a multiple,
    /// while a whole group fits below `fullWords`. Chunk j of a group has its first
    /// multiple at bit (-128 * j) mod p.
    @inline(__always)
    static func markGroups(_ words: UnsafeMutableRawPointer, _ word: inout Int, fullWords: Int) {
        while word + p <= fullWords {
            var chunk = 0
            while chunk < p {
                markVectorWord(words, word + chunk, first: (p - (128 * chunk) % p) % p)
                chunk += 1
            }
            word += p
        }
    }

    /// A 128-bit local value with two UInt64 lanes. Each multiple receives its own
    /// single-bit OR; the compiler may combine those operations. Unaligned raw
    /// access avoids assuming the byte allocation has SIMD alignment. Convert each
    /// lane separately so the byte/bit order remains little-endian on every host.
    @inline(__always)
    private static func markVectorWord(_ words: UnsafeMutableRawPointer, _ word: Int, first: Int) {
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
}
