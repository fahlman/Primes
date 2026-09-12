// Generate both explicit dense switches in PrimeSieve.swift. Every odd factor in
// each range receives a case; this does not test primality or construct masks.
// Run from experiments/swift after acquiring the project's timing lock:
//   swift tools/generate-dense.swift --check PrimeSieve.swift
//   swift tools/generate-dense.swift --write PrimeSieve.swift
// With no arguments, print both marked switches to stdout.
import Foundation

struct DenseSwitch {
    let width: Int
    let firstFactor: Int
    let lastFactor: Int
    let helper: String
    let diagnostic: String

    var beginMarker: String { "        // BEGIN GENERATED DENSE \(width)" }
    var endMarker: String { "        // END GENERATED DENSE \(width)" }
    var label: String { "\(width)-bit \(firstFactor)...\(lastFactor)" }

    func generated() -> String {
        var lines = [beginMarker, "        switch p {"]
        for factor in stride(from: firstFactor, through: lastFactor, by: 2) {
            lines.append("        case \(factor):")
            lines.append("            while word + \(factor) <= fullWords {")
            for chunk in 0..<factor {
                // A group begins at an aligned multiple. In chunk j the first
                // multiple has bit offset (-width*j) mod factor; the helper
                // then marks individual multiples by adding factor.
                let first = (factor - (width * chunk) % factor) % factor
                let index = chunk == 0 ? "word" : "word + \(chunk)"
                lines.append("                \(helper)(words, \(index), first: \(first), step: \(factor))")
            }
            lines.append("                word += \(factor)")
            lines.append("            }")
        }
        lines.append("        default:")
        lines.append("            preconditionFailure(\"\(diagnostic) marking requires an odd factor from \(firstFactor) to \(lastFactor)\")")
        lines.append("        }")
        lines.append(endMarker)
        return lines.joined(separator: "\n") + "\n"
    }

    func markedRange(in source: String) throws -> Range<String.Index> {
        let begin = beginMarker + "\n"
        let end = endMarker + "\n"
        guard source.components(separatedBy: begin).count == 2,
              source.components(separatedBy: end).count == 2,
              let start = source.range(of: begin),
              let finish = source.range(of: end, range: start.upperBound..<source.endIndex) else {
            throw NSError(domain: "GenerateDense", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "Missing, duplicated, or reversed \(width)-bit generated-block markers"
            ])
        }
        return start.lowerBound..<finish.upperBound
    }
}

// Runtime dispatch must cover exactly these odd ranges after testing each factor.
// Factor 3 keeps its byte handler; factors above 111 keep the sparse loop.
let switches = [
    DenseSwitch(width: 64, firstFactor: 5, lastFactor: 63,
                helper: "markWord", diagnostic: "Word-dense"),
    DenseSwitch(width: 128, firstFactor: 65, lastFactor: 111,
                helper: "markVectorWord", diagnostic: "Vector-dense"),
]
do {
    let arguments = Array(CommandLine.arguments.dropFirst())
    if arguments.isEmpty {
        for block in switches {
            print(block.generated(), terminator: "")
        }
    } else {
        guard arguments.count == 2 && (arguments[0] == "--check" || arguments[0] == "--write") else {
            throw NSError(domain: "GenerateDense", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Usage: generate-dense.swift [--check|--write PrimeSieve.swift]"
            ])
        }
        let file = URL(fileURLWithPath: arguments[1])
        var source = try String(contentsOf: file, encoding: .utf8)
        let ranges = try switches.map { try $0.markedRange(in: source) }
        guard ranges[0].upperBound <= ranges[1].lowerBound else {
            throw NSError(domain: "GenerateDense", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "Generated blocks must be separate, with the 64-bit block first"
            ])
        }
        for block in switches {
            let range = try block.markedRange(in: source)
            let generated = block.generated()
            if arguments[0] == "--check" {
                guard source[range] == generated else {
                    throw NSError(domain: "GenerateDense", code: 3, userInfo: [
                        NSLocalizedDescriptionKey: "The generated \(block.label) switch does not match the source"
                    ])
                }
            } else {
                source.replaceSubrange(range, with: generated)
            }
        }
        // Write once, after both blocks have been located successfully. Everything
        // outside the markers is preserved, including alignment peels and tails.
        if arguments[0] == "--write" {
            try source.write(to: file, atomically: true, encoding: .utf8)
            print("Updated both generated dense switches.")
        } else {
            print("Generated 64-bit 5...63 and 128-bit 65...111 switches match.")
        }
    }
} catch {
    FileHandle.standardError.write(Data((error.localizedDescription + "\n").utf8))
    exit(1)
}
