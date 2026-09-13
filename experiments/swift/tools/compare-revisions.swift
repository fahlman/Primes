// Compare committed Swift candidates with the frozen benchmark runner and observer
// from revision 25402d4. Every executable is compiled first; then three rotated
// five-second runs per variant are measured serially. Run while holding the
// project's timing lock, from any directory:
//   swift tools/compare-revisions.swift --variant NAME=REVISION [--variant ...] --output RESULTS.json
// Variant names use lowercase letters, digits, hyphens and underscores; the first
// variant is the reference for speedup_over_first. The output file must not exist.
// Timing counts as evidence only on the reference machine; see AGENTS.md.
import Foundation

let harnessRevision = "25402d46ba991b39451724d3873d326626981e3f"
let package = "experiments/swift"
let frozenLabel = "fahlman_swift_striped_unrolled"
let requiredTags = "algorithm=base,faithful=yes,bits=1"
let validationMarker = "Validated: 78498 primes;"
let rounds = 3
let usage = "Usage: compare-revisions.swift --variant NAME=REVISION [--variant NAME=REVISION ...] --output RESULTS.json [--repo PATH]"

struct ToolError: Error, CustomStringConvertible { let description: String }

struct Command {
    let stdout: String
    let stderr: String
}

/// Runs a command through /usr/bin/env, capturing both streams, and fails on a nonzero exit.
@discardableResult
func run(_ arguments: [String], in directory: URL? = nil) throws -> Command {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = arguments
    process.currentDirectoryURL = directory
    let out = Pipe(), err = Pipe()
    process.standardOutput = out
    process.standardError = err
    try process.run()
    var outData = Data(), errData = Data()
    let group = DispatchGroup()
    group.enter(); DispatchQueue.global().async { outData = out.fileHandleForReading.readDataToEndOfFile(); group.leave() }
    group.enter(); DispatchQueue.global().async { errData = err.fileHandleForReading.readDataToEndOfFile(); group.leave() }
    group.wait()
    process.waitUntilExit()
    let result = Command(stdout: String(decoding: outData, as: UTF8.self), stderr: String(decoding: errData, as: UTF8.self))
    guard process.terminationReason == .exit, process.terminationStatus == 0 else {
        throw ToolError(description: "`\(arguments.joined(separator: " "))` exited with \(process.terminationStatus)\n\(result.stderr)")
    }
    return result
}

func sha256(of file: URL) throws -> String {
    let output = try run(["shasum", "-a", "256", file.path]).stdout
    guard let digest = output.split(separator: " ").first, digest.count == 64 else {
        throw ToolError(description: "Cannot hash \(file.path)")
    }
    return String(digest)
}

func median(_ values: [Double]) -> Double {
    let sorted = values.sorted()
    let n = sorted.count
    return n % 2 == 1 ? sorted[n / 2] : (sorted[n / 2 - 1] + sorted[n / 2]) / 2
}

struct Sample: Codable {
    let output: String
    let passes: Int
    let seconds: Double
    let threads: Int
    let tags: String
    let validation: String
    let milliseconds_per_pass: Double
}

struct Variant: Codable {
    let revision: String
    let source_sha256: String
}

struct Results: Codable {
    let recorded_at_utc: String
    let platform: String
    let machine: String
    let cpu: String
    let swift_version: String
    let flags: [String]
    let harness_revision: String
    let runner_sha256: String
    let observer_sha256: String
    let variants: [String: Variant]
    let run_order: [[String]]
    let samples: [String: [Sample]]
    let median_ms: [String: Double]
    let speedup_over_first: [String: Double]
}

func hostDescription() -> (platform: String, machine: String, cpu: String) {
    let machine = (try? run(["uname", "-m"]).stdout.trimmingCharacters(in: .whitespacesAndNewlines)) ?? "unknown"
    #if os(macOS)
    let platform = "macOS " + ProcessInfo.processInfo.operatingSystemVersionString
    let cpu = (try? run(["sysctl", "-n", "machdep.cpu.brand_string"]).stdout.trimmingCharacters(in: .whitespacesAndNewlines)) ?? "unknown"
    #else
    let platform = "Linux " + ProcessInfo.processInfo.operatingSystemVersionString
    let cpuinfo = (try? String(contentsOfFile: "/proc/cpuinfo", encoding: .utf8)) ?? ""
    let cpu = cpuinfo.split(separator: "\n").first { $0.hasPrefix("model name") }
        .map { String($0.split(separator: ":", maxSplits: 1).last ?? "").trimmingCharacters(in: .whitespaces) } ?? "unknown"
    #endif
    return (platform, machine, cpu)
}

do {
    var specifications: [String] = []
    var outputPath: String?
    var repoPath: String?
    let arguments = Array(CommandLine.arguments.dropFirst())
    var index = 0
    while index < arguments.count {
        guard index + 1 < arguments.count else { throw ToolError(description: usage) }
        let value = arguments[index + 1]
        switch arguments[index] {
        case "--variant": specifications.append(value)
        case "--output": guard outputPath == nil else { throw ToolError(description: usage) }; outputPath = value
        case "--repo": guard repoPath == nil else { throw ToolError(description: usage) }; repoPath = value
        default: throw ToolError(description: usage)
        }
        index += 2
    }
    guard !specifications.isEmpty, let outputPath else { throw ToolError(description: usage) }
    let output = URL(fileURLWithPath: outputPath)
    guard !FileManager.default.fileExists(atPath: output.path) else {
        throw ToolError(description: "Refusing to overwrite \(output.path)")
    }

    let scriptDirectory = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
    let startDirectory = URL(fileURLWithPath: repoPath ?? scriptDirectory.path)
    let repo = URL(fileURLWithPath: try run(["git", "rev-parse", "--show-toplevel"], in: startDirectory).stdout.trimmingCharacters(in: .whitespacesAndNewlines))
    func git(_ arguments: [String]) throws -> String {
        try run(["git", "-C", repo.path] + arguments).stdout.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func source(_ revision: String, _ name: String) throws -> Data {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["git", "-C", repo.path, "show", "\(revision):\(package)/\(name)"]
        let out = Pipe(); process.standardOutput = out; process.standardError = FileHandle.standardError
        try process.run()
        let data = out.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        guard process.terminationStatus == 0 else { throw ToolError(description: "git show failed for \(revision):\(name)") }
        return data
    }

    let build = repo.appendingPathComponent(package).appendingPathComponent(".build/optimization-comparison")
    try FileManager.default.createDirectory(at: build, withIntermediateDirectories: true)
    let observerFile = build.appendingPathComponent("BenchmarkObserver.swift")
    let runnerFile = build.appendingPathComponent("Benchmark.swift")
    try source(harnessRevision, "BenchmarkObserver.swift").write(to: observerFile)
    try source(harnessRevision, "Benchmark.swift").write(to: runnerFile)
    let runnerText = try String(contentsOf: runnerFile, encoding: .utf8)
    guard runnerText.contains(frozenLabel) else { throw ToolError(description: "The frozen runner no longer carries the label \(frozenLabel)") }
    try run(["swiftc", "-O", "-parse-as-library", "-module-name", "BenchmarkObserver",
             "-emit-module", "-emit-module-path", build.appendingPathComponent("BenchmarkObserver.swiftmodule").path,
             "-emit-object", observerFile.path, "-o", build.appendingPathComponent("BenchmarkObserver.o").path], in: build)

    var names: [String] = []
    var variants: [String: Variant] = [:]
    let allowed = Set("abcdefghijklmnopqrstuvwxyz0123456789-_")
    for specification in specifications {
        guard let separator = specification.firstIndex(of: "=") else { throw ToolError(description: "Variants take the form NAME=REVISION: \(specification)") }
        let name = String(specification[..<separator])
        let requested = String(specification[specification.index(after: separator)...])
        guard !name.isEmpty, name.allSatisfy({ allowed.contains($0) }) else {
            throw ToolError(description: "Variant names must use lowercase letters, digits, hyphens, or underscores: \(name)")
        }
        guard variants[name] == nil else { throw ToolError(description: "Duplicate variant: \(name)") }
        let revision = try git(["rev-parse", "--verify", "\(requested)^{commit}"])
        let directory = build.appendingPathComponent(name)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let implementation = directory.appendingPathComponent("PrimeSieve.swift")
        try source(revision, "PrimeSieve.swift").write(to: implementation)
        try runnerText.replacingOccurrences(of: frozenLabel, with: name)
            .write(to: directory.appendingPathComponent("Benchmark.swift"), atomically: true, encoding: .utf8)
        try run(["swiftc", "-O", "-whole-module-optimization", "-I", build.path,
                 implementation.path, directory.appendingPathComponent("Benchmark.swift").path,
                 build.appendingPathComponent("BenchmarkObserver.o").path,
                 "-o", directory.appendingPathComponent("benchmark").path], in: build)
        names.append(name)
        variants[name] = Variant(revision: revision, source_sha256: try sha256(of: implementation))
    }

    var samples: [String: [Sample]] = Dictionary(uniqueKeysWithValues: names.map { ($0, []) })
    var orders: [[String]] = []
    for round in 0..<rounds {
        let shift = round % names.count
        let order = Array(names[shift...] + names[..<shift])
        orders.append(order)
        for name in order {
            let result = try run([build.appendingPathComponent(name).appendingPathComponent("benchmark").path], in: build)
            let line = result.stdout.trimmingCharacters(in: .whitespacesAndNewlines)
            let fields = line.split(separator: ";", omittingEmptySubsequences: false).map(String.init)
            guard fields.count == 5, let passes = Int(fields[1]), let seconds = Double(fields[2]), let threads = Int(fields[3]),
                  fields[0] == name, passes > 0, seconds >= 5, threads == 1, fields[4] == requiredTags,
                  result.stderr.contains(validationMarker) else {
                throw ToolError(description: "Invalid benchmark output for \(name): \(line) \(result.stderr)")
            }
            let sample = Sample(output: line, passes: passes, seconds: seconds, threads: threads, tags: fields[4],
                                validation: result.stderr.trimmingCharacters(in: .whitespacesAndNewlines),
                                milliseconds_per_pass: 1000 * seconds / Double(passes))
            samples[name, default: []].append(sample)
            print("\(name): \(String(format: "%.6f", sample.milliseconds_per_pass)) ms/pass (\(passes) passes)")
            fflush(stdout)
        }
    }

    let medians = samples.mapValues { median($0.map(\.milliseconds_per_pass)) }
    let host = hostDescription()
    let results = Results(
        recorded_at_utc: ISO8601DateFormatter().string(from: Date()),
        platform: host.platform, machine: host.machine, cpu: host.cpu,
        swift_version: try run(["swiftc", "--version"]).stdout.trimmingCharacters(in: .whitespacesAndNewlines),
        flags: ["-O", "-whole-module-optimization"],
        harness_revision: harnessRevision,
        runner_sha256: try sha256(of: runnerFile), observer_sha256: try sha256(of: observerFile),
        variants: variants, run_order: orders, samples: samples, median_ms: medians,
        speedup_over_first: medians.mapValues { medians[names[0]]! / $0 })
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    try (try encoder.encode(results) + Data("\n".utf8)).write(to: output, options: .withoutOverwriting)
    struct Summary: Codable { let median_ms: [String: Double]; let speedup_over_first: [String: Double] }
    print(String(decoding: try encoder.encode(Summary(median_ms: medians, speedup_over_first: results.speedup_over_first)), as: UTF8.self))
} catch {
    FileHandle.standardError.write(Data("error: \(error)\n".utf8))
    exit(1)
}
