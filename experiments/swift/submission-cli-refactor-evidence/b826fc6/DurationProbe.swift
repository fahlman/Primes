import Foundation
import ArgumentParser

@main
struct DurationProbe {
    static func main() {
        do {
            var checks = 0
            for (seconds, expected) in [
                (0.0, UInt64(0)), (-0.0, 0),
                (Double.leastNonzeroMagnitude, 1),
                (0.1e-9, 1), (0.5e-9, 1), (1e-9, 1),
                (1.01e-9, 2), (1.5e-9, 2), (5.0, 5_000_000_000),
            ] {
                let actual = try validatedNanoseconds(for: seconds)
                guard actual == expected else {
                    throw failure("\(seconds) returned \(actual), expected \(expected)")
                }
                checks += 1
            }

            // Probe the conversion directly: an accepted duration near this
            // boundary must never be passed to the real benchmark loop.
            let boundary = Double(UInt64.max) / 1_000_000_000
            let below = try validatedNanoseconds(for: boundary.nextDown)
            guard below > UInt64.max - 8_192 else {
                throw failure("Boundary neighbor returned an unexpected value: \(below)")
            }
            print("Accepted boundary neighbor: seconds=\(boundary.nextDown), nanoseconds=\(below)")
            checks += 1

            for seconds in [
                -1.0, -Double.leastNonzeroMagnitude,
                Double.nan, Double.infinity, -Double.infinity,
                1e100, Double.greatestFiniteMagnitude,
                boundary, boundary.nextUp,
            ] {
                do {
                    _ = try validatedNanoseconds(for: seconds)
                    throw failure("Unexpectedly accepted \(seconds)")
                } catch is ValidationError {
                    checks += 1
                }
            }
            print("Duration conversion passed \(checks) probes.")
        } catch {
            FileHandle.standardError.write(Data(("Duration probe failed: \(error)\n").utf8))
            exit(1)
        }
    }

    private static func failure(_ message: String) -> NSError {
        NSError(domain: "DurationProbe", code: 1,
                userInfo: [NSLocalizedDescriptionKey: message])
    }
}
