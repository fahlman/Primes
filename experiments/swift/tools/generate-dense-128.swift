// Generate only the 65...127 switch in PrimeSieve.swift. The generator covers
// every odd factor; it does not test primality or construct composite masks.
// Run from experiments/swift after acquiring the project's timing lock:
//   swift tools/generate-dense-128.swift --check PrimeSieve.swift
//   swift tools/generate-dense-128.swift --write PrimeSieve.swift
// With no arguments, print the generated switch to stdout.
import Foundation

let beginMarker = "        // BEGIN GENERATED DENSE 128"
let endMarker = "        // END GENERATED DENSE 128"

func generatedSwitch() -> String {
    var lines = [beginMarker, "        switch p {"]
    for factor in stride(from: 65, through: 127, by: 2) {
        lines.append("        case \(factor):")
        lines.append("            while word + \(factor) <= fullWords {")
        for chunk in 0..<factor {
            // A group starts on a multiple aligned to 128 bits. The next
            // multiple in chunk j is at (-128*j) mod factor within that chunk.
            let first = (factor - (128 * chunk) % factor) % factor
            let index = chunk == 0 ? "word" : "word + \(chunk)"
            lines.append("                markVectorWord(words, \(index), first: \(first), step: \(factor))")
        }
        lines.append("                word += \(factor)")
        lines.append("            }")
    }
    lines.append("        default:")
    lines.append("            preconditionFailure(\"Vector-dense marking requires an odd factor from 65 to 127\")")
    lines.append("        }")
    lines.append(endMarker)
    return lines.joined(separator: "\n") + "\n"
}

let arguments = Array(CommandLine.arguments.dropFirst())
let generated = generatedSwitch()
if arguments.isEmpty {
    print(generated, terminator: "")
} else {
    guard arguments.count == 2 && (arguments[0] == "--check" || arguments[0] == "--write") else {
        throw NSError(domain: "GenerateDense128", code: 1, userInfo: [
            NSLocalizedDescriptionKey: "Usage: generate-dense-128.swift [--check|--write PrimeSieve.swift]"
        ])
    }
    let file = URL(fileURLWithPath: arguments[1])
    let source = try String(contentsOf: file, encoding: .utf8)
    guard let start = source.range(of: beginMarker),
          let end = source.range(of: endMarker + "\n", range: start.upperBound..<source.endIndex) else {
        throw NSError(domain: "GenerateDense128", code: 2, userInfo: [
            NSLocalizedDescriptionKey: "Missing dense-128 generated-block markers"
        ])
    }
    let range = start.lowerBound..<end.upperBound
    if arguments[0] == "--check" {
        guard source[range] == generated else {
            throw NSError(domain: "GenerateDense128", code: 3, userInfo: [
                NSLocalizedDescriptionKey: "The generated 65...127 switch does not match the source"
            ])
        }
        print("Generated 65...127 switch matches.")
    } else {
        let updated = source.replacingCharacters(in: range, with: generated)
        try updated.write(to: file, atomically: true, encoding: .utf8)
        print("Updated generated 65...127 switch.")
    }
}
