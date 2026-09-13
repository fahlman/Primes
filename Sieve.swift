import Dispatch
import Foundation

private enum Segment {
    // 32 KB of table per segment, so the bits being crossed out stay in the L1 cache.
    static let words = 4096
    // Below this many segments, starting threads costs more than it saves.
    static let minimumForThreads = 4
}

private enum Presieve {
    // Primes below 64 are crossed out by OR-ing repeating patterns into each segment, so every
    // prime the main loop handles is at least 67 and never marks the same word twice in a row.
    static let largestPrime = 61
    // A group's multiples repeat every `product` bits; `product` words also preserve that phase
    // across word boundaries, since 64 * product is a multiple of product.
    private static let groups = [[3, 5, 7, 11], [13, 17], [19, 23], [29, 31], [37, 41], [43, 47], [53, 59], [61]]
    private static let periods = groups.map { $0.reduce(1, *) }
    private static let patterns: [UInt64] = {
        var patterns: [UInt64] = []
        for (group, period) in zip(groups, periods) {
            var pattern = [UInt64](repeating: 0, count: period)
            for p in group {
                for bit in stride(from: (p - 1) / 2, to: period * 64, by: p) {
                    pattern[bit >> 6] |= 1 << UInt64(bit & 63)
                }
            }
            patterns += pattern
        }
        return patterns
    }()
    // The presieved primes' own bits in word 0, which their patterns cross out.
    static let primeBits = groups.joined().reduce(UInt64(0)) { $0 | 1 << UInt64(($1 - 1) / 2) }

    /// Initializes `count` words of the table, starting at word `firstWord`, from the patterns.
    static func fill(_ segment: UnsafeMutablePointer<UInt64>, count: Int, firstWord: Int) {
        patterns.withUnsafeBufferPointer { all in
            var pattern = all.baseAddress!
            for (group, period) in periods.enumerated() {
                var phase = firstWord % period
                var w = 0
                while w < count {
                    let n = min(count - w, period - phase)
                    if group == 0 {
                        (segment + w).initialize(from: pattern + phase, count: n)
                    } else {
                        for k in 0..<n { segment[w + k] |= pattern[phase + k] }
                    }
                    w += n
                    phase = 0
                }
                pattern += period
            }
        }
    }
}

/// Returns all primes less than or equal to limit.
/// Uses one bit per odd number, sieved in cache-sized segments that are spread across all cores
/// for large limits; pass `parallel: false` to keep all the work on the calling thread.
public func sieve(upTo limit: Int, parallel: Bool = true) -> [Int] {
    guard limit >= 3 else { return limit >= 2 ? [2] : [] }
    let bitCount = (limit + 1) / 2 // Bit i stands for 2i + 1, from 1 up to limit.
    let wordCount = (bitCount + 63) / 64
    let segmentCount = (wordCount + Segment.words - 1) / Segment.words
    // More chunks than cores, so faster cores pick up the slack from slower ones.
    let chunkCount = parallel && segmentCount >= Segment.minimumForThreads
        ? min(segmentCount, ProcessInfo.processInfo.activeProcessorCount * 4)
        : 1
    func words(inChunk chunk: Int) -> Range<Int> {
        let first = chunk * segmentCount / chunkCount * Segment.words
        let end = min((chunk + 1) * segmentCount / chunkCount * Segment.words, wordCount)
        return first..<end
    }

    let sievingPrimes = oddPrimes(upTo: integerSquareRoot(limit)).filter { $0 > Presieve.largestPrime }
    let table = UnsafeMutablePointer<UInt64>.allocate(capacity: wordCount)
    defer { table.deallocate() }
    let chunkStarts = UnsafeMutablePointer<Int>.allocate(capacity: chunkCount)
    defer { chunkStarts.deallocate() }

    sievingPrimes.withUnsafeBufferPointer { sievingPrimes in
        forEachChunk(chunkCount) { chunk in
            chunkStarts[chunk] = sieveChunk(table, words: words(inChunk: chunk), bitCount: bitCount,
                                            sievingPrimes: sievingPrimes)
        }
    }
    // Turn each chunk's prime count into where its primes start in the result, after the 2.
    var primeCount = 1
    for chunk in 0..<chunkCount {
        let count = chunkStarts[chunk]
        chunkStarts[chunk] = primeCount
        primeCount += count
    }
    return [Int](unsafeUninitializedCapacity: primeCount) { buffer, initializedCount in
        let primes = buffer.baseAddress!
        primes[0] = 2
        forEachChunk(chunkCount) { chunk in
            writePrimes(from: table, words: words(inChunk: chunk), to: primes + chunkStarts[chunk])
        }
        initializedCount = primeCount
    }
}

/// Sieves `words` of the table one segment at a time and returns how many primes they hold.
private func sieveChunk(_ table: UnsafeMutablePointer<UInt64>, words: Range<Int>, bitCount: Int,
                        sievingPrimes: UnsafeBufferPointer<Int>) -> Int {
    // next[j] is the bit offset, from the current segment's start, of sievingPrimes[j]'s next multiple.
    let next = UnsafeMutablePointer<Int>.allocate(capacity: max(sievingPrimes.count, 1))
    defer { next.deallocate() }
    let firstBit = words.lowerBound * 64
    for (j, p) in sievingPrimes.enumerated() {
        // Odd multiples of p sit at bits (p - 1) / 2 + k * p. Start at p * p, since smaller
        // multiples have a smaller prime factor.
        let square = p * p / 2
        if square >= firstBit {
            next[j] = square - firstBit
        } else {
            let past = (firstBit - (p - 1) / 2) % p
            next[j] = past == 0 ? 0 : p - past
        }
    }

    var primeCount = 0
    var start = words.lowerBound
    while start < words.upperBound {
        let end = min(start + Segment.words, words.upperBound)
        let segment = table + start
        let segmentBits = (end - start) * 64
        Presieve.fill(segment, count: end - start, firstWord: start)
        if start == 0 {
            segment[0] = (segment[0] & ~Presieve.primeBits) | 1 // Keep 3...61, drop 1.
        }
        for j in 0..<sievingPrimes.count {
            let p = sievingPrimes[j]
            var bit = next[j]
            while bit < segmentBits {
                segment[bit &>> 6] |= 1 &<< UInt64(truncatingIfNeeded: bit)
                bit &+= p
            }
            next[j] = bit &- segmentBits
        }
        if end * 64 > bitCount {
            // Exclude padding past the limit in the table's last word.
            table[end - 1] |= UInt64.max &<< UInt64(bitCount & 63)
        }
        for w in 0..<(end - start) {
            primeCount &+= (~segment[w]).nonzeroBitCount
        }
        start = end
    }
    return primeCount
}

/// Writes the odd primes in `words` of the table to `primes`, in increasing order.
private func writePrimes(from table: UnsafePointer<UInt64>, words: Range<Int>, to primes: UnsafeMutablePointer<Int>) {
    var next = primes
    for w in words {
        var candidates = ~table[w]
        let base = w &* 128 &+ 1 // The number that bit 0 of word w stands for.
        while candidates != 0 {
            next.pointee = base &+ 2 &* candidates.trailingZeroBitCount
            next += 1
            candidates &= candidates &- 1
        }
    }
}

/// Runs body for 0..<count: on the calling thread when count is 1, otherwise across all cores.
private func forEachChunk(_ count: Int, _ body: (Int) -> Void) {
    if count == 1 {
        body(0)
    } else {
        // Chunks write disjoint words and slots, so sharing body across threads is safe.
        withoutActuallyEscaping(body) { body in
            nonisolated(unsafe) let body = body
            DispatchQueue.concurrentPerform(iterations: count) { body($0) }
        }
    }
}

/// Odd primes up to n, from a plain sieve; n is only the square root of the limit.
private func oddPrimes(upTo n: Int) -> [Int] {
    guard n >= 3 else { return [] }
    var isComposite = [Bool](repeating: false, count: (n + 1) / 2) // Index i stands for 2i + 1.
    var primes: [Int] = []
    for i in 1..<isComposite.count where !isComposite[i] {
        let p = 2 * i + 1
        primes.append(p)
        for j in stride(from: p * p / 2, to: isComposite.count, by: p) {
            isComposite[j] = true
        }
    }
    return primes
}

private func integerSquareRoot(_ n: Int) -> Int {
    var root = Int(Double(n).squareRoot())
    while root > n / root { root -= 1 }
    while root + 1 <= n / (root + 1) { root += 1 }
    return root
}

print(sieve(upTo: 30))  // [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
