// Reusable CLI regression checks for the dense generator and compatibility shim.
// Run from any directory, while the caller owns the project's timing lock:
//   swift /path/to/experiments/swift/tools/check-dense-generator.swift
// All mutations use disposable fixtures. The final JSON records every command;
// this does not compile or run the sieve, or replace its correctness checks.
import Foundation

struct CheckFailure: Error, LocalizedError {
    let message: String
    var errorDescription: String? { message }
}

func require(_ condition: Bool, _ message: String) throws {
    if !condition { throw CheckFailure(message: message) }
}

func replacingOnce(_ text: String, _ old: String, _ new: String) throws -> String {
    try require(text.components(separatedBy: old).count == 2, "Fixture anchor is not unique: \(old)")
    return text.replacingOccurrences(of: old, with: new)
}

func markedBlock(_ source: String, width: Int) throws -> String {
    let begin = "        // BEGIN GENERATED DENSE \(width)\n"
    let end = "        // END GENERATED DENSE \(width)\n"
    try require(source.components(separatedBy: begin).count == 2 &&
                source.components(separatedBy: end).count == 2, "Expected one marker pair for \(width)")
    guard let start = source.range(of: begin),
          let finish = source.range(of: end, range: start.upperBound..<source.endIndex) else {
        throw CheckFailure(message: "Reversed \(width)-bit marker pair")
    }
    return String(source[start.lowerBound..<finish.upperBound])
}

func captures(_ pattern: String, in text: String) throws -> [[String]] {
    let regex = try NSRegularExpression(pattern: pattern, options: [.anchorsMatchLines])
    let ns = text as NSString
    return regex.matches(in: text, range: NSRange(location: 0, length: ns.length)).map { match in
        (1..<match.numberOfRanges).map { index in
            let range = match.range(at: index)
            return range.location == NSNotFound ? "" : ns.substring(with: range)
        }
    }
}

func integer(_ text: String) throws -> Int {
    guard let value = Int(text) else { throw CheckFailure(message: "Invalid generated integer: \(text)") }
    return value
}

// Independent of the generator's modulo formula: expand the emitted individual
// calls into absolute marked positions and compare with a plain linear sequence.
func checkSchedules(_ output: String) throws -> [String: Int] {
    var factors = 0, calls = 0, marks = 0
    for (width, lower, upper, helper) in [(64, 5, 63, "markWord"), (128, 65, 111, "markVectorWord")] {
        let block = try markedBlock(output, width: width)
        let cases = try captures("^        case ([0-9]+):$", in: block).map { try integer($0[0]) }
        try require(cases == Array(stride(from: lower, through: upper, by: 2)), "Missing or extra odd cases at width \(width)")
        for factor in cases {
            let start = block.range(of: "        case \(factor):\n")!.upperBound
            let rest = block[start...]
            guard let finish = rest.range(of: "        case ")?.lowerBound ?? rest.range(of: "        default:")?.lowerBound else {
                throw CheckFailure(message: "Unterminated generated case \(factor)")
            }
            let body = String(block[start..<finish])
            let rows = try captures("^                \(helper)\\(words, word(?: \\+ ([0-9]+))?, first: ([0-9]+), step: ([0-9]+)\\)$", in: body)
            try require(rows.count == factor, "Wrong chunk count for factor \(factor)")
            try require(body.split(separator: "\n").filter { $0.contains("mark") }.count == rows.count,
                        "Unparsed marking call at factor \(factor)")
            try require(body.hasPrefix("            while word + \(factor) <= fullWords {\n") &&
                        body.hasSuffix("                word += \(factor)\n            }\n"),
                        "Unexpected chunk loop at factor \(factor)")
            var positions: [Int] = []
            for (chunk, row) in rows.enumerated() {
                let index = try integer(row[0].isEmpty ? "0" : row[0])
                let first = try integer(row[1]), step = try integer(row[2])
                try require(index == chunk && step == factor && first >= 0 && first < factor,
                            "Invalid emitted call at factor \(factor), chunk \(chunk)")
                var bit = first
                while bit < width {
                    positions.append(width * chunk + bit)
                    bit += factor
                }
            }
            try require(positions == Array(stride(from: 0, through: (width - 1) * factor, by: factor)),
                        "Missing, duplicate or misplaced marks for factor \(factor)")
            factors += 1; calls += rows.count; marks += positions.count
        }
    }
    return ["odd_factors": factors, "helper_calls": calls, "individual_marks": marks]
}

final class GeneratorChecks {
    let files = FileManager.default
    let tools = URL(fileURLWithPath: #filePath).standardizedFileURL.deletingLastPathComponent()
    let temporary: URL
    var commands: [[String: Any]] = []
    var schedules: [String: Int] = [:]

    init() throws {
        temporary = files.temporaryDirectory.appendingPathComponent("dense-generator-check-\(UUID().uuidString)", isDirectory: true)
        try files.createDirectory(at: temporary, withIntermediateDirectories: false)
    }

    func invoke(_ tool: String, _ arguments: [String], name: String, expected: Int32 = 0) throws -> String {
        let prefix = temporary.appendingPathComponent("command-\(commands.count)")
        let outURL = prefix.appendingPathExtension("stdout"), errURL = prefix.appendingPathExtension("stderr")
        try Data().write(to: outURL, options: .withoutOverwriting)
        try Data().write(to: errURL, options: .withoutOverwriting)
        let out = try FileHandle(forWritingTo: outURL), err = try FileHandle(forWritingTo: errURL)
        defer { try? out.close(); try? err.close() }
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["swift", tools.appendingPathComponent(tool).path] + arguments
        process.currentDirectoryURL = temporary
        process.standardOutput = out; process.standardError = err
        let recordIndex = commands.count
        commands.append(["tool": tool, "case": name, "argv": ["/usr/bin/env"] + process.arguments!,
                         "exit_code": NSNull(), "expected_exit_code": expected])
        try process.run()
        process.waitUntilExit()
        let stdout = try Data(contentsOf: outURL), stderr = try String(contentsOf: errURL, encoding: .utf8)
        commands[recordIndex]["exit_code"] = process.terminationStatus
        commands[recordIndex]["termination_reason"] = process.terminationReason == .exit ? "exit" : "uncaught_signal"
        commands[recordIndex]["stdout_bytes"] = stdout.count
        commands[recordIndex]["stderr"] = stderr
        try require(process.terminationReason == .exit && process.terminationStatus == expected,
                    "\(tool) \(name): expected exit \(expected), got \(process.terminationStatus); \(stderr)")
        if expected == 0 {
            try require(stderr.isEmpty, "Unexpected successful-command stderr: \(stderr)")
        } else {
            try require(stdout.isEmpty && !stderr.isEmpty && !stderr.contains("Stack dump") && !stderr.contains("Fatal error"),
                        "Failure did not produce the concise stderr-only diagnostic: \(name)")
        }
        guard let text = String(data: stdout, encoding: .utf8) else { throw CheckFailure(message: "Non-UTF8 stdout") }
        return text
    }

    func fixture(_ text: String, _ name: String) throws -> URL {
        let url = temporary.appendingPathComponent(name)
        try Data(text.utf8).write(to: url, options: .withoutOverwriting)
        return url
    }

    func run() throws {
        let sourceURL = tools.deletingLastPathComponent().appendingPathComponent("PrimeSieve.swift")
        let templateURL = tools.appendingPathComponent("PrimeSieve.swift.in")
        let original = try Data(contentsOf: sourceURL), templateData = try Data(contentsOf: templateURL)
        guard let source = String(data: original, encoding: .utf8),
              let template = String(data: templateData, encoding: .utf8) else {
            throw CheckFailure(message: "Source/template is not UTF8")
        }
        // This is a file/CLI check, so current source identity is the expected
        // render. Separate admission checks prove identity to the adopted commit.
        let expectedBlocks = try markedBlock(source, width: 64) + markedBlock(source, width: 128)
        let goodTemplate = try fixture(template, "template with spaces.swift.in")
        let begin64 = "        // BEGIN GENERATED DENSE 64\n", end64 = "        // END GENERATED DENSE 64\n"
        let begin128 = "        // BEGIN GENERATED DENSE 128\n", end128 = "        // END GENERATED DENSE 128\n"
        let missing = try replacingOnce(source, end128, "")
        let duplicate = try replacingOnce(source, begin64, begin64 + begin64)
        let reversed = try replacingOnce(try replacingOnce(source, begin64, "REVERSE-BEGIN\n"), end64, begin64)
            .replacingOccurrences(of: "REVERSE-BEGIN\n", with: end64)
        let overlap = try replacingOnce(try replacingOnce(source, end64, ""), begin128, begin128 + end64)
        let corruptBoth = try replacingOnce(
            try replacingOnce(source, "first: 1, step: 5)", "first: 2, step: 5)"),
            "first: 2, step: 65)", "first: 3, step: 65)")
        let insert64 = "        // INSERT GENERATED DENSE 64\n", insert128 = "        // INSERT GENERATED DENSE 128\n"
        let swapped = try replacingOnce(try replacingOnce(template, insert64, "REVERSE-INSERT\n"), insert128, insert64)
            .replacingOccurrences(of: "REVERSE-INSERT\n", with: insert128)
        let swappedDispatch = try replacingOnce(
            try replacingOnce(template, "markWordDenseMultiples(of: p)", "SWAPPED-DISPATCH"),
            "markVectorDenseMultiples(of: p)", "markWordDenseMultiples(of: p)")
            .replacingOccurrences(of: "SWAPPED-DISPATCH", with: "markVectorDenseMultiples(of: p)")
        let badTemplates = [
            ("missing-insertion", try replacingOnce(template, insert64, "")),
            ("duplicate-insertion", try replacingOnce(template, insert128, insert128 + insert128)),
            ("reversed-insertions", swapped),
            ("missing-dispatch-token", try replacingOnce(template, "{{WORD_DISPATCH_UPPER_BOUND}}", "64")),
            ("duplicate-dispatch-token", template + "// {{VECTOR_DISPATCH_UPPER_BOUND}}\n"),
            ("unknown-token", template + "// {{UNSUPPORTED_GENERATOR_TOKEN}}\n"),
            ("dispatch-shape", try replacingOnce(template, "if p < {{VECTOR_DISPATCH_UPPER_BOUND}}", "if p <= {{VECTOR_DISPATCH_UPPER_BOUND}}")),
            ("swapped-dispatch-handlers", swappedDispatch),
            ("word-helper-width", try replacingOnce(template, "while bit < 64 {", "while bit < 63 {")),
            ("vector-helper-width", try replacingOnce(template, "while bit < 128 {", "while bit < 127 {")),
            ("word-storage-type", try replacingOnce(template,
                "loadUnaligned(fromByteOffset: offset, as: UInt64.self)",
                "loadUnaligned(fromByteOffset: offset, as: UInt32.self)")),
            ("vector-storage-type", try replacingOnce(template,
                "loadUnaligned(fromByteOffset: offset, as: SIMD2<UInt64>.self)",
                "loadUnaligned(fromByteOffset: offset, as: SIMD4<UInt64>.self)")),
        ]
        for tool in ["generate-dense.swift", "generate-dense-128.swift"] {
            let stem = tool == "generate-dense.swift" ? "canonical" : "shim"
            let printed = try invoke(tool, [], name: "stdout-blocks")
            try require(printed.utf8.elementsEqual(expectedBlocks.utf8), "\(tool) stdout differs from the two current marked blocks")
            let checkedSchedule = try checkSchedules(printed)
            if schedules.isEmpty { schedules = checkedSchedule }
            try require(schedules == checkedSchedule, "Shim schedule differs")
            let good = try fixture(source, "\(stem)-source with spaces.swift")
            _ = try invoke(tool, ["--check", good.path], name: "check-current")
            _ = try invoke(tool, ["--template", goodTemplate.path, "--check", good.path], name: "template-before-mode")
            _ = try invoke(tool, ["--write", good.path, "--template", goodTemplate.path], name: "template-after-path")
            try require(try Data(contentsOf: good) == original, "Writing a correct fixture changed its bytes")
            for (name, corrupted) in [
                ("corrupt-word", try replacingOnce(source, "first: 1, step: 5)", "first: 2, step: 5)")),
                ("corrupt-vector", try replacingOnce(source, "first: 2, step: 65)", "first: 3, step: 65)")),
                ("corrupt-both-blocks", corruptBoth),
                ("corrupt-handwritten", try replacingOnce(source, "private let limit: Int", "private let limit: Int // disposable corruption")),
                ("word-dispatch-cutoff", try replacingOnce(source, "if p < 64 {", "if p < 62 {")),
                ("vector-dispatch-cutoff", try replacingOnce(source, "if p < 112 {", "if p < 114 {")),
            ] {
                let file = try fixture(corrupted, "\(stem)-\(name).swift")
                _ = try invoke(tool, ["--check", file.path], name: name + "-check", expected: 1)
                try require(try Data(contentsOf: file) == Data(corrupted.utf8), "Failed check changed source")
                _ = try invoke(tool, ["--write", file.path], name: name + "-repair")
                try require(try Data(contentsOf: file) == original, "Whole-file regeneration did not restore source")
            }
            for (name, corrupted) in [("missing-marker", missing), ("duplicate-marker", duplicate),
                                      ("reversed-markers", reversed), ("overlapping-markers", overlap)] {
                let file = try fixture(corrupted, "\(stem)-\(name).swift")
                for mode in ["--check", "--write"] {
                    _ = try invoke(tool, [mode, file.path], name: name + mode, expected: 1)
                    try require(try Data(contentsOf: file) == Data(corrupted.utf8), "Invalid marker operation modified its file")
                }
            }
            for (name, badTemplate) in badTemplates {
                let input = try fixture(badTemplate, "\(stem)-\(name).swift.in")
                let target = try fixture(source, "\(stem)-\(name)-target.swift")
                _ = try invoke(tool, ["--write", target.path, "--template", input.path], name: name, expected: 1)
                try require(try Data(contentsOf: target) == original, "Invalid template partially wrote source")
                try require(try Data(contentsOf: input) == Data(badTemplate.utf8), "Generator changed template")
            }
            for (name, args) in [("unknown-mode", ["--unknown", good.path]), ("missing-path", ["--check"]),
                                 ("extra-argument", ["--check", good.path, "extra"]), ("missing-template-path", ["--template"]),
                                 ("template-without-mode", ["--template", goodTemplate.path]),
                                 ("duplicate-modes", ["--check", good.path, "--write", good.path]),
                                 ("duplicate-template-options", ["--check", good.path, "--template", goodTemplate.path,
                                                                 "--template", goodTemplate.path])] {
                _ = try invoke(tool, args, name: name, expected: 1)
                try require(try Data(contentsOf: good) == original, "Invalid arguments modified source")
            }
            // Swift String equality treats these comments as equal. The source
            // contract is exact UTF8, so only explicit --write may replace them.
            let composed = "// Unicode byte-identity fixture: caf\u{00E9}\n"
            let decomposed = "// Unicode byte-identity fixture: cafe\u{0301}\n"
            try require(composed == decomposed && !composed.utf8.elementsEqual(decomposed.utf8),
                        "Unicode fixture must have canonically equal text but different bytes")
            let unicodeSource = try fixture(source + composed, "\(stem)-unicode.swift")
            let unicodeTemplate = try fixture(template + decomposed, "\(stem)-unicode.swift.in")
            let unicodeArguments = [unicodeSource.path, "--template", unicodeTemplate.path]
            _ = try invoke(tool, ["--check"] + unicodeArguments, name: "unicode-byte-mismatch", expected: 1)
            try require(try Data(contentsOf: unicodeSource) == Data((source + composed).utf8),
                        "Unicode mismatch check changed source bytes")
            _ = try invoke(tool, ["--write"] + unicodeArguments, name: "unicode-byte-repair")
            try require(try Data(contentsOf: unicodeSource) == Data((source + decomposed).utf8),
                        "Unicode regeneration did not preserve exact template bytes")
            _ = try invoke(tool, ["--check"] + unicodeArguments, name: "unicode-repaired-check")
            try require(try Data(contentsOf: unicodeTemplate) == Data((template + decomposed).utf8),
                        "Unicode operations changed template bytes")
            let absent = temporary.appendingPathComponent("\(stem)-does-not-exist.swift")
            _ = try invoke(tool, ["--write", absent.path], name: "missing-source", expected: 1)
            try require(!files.fileExists(atPath: absent.path), "Missing source was unexpectedly created")
        }
        let finalSource = try Data(contentsOf: sourceURL), finalTemplate = try Data(contentsOf: templateURL)
        try require(finalSource == original && finalTemplate == templateData,
                    "Production source or authoring template changed")
    }
}

var checks: GeneratorChecks?
var summary: [String: Any] = ["purpose": "Generator CLI and independent schedule checks only; no sieve execution."]
do {
    try require(CommandLine.arguments.count == 1, "Usage: check-dense-generator.swift (caller must own the timing lock)")
    let run = try GeneratorChecks(); checks = run
    try run.run()
    summary["status"] = "passed"
} catch {
    summary["status"] = "failed"
    summary["error"] = error.localizedDescription
}
if let checks {
    summary["commands"] = checks.commands
    summary["command_count"] = checks.commands.count
    summary["schedule"] = checks.schedules
    do {
        try checks.files.removeItem(at: checks.temporary)
        summary["temporary_fixtures_removed"] = true
    } catch {
        summary["status"] = "failed"
        summary["cleanup_error"] = error.localizedDescription
    }
}
let result = try JSONSerialization.data(withJSONObject: summary, options: [.prettyPrinted, .sortedKeys])
FileHandle.standardOutput.write(result)
FileHandle.standardOutput.write(Data("\n".utf8))
exit(summary["status"] as? String == "passed" ? 0 : 1)
