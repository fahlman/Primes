// Compare a committed candidate with the three upstream Swift entries, all built
// with the frozen benchmark runner and observer from revision 25402d4 so every
// variant is timed by the same harness. The upstream sources are downloaded at
// the pinned revision and adapted only so the frozen runner can drive them.
// Three rotated five-second runs per variant, twelve in all. Run while holding
// the project's timing lock, from any directory, with network access:
//   swift tools/compare-upstream.swift --output RESULTS.json [--candidate REVISION] [--repo PATH]
// The candidate defaults to HEAD. The output file must not exist. Timing counts
// as evidence only on the reference machine; see AGENTS.md.
import Foundation

let harnessRevision = "25402d46ba991b39451724d3873d326626981e3f"
let upstreamRevision = "22bfea9c7122c46dcda799020fccf5ae83fe667f"
let package = "experiments/swift"
let frozenLabel = "fahlman_swift_striped_unrolled"
let frozenByteCount = "let byteCount = ((limit - 1) / 2 + 7) / 8"
let validationMarker = "Validated: 78498 primes;"
let rounds = 3
let candidateName = "candidate"
let usage = "Usage: compare-upstream.swift --output RESULTS.json [--candidate REVISION] [--repo PATH]"

struct Adapter { let name: String; let directory: String; let bits: Int }
let adapters = [
    Adapter(name: "repository-bool", directory: "PrimeSwift_8bitBool", bits: 8),
    Adapter(name: "repository-packed", directory: "PrimeSwift_1bit_u8", bits: 1),
    Adapter(name: "repository-striped", directory: "PrimeSwift_1bitStriped_u8", bits: 1),
]

struct ToolError: Error, CustomStringConvertible { let description: String }
struct Command { let stdout: String; let stderr: String }

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
    guard let digest = output.split(separator: " ").first, digest.count == 64 else { throw ToolError(description: "Cannot hash \(file.path)") }
    return String(digest)
}

func median(_ values: [Double]) -> Double {
    let sorted = values.sorted(); let n = sorted.count
    return n % 2 == 1 ? sorted[n / 2] : (sorted[n / 2 - 1] + sorted[n / 2]) / 2
}

func download(_ url: URL) throws -> String {
    var received: Data?
    var failure: Error?
    let done = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let http = response as? HTTPURLResponse, http.statusCode != 200 {
            failure = ToolError(description: "HTTP \(http.statusCode) for \(url)")
        } else { received = data; failure = error }
        done.signal()
    }.resume()
    guard done.wait(timeout: .now() + 120) == .success else { throw ToolError(description: "Timed out downloading \(url)") }
    if let failure { throw failure }
    guard let received, let text = String(data: received, encoding: .utf8) else { throw ToolError(description: "Empty download: \(url)") }
    return text
}

/// Replaces exactly one occurrence, so an upstream or runner change can't pass silently.
func replaceOnce(_ text: String, _ old: String, _ new: String, label: String) throws -> String {
    guard text.components(separatedBy: old).count == 2 else { throw ToolError(description: "Expected exactly one \(label) in the source to adapt") }
    return text.replacingOccurrences(of: old, with: new)
}

/// The same source surgery the Python harness performed: drop the CLI parts of the
/// upstream file and add the storage and prime accessors the frozen runner calls.
func adapt(_ upstream: String, bits: Int) throws -> String {
    guard let cut = upstream.range(of: "extension Sieve {\n    func printResults") else { throw ToolError(description: "Upstream source shape changed: no printResults extension") }
    var source = String(upstream[..<cut.lowerBound])
    source = try replaceOnce(source, "import ArgumentParser\n", "", label: "ArgumentParser import")
    if bits == 1 {
        guard let start = source.range(of: "let bitMasks ="), let end = source.range(of: "// This is a very limited") else {
            throw ToolError(description: "Upstream source shape changed: bitMasks table not found")
        }
        source = String(source[..<start.lowerBound]) + """
        let bitMasks: UnsafeMutableBufferPointer<Word> = {
            let masks = UnsafeMutableBufferPointer<Word>.allocate(capacity: wordSize)
            _ = masks.initialize(from: ContiguousArray((0..<wordSize).lazy.map { Word(1) &<< $0 }))
            return masks
        }()


        """ + String(source[end.lowerBound...])
        source += """

        extension BooleanBitArray {
            func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
                body(words.baseAddress)
            }
        }
        extension Sieve {
            func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
                primeArray.withStorage(body)
            }
            func primes() -> [Int] {
                var result = [2]
                for num in stride(from: 3, to: sieveLimit, by: 2) {
                    if primeArray.getBit(at: index(for: num)) { result.append(num) }
                }
                return result
            }
        }

        """
    } else {
        source += """

        extension Sieve {
            func withStorage<R>(_ body: (UnsafeRawPointer?) -> R) -> R {
                body(bits.baseAddress)
            }
            func primes() -> [Int] {
                var result = [2]
                for num in stride(from: 3, to: sieveSize, by: 2) {
                    if bits[index(for: num)] { result.append(num) }
                }
                return result
            }
        }

        """
    }
    return source + "\ntypealias PrimeSieve = Sieve\n"
}

struct Sample: Codable {
    let output: String; let passes: Int; let seconds: Double; let threads: Int; let tags: String
    let validation: String; let milliseconds_per_pass: Double
}
struct AdapterRecord: Codable { let directory: String; let bits: Int; let upstream_sha256: String; let adapted_sha256: String }
struct Candidate: Codable { let revision: String; let source_sha256: String }
struct Results: Codable {
    let recorded_at_utc: String; let platform: String; let machine: String; let cpu: String; let swift_version: String
    let flags: [String]; let harness_revision: String; let runner_sha256: String; let observer_sha256: String
    let revision: String; let adapters: [String: AdapterRecord]; let candidate: Candidate
    let run_order: [[String]]; let samples: [String: [Sample]]; let median_ms: [String: Double]; let speedups: [String: Double]
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
    var outputPath: String?, candidateRequested = "HEAD", repoPath: String?
    let arguments = Array(CommandLine.arguments.dropFirst())
    var index = 0
    while index < arguments.count {
        guard index + 1 < arguments.count else { throw ToolError(description: usage) }
        let value = arguments[index + 1]
        switch arguments[index] {
        case "--output": guard outputPath == nil else { throw ToolError(description: usage) }; outputPath = value
        case "--candidate": candidateRequested = value
        case "--repo": guard repoPath == nil else { throw ToolError(description: usage) }; repoPath = value
        default: throw ToolError(description: usage)
        }
        index += 2
    }
    guard let outputPath else { throw ToolError(description: usage) }
    let output = URL(fileURLWithPath: outputPath)
    guard !FileManager.default.fileExists(atPath: output.path) else { throw ToolError(description: "Refusing to overwrite \(output.path)") }

    let scriptDirectory = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
    let repo = URL(fileURLWithPath: try run(["git", "rev-parse", "--show-toplevel"], in: URL(fileURLWithPath: repoPath ?? scriptDirectory.path)).stdout.trimmingCharacters(in: .whitespacesAndNewlines))
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
    let candidateRevision = try run(["git", "-C", repo.path, "rev-parse", "--verify", "\(candidateRequested)^{commit}"]).stdout.trimmingCharacters(in: .whitespacesAndNewlines)

    let build = repo.appendingPathComponent(package).appendingPathComponent(".build/upstream-comparison")
    try FileManager.default.createDirectory(at: build, withIntermediateDirectories: true)
    let observerFile = build.appendingPathComponent("BenchmarkObserver.swift")
    let runnerFile = build.appendingPathComponent("Benchmark.swift")
    try source(harnessRevision, "BenchmarkObserver.swift").write(to: observerFile)
    try source(harnessRevision, "Benchmark.swift").write(to: runnerFile)
    let runnerText = try String(contentsOf: runnerFile, encoding: .utf8)
    try run(["swiftc", "-O", "-parse-as-library", "-module-name", "BenchmarkObserver",
             "-emit-module", "-emit-module-path", build.appendingPathComponent("BenchmarkObserver.swiftmodule").path,
             "-emit-object", observerFile.path, "-o", build.appendingPathComponent("BenchmarkObserver.o").path], in: build)

    func compile(_ name: String, sieve: URL, runner: String) throws {
        let runnerPath = build.appendingPathComponent("\(name)-runner.swift")
        try runner.write(to: runnerPath, atomically: true, encoding: .utf8)
        try run(["swiftc", "-O", "-whole-module-optimization", "-I", build.path, sieve.path, runnerPath.path,
                 build.appendingPathComponent("BenchmarkObserver.o").path, "-o", build.appendingPathComponent(name).path], in: build)
    }

    var records: [String: AdapterRecord] = [:]
    for adapter in adapters {
        let url = URL(string: "https://raw.githubusercontent.com/PlummersSoftwareLLC/Primes/\(upstreamRevision)/PrimeSwift/solution_1/\(adapter.directory)/Sources/PrimeSieveSwift/main.swift")!
        let upstream = try download(url)
        let upstreamFile = build.appendingPathComponent("\(adapter.name)-upstream.swift")
        try upstream.write(to: upstreamFile, atomically: true, encoding: .utf8)
        let adaptedFile = build.appendingPathComponent("\(adapter.name).swift")
        try adapt(upstream, bits: adapter.bits).write(to: adaptedFile, atomically: true, encoding: .utf8)
        var runner = try replaceOnce(runnerText, frozenLabel, adapter.name, label: "runner label")
        runner = try replaceOnce(runner, "bits=1", "bits=\(adapter.bits)", label: "bits tag")
        if adapter.bits == 8 {
            runner = try replaceOnce(runner, frozenByteCount, "let byteCount = (limit + 1) / 2", label: "byte-count line")
        }
        try compile(adapter.name, sieve: adaptedFile, runner: runner)
        records[adapter.name] = AdapterRecord(directory: adapter.directory, bits: adapter.bits,
                                              upstream_sha256: try sha256(of: upstreamFile), adapted_sha256: try sha256(of: adaptedFile))
        print("built \(adapter.name)"); fflush(stdout)
    }
    let candidateFile = build.appendingPathComponent("\(candidateName)-PrimeSieve.swift")
    try source(candidateRevision, "PrimeSieve.swift").write(to: candidateFile)
    try compile(candidateName, sieve: candidateFile, runner: try replaceOnce(runnerText, frozenLabel, candidateName, label: "runner label"))
    print("built \(candidateName) at \(candidateRevision)"); fflush(stdout)

    let names = adapters.map(\.name) + [candidateName]
    var samples: [String: [Sample]] = Dictionary(uniqueKeysWithValues: names.map { ($0, []) })
    var orders: [[String]] = []
    for round in 0..<rounds {
        let shift = round % names.count
        let order = Array(names[shift...] + names[..<shift])
        orders.append(order)
        for name in order {
            let bits = adapters.first { $0.name == name }?.bits ?? 1
            let result = try run([build.appendingPathComponent(name).path], in: build)
            let line = result.stdout.trimmingCharacters(in: .whitespacesAndNewlines)
            let fields = line.split(separator: ";", omittingEmptySubsequences: false).map(String.init)
            guard fields.count == 5, let passes = Int(fields[1]), let seconds = Double(fields[2]), let threads = Int(fields[3]),
                  fields[0] == name, passes > 0, seconds >= 5, threads == 1,
                  fields[4] == "algorithm=base,faithful=yes,bits=\(bits)", result.stderr.contains(validationMarker) else {
                throw ToolError(description: "Invalid benchmark output for \(name): \(line) \(result.stderr)")
            }
            samples[name, default: []].append(Sample(output: line, passes: passes, seconds: seconds, threads: threads, tags: fields[4],
                                                     validation: result.stderr.trimmingCharacters(in: .whitespacesAndNewlines),
                                                     milliseconds_per_pass: 1000 * seconds / Double(passes)))
            print(line); fflush(stdout)
        }
    }

    let medians = samples.mapValues { median($0.map(\.milliseconds_per_pass)) }
    let speedups = Dictionary(uniqueKeysWithValues: adapters.map { ($0.name, medians[$0.name]! / medians[candidateName]!) })
    let host = hostDescription()
    let results = Results(
        recorded_at_utc: ISO8601DateFormatter().string(from: Date()), platform: host.platform, machine: host.machine, cpu: host.cpu,
        swift_version: try run(["swiftc", "--version"]).stdout.trimmingCharacters(in: .whitespacesAndNewlines),
        flags: ["-O", "-whole-module-optimization"], harness_revision: harnessRevision,
        runner_sha256: try sha256(of: runnerFile), observer_sha256: try sha256(of: observerFile),
        revision: upstreamRevision, adapters: records,
        candidate: Candidate(revision: candidateRevision, source_sha256: try sha256(of: candidateFile)),
        run_order: orders, samples: samples, median_ms: medians, speedups: speedups)
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    try (try encoder.encode(results) + Data("\n".utf8)).write(to: output, options: .withoutOverwriting)
    struct Summary: Codable { let median_ms: [String: Double]; let speedups: [String: Double] }
    print(String(decoding: try encoder.encode(Summary(median_ms: medians, speedups: speedups)), as: UTF8.self))
} catch {
    FileHandle.standardError.write(Data("error: \(error)\n".utf8))
    exit(1)
}
