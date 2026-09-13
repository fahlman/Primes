// The previous bit-packed version, renamed to originalSieve(upTo:). `./run.sh bench` times
// Sieve.swift against it and checks that both return exactly the same primes.

private enum SmallPrimePattern {
    // Multiples of 3, 5, and 7 repeat every 105 odd candidates.
    // 105 words also preserve that phase across word boundaries.
    static let words: [UInt64] = {
        var words = [UInt64](repeating: 0, count: 105)
        for p in [3, 5, 7] {
            for index in stride(from: (p - 3) / 2, to: words.count * 64, by: p) {
                words[index >> 6] |= UInt64(1) << (index & 63)
            }
        }
        return words
    }()
}

/// Returns all primes less than or equal to limit.
/// Uses one bit per odd candidate and a reusable 840-byte pattern for 3, 5, and 7.
func originalSieve(upTo limit: Int) -> [Int] {
    guard limit >= 3 else { return limit >= 2 ? [2] : [] }
    let oddCount = (limit - 1) / 2
    let wordCount = oddCount / 64 + (oddCount % 64 == 0 ? 0 : 1)
    var composites = [UInt64](repeating: 0, count: wordCount)
    let pattern = SmallPrimePattern.words

    // Storage remains array-owned; this buffer never escapes the closure.
    return composites.withUnsafeMutableBufferPointer { bits in
        for word in bits.indices {
            bits[word] = pattern[word % pattern.count]
        }
        bits[0] &= ~UInt64(7) // Restore 3, 5, and 7.

        var p = 11
        while p <= limit / p {
            let index = (p - 3) / 2
            if bits[index >> 6] & (UInt64(1) << (index & 63)) == 0 {
                var multiple = (p * p - 3) / 2
                while multiple < oddCount {
                    bits[multiple >> 6] |= UInt64(1) << (multiple & 63)
                    multiple += p
                }
            }
            p += 2
        }

        // Exclude padding so every word can use the same extraction loop.
        let remainder = oddCount & 63
        if remainder != 0 {
            bits[wordCount - 1] |= UInt64.max << remainder
        }
        // Count first to allocate the returned array just once.
        var primeCount = 1
        for word in bits { primeCount += (~word).nonzeroBitCount }
        var primes = [Int]()
        primes.reserveCapacity(primeCount)
        primes.append(2)
        for wordIndex in bits.indices {
            var candidates = ~bits[wordIndex]
            while candidates != 0 {
                let index = wordIndex * 64 + candidates.trailingZeroBitCount
                primes.append(index * 2 + 3)
                candidates &= candidates - 1
            }
        }
        return primes
    }
}
