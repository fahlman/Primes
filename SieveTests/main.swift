import Foundation

// Reference: a plain [Bool] sieve, simple enough to trust.
func simpleSieve(upTo n: Int) -> [Int] {
    guard n >= 2 else { return [] }
    var isPrime = [Bool](repeating: true, count: n + 1)
    isPrime[0] = false
    isPrime[1] = false
    var p = 2
    while p * p <= n {
        if isPrime[p] {
            for multiple in stride(from: p * p, through: n, by: p) {
                isPrime[multiple] = false
            }
        }
        p += 1
    }
    return (2...n).filter { isPrime[$0] }
}

func check(_ condition: Bool, _ message: @autoclosure () -> String) {
    guard condition else {
        print("FAIL: \(message())")
        exit(1)
    }
}

/// Number of elements of the sorted array `primes` that are <= limit.
func countAtMost(_ limit: Int, in primes: [Int]) -> Int {
    var lo = 0, hi = primes.count
    while lo < hi {
        let mid = (lo + hi) / 2
        if primes[mid] <= limit { lo = mid + 1 } else { hi = mid }
    }
    return lo
}

func runTests(_ name: String, _ sieveUnderTest: (Int) -> [Int]) {
    let small = simpleSieve(upTo: 30_000)
    for limit in -5...30_000 {
        let expected = small[..<countAtMost(limit, in: small)]
        let got = sieveUnderTest(limit)
        check(got.elementsEqual(expected), "\(name), limit \(limit): got \(got.count) primes, expected \(expected.count)")
    }
    let big = simpleSieve(upTo: 10_000_000)
    // Windows around multiples of 131,072 cross segment boundaries for any power-of-two segment size.
    var boundaryLimits = 0
    for m in 1...12 {
        for limit in (m * 131_072 - 25)...(m * 131_072 + 25) {
            check(sieveUnderTest(limit).elementsEqual(big[..<countAtMost(limit, in: big)]), "\(name), limit \(limit)")
            boundaryLimits += 1
        }
    }
    var scattered = 0
    for limit in stride(from: 30_001, through: 10_000_000, by: 399_989) {
        check(sieveUnderTest(limit).elementsEqual(big[..<countAtMost(limit, in: big)]), "\(name), limit \(limit)")
        scattered += 1
    }
    check(sieveUnderTest(10_000_000) == big, "\(name), limit 10,000,000")
    let known = [(10, 4), (100, 25), (1_000, 168), (10_000, 1_229), (100_000, 9_592),
                 (1_000_000, 78_498), (10_000_000, 664_579)]
    for (n, count) in known {
        check(sieveUnderTest(n).count == count, "\(name), pi(\(n)) should be \(count)")
    }
    print("\(name): all 30,006 limits from -5 to 30,000, \(boundaryLimits) segment-boundary limits, "
          + "\(scattered) scattered limits, 10^7 in full, and known counts match")
}

func runThreadSanitizerTests() {
    let big = simpleSieve(upTo: 10_000_000)
    for limit in [2_100_000, 4_999_999, 7_654_321, 10_000_000] {
        check(sieve(upTo: limit).elementsEqual(big[..<countAtMost(limit, in: big)]), "parallel, limit \(limit)")
    }
    print("parallel runs under ThreadSanitizer: no races reported, results match")
}

func medianMilliseconds(runs: Int, _ body: () -> [Int]) -> (ms: Double, count: Int) {
    var samples: [Double] = []
    var count = 0
    for _ in 0..<runs {
        let start = DispatchTime.now().uptimeNanoseconds
        let primes = body()
        let end = DispatchTime.now().uptimeNanoseconds
        samples.append(Double(end - start) / 1_000_000)
        count = primes.count
    }
    samples.sort()
    return (samples[samples.count / 2], count)
}

func pad(_ s: String, _ width: Int) -> String {
    String(repeating: " ", count: max(0, width - s.count)) + s
}

func runBenchmarks(limits: [(Int, Int)]) {
    let known = [1_000_000: 78_498, 10_000_000: 664_579, 100_000_000: 5_761_455, 1_000_000_000: 50_847_534]
    print(pad("limit", 13) + pad("original ms", 14) + pad("1 thread ms", 14) + pad("speedup", 9)
          + pad("all cores ms", 15) + pad("speedup", 9))
    for (limit, runs) in limits {
        let original = medianMilliseconds(runs: runs) { originalSieve(upTo: limit) }
        let serial = medianMilliseconds(runs: runs) { sieve(upTo: limit, parallel: false) }
        let parallel = medianMilliseconds(runs: runs) { sieve(upTo: limit) }
        for result in [original, serial, parallel] {
            check(result.count == known[limit]!, "pi(\(limit)) should be \(known[limit]!), got \(result.count)")
        }
        print(pad("\(limit)", 13)
              + pad(String(format: "%.2f", original.ms), 14)
              + pad(String(format: "%.2f", serial.ms), 14)
              + pad(String(format: "%.1fx", original.ms / serial.ms), 9)
              + pad(String(format: "%.2f", parallel.ms), 15)
              + pad(String(format: "%.1fx", original.ms / parallel.ms), 9))
    }
}

func runAgreementChecks() {
    for limit in [100_000_000, 1_000_000_000] {
        let reference = originalSieve(upTo: limit)
        check(sieve(upTo: limit, parallel: false) == reference, "1 thread differs from the original at \(limit)")
        check(sieve(upTo: limit) == reference, "all cores differs from the original at \(limit)")
    }
    print("both new modes match the original element by element at 10^8 and 10^9")
}

switch CommandLine.arguments.dropFirst().first {
case "bench":
    runBenchmarks(limits: [(1_000_000, 15), (10_000_000, 11), (100_000_000, 7), (1_000_000_000, 5)])
    runAgreementChecks()
case "quick":
    runBenchmarks(limits: [(10_000_000, 11), (100_000_000, 7), (1_000_000_000, 5)])
case "tsan":
    runThreadSanitizerTests()
default:
    runTests("1 thread") { sieve(upTo: $0, parallel: false) }
    runTests("all cores") { sieve(upTo: $0) }
}
