// Linux/Docker validation tooling for the fork's GitHub workflow, in one Swift
// script with two subcommands, run on the native Linux runner host:
//   swift linux-validation.swift validate --solution-root DIR --solution-revision SHA \
//       --workflow-root DIR --platform linux/amd64|linux/arm64 --output DIR --build-output DIR \
//       [--checks NAME ...]
//   swift linux-validation.swift test-lifecycle [--output DIR] [--docker-probe] [--probe-image IMAGE]
// `validate` builds the committed Dockerfile and runs the existing Swift checks: a
// compatibility check, never a performance comparison. It never implements sieve
// logic and never changes the checked-out solution or Dockerfile. `test-lifecycle`
// runs the container-lifecycle tests against a fake Docker and real timed-out
// processes; with --docker-probe it also runs a small real Docker probe.
import Foundation
#if canImport(Glibc)
import Glibc
#elseif canImport(Darwin)
import Darwin
#endif

let sourceFiles = ["Dockerfile", "PrimeSieve.swift", "Benchmark.swift", "BenchmarkObserver.swift",
                   "Verify.swift", "ExtraVerify.swift", "tools/phase-split/PhaseSieve.swift",
                   "tools/phase-split/PhaseVerify.swift"]
let workflowFiles = [".github/workflows/swift-linux-docker-validation.yml",
                     "experiments/swift/tools/linux-docker/linux-validation.swift"]
let checkNames = ["verify-asan", "extra-verify-asan", "phase-verify-asan",
                  "verify-wmo", "extra-verify-wmo", "phase-verify-wmo"]
let lockPath = "/tmp/primes-timing.lock"
let ownerLabel = "org.fahlman.primes.validation-owner"

// MARK: - Errors, recorded with the same names the Python validator used

struct RuntimeError: Error, CustomStringConvertible {
    let message: String
    init(_ message: String) { self.message = message }
    var description: String { "RuntimeError: \(message)" }
}
struct TimeoutExpired: Error, CustomStringConvertible {
    let name: String
    let seconds: Int
    var description: String { "TimeoutExpired: \(name) exceeded \(seconds) s" }
}
struct ValidationInterrupted: Error, CustomStringConvertible {
    let signal: Int32
    var description: String { "ValidationInterrupted: Received signal \(signal)" }
}
struct AssertionError: Error, CustomStringConvertible {
    let message: String
    init(_ message: String) { self.message = message }
    var description: String { "AssertionError: \(message)" }
}
func describe(_ error: Error) -> String { (error as? CustomStringConvertible)?.description ?? "\(type(of: error)): \(error)" }

func utc() -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter.string(from: Date())
}

func jsonData(_ object: Any) throws -> Data {
    try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]) + Data("\n".utf8)
}

func jsonString(_ object: Any) -> String {
    (try? String(decoding: JSONSerialization.data(withJSONObject: object), as: UTF8.self)) ?? "\(object)"
}

func sha256(_ file: URL) throws -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = ["shasum", "-a", "256", file.path]
    let pipe = Pipe()
    process.standardOutput = pipe
    try process.run()
    let output = String(decoding: pipe.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self)
    process.waitUntilExit()
    guard process.terminationStatus == 0, let digest = output.split(separator: " ").first, digest.count == 64 else {
        throw RuntimeError("Cannot hash \(file.path)")
    }
    return String(digest)
}

func hashes(_ root: URL, _ names: [String]) throws -> [String: String] {
    var result: [String: String] = [:]
    for name in names { result[name] = try sha256(root.appendingPathComponent(name)) }
    return result
}

func matches(_ pattern: String, _ text: String) -> Bool {
    text.range(of: "^(?:" + pattern + ")$", options: .regularExpression) != nil
}

func fileInode(_ path: String) -> UInt64? {
    var info = stat()
    return stat(path, &info) == 0 ? UInt64(info.st_ino) : nil
}

// MARK: - Signals: handlers only log; the command loop and container steps act on the log

nonisolated(unsafe) let signalLog = UnsafeMutablePointer<Int32>.allocate(capacity: 64)
nonisolated(unsafe) var signalLogCount: Int32 = 0

func installSignalHandlers() {
    for number in [SIGINT, SIGTERM] {
        signal(number) { received in
            if signalLogCount < 64 {
                signalLog[Int(signalLogCount)] = received
                signalLogCount += 1
            }
        }
    }
}

func restoreSignalHandlers() {
    signal(SIGINT, SIG_DFL)
    signal(SIGTERM, SIG_DFL)
}

// MARK: - The evidence record

final class Journal {
    var record: [String: Any]
    var commands: [[String: Any]] = []
    var containers: [[String: Any]] = []
    let path: URL?
    private var drainedSignals: Int32 = 0

    init(_ record: [String: Any], path: URL?) {
        self.record = record
        self.path = path
        // Signals received before this journal existed belong to earlier work.
        drainedSignals = signalLogCount
    }

    subscript(key: String) -> Any? {
        get { record[key] }
        set { record[key] = newValue ?? NSNull() }
    }

    func bool(_ key: String) -> Bool { record[key] as? Bool ?? false }

    var interruptedSignals: [Int] { record["interrupted_signals"] as? [Int] ?? [] }

    /// Moves newly received signals into the record and returns the latest one
    /// unless cleanup is in progress, in which case the signal is only recorded.
    func pendingInterrupt() -> Int32? {
        var latest: Int32?
        while drainedSignals < signalLogCount {
            let number = signalLog[Int(drainedSignals)]
            drainedSignals += 1
            record["interrupted_signals"] = interruptedSignals + [Int(number)]
            latest = number
        }
        return bool("cleaning_up") ? nil : latest
    }

    func save() {
        record["commands"] = commands
        if !containers.isEmpty || record["containers"] != nil { record["containers"] = containers }
        guard let path else { return }
        try? jsonData(record).write(to: path)
    }
}

// MARK: - Commands in their own process group, with logs and a timeout

func spawn(_ command: [String], stdout: String, stderr: String) throws -> pid_t {
    #if canImport(Darwin)
    var actions: posix_spawn_file_actions_t? = nil
    var attributes: posix_spawnattr_t? = nil
    #else
    var actions = posix_spawn_file_actions_t()
    var attributes = posix_spawnattr_t()
    #endif
    posix_spawn_file_actions_init(&actions)
    posix_spawnattr_init(&attributes)
    defer { posix_spawn_file_actions_destroy(&actions); posix_spawnattr_destroy(&attributes) }
    posix_spawn_file_actions_addopen(&actions, 1, stdout, O_WRONLY | O_CREAT | O_TRUNC, 0o644)
    posix_spawn_file_actions_addopen(&actions, 2, stderr, O_WRONLY | O_CREAT | O_TRUNC, 0o644)
    posix_spawnattr_setflags(&attributes, Int16(POSIX_SPAWN_SETPGROUP))
    posix_spawnattr_setpgroup(&attributes, 0)
    let argv: [UnsafeMutablePointer<CChar>?] = command.map { strdup($0) } + [nil]
    defer { for pointer in argv { free(pointer) } }
    var pid: pid_t = 0
    let status = posix_spawnp(&pid, command[0], &actions, &attributes, argv, environ)
    guard status == 0 else { throw RuntimeError("Cannot start \(command[0]): \(String(cString: strerror(status)))") }
    return pid
}

/// Exit code as Python reported it: the status for a normal exit, minus the signal otherwise.
func exitCode(_ status: Int32) -> Int {
    (status & 0x7f) == 0 ? Int((status >> 8) & 0xff) : -Int(status & 0x7f)
}

func reap(_ pid: pid_t, within seconds: Double) -> Int? {
    let deadline = Date().addingTimeInterval(seconds)
    while true {
        var status: Int32 = 0
        let result = waitpid(pid, &status, WNOHANG)
        if result == pid { return exitCode(status) }
        if result < 0 { return nil }
        if Date() > deadline { return nil }
        usleep(20_000)
    }
}

final class CommandRunner {
    let output: URL
    let journal: Journal
    /// Called with the command name when it starts; the Docker probe uses it.
    var onStart: ((String) -> Void)?

    init(output: URL, journal: Journal) {
        self.output = output
        self.journal = journal
    }

    @discardableResult
    func callAsFunction(_ name: String, _ command: [String], timeout: Int = 1200) throws -> (stdout: String, stderr: String) {
        let number = journal.commands.count + 1
        let stdoutLog = "logs/" + String(format: "%02d", number) + "-\(name).stdout.log"
        let stderrLog = "logs/" + String(format: "%02d", number) + "-\(name).stderr.log"
        let stdoutPath = output.appendingPathComponent(stdoutLog).path
        let stderrPath = output.appendingPathComponent(stderrLog).path
        journal.commands.append(["name": name, "command": command, "started_at_utc": utc(),
                                 "timeout_seconds": timeout, "exit_code": NSNull(),
                                 "stdout_log": stdoutLog, "stderr_log": stderrLog])
        let index = journal.commands.count - 1
        journal.save()
        print("RUN \(name): \(jsonString(command))")
        fflush(stdout)
        onStart?(name)
        var pid: pid_t = 0
        do {
            if let number = journal.pendingInterrupt() { throw ValidationInterrupted(signal: number) }
            pid = try spawn(command, stdout: stdoutPath, stderr: stderrPath)
            journal.commands[index]["owned_process_group"] = Int(pid)
            let deadline = Date().addingTimeInterval(Double(timeout))
            while true {
                var status: Int32 = 0
                let result = waitpid(pid, &status, WNOHANG)
                if result == pid {
                    journal.commands[index]["exit_code"] = exitCode(status)
                    pid = 0
                    break
                }
                if result < 0 { throw RuntimeError("waitpid failed for \(name)") }
                if let number = journal.pendingInterrupt() { throw ValidationInterrupted(signal: number) }
                if Date() > deadline { throw TimeoutExpired(name: name, seconds: timeout) }
                usleep(50_000)
            }
        } catch {
            journal.commands[index]["error"] = describe(error)
            if pid > 0 {
                // Always signal the group, including children left after its leader
                // exits. Reap the client before inspecting containers.
                let alreadyCleaning = journal.bool("cleaning_up")
                journal["cleaning_up"] = true
                _ = kill(-pid, SIGTERM)
                var code = reap(pid, within: 2)
                _ = kill(-pid, SIGKILL)
                if code == nil { code = reap(pid, within: 2) }
                if let code {
                    journal.commands[index]["exit_code"] = code
                    journal.commands[index]["client_reaped_after_error"] = true
                } else {
                    journal.commands[index]["client_cleanup_error"] = "RuntimeError: client process \(pid) was not reaped after SIGKILL"
                }
                journal["cleaning_up"] = alreadyCleaning
            }
            journal.commands[index]["finished_at_utc"] = utc()
            journal.save()
            throw error
        }
        journal.commands[index]["finished_at_utc"] = utc()
        journal.save()
        let code = journal.commands[index]["exit_code"] as? Int ?? -1
        guard code == 0 else { throw RuntimeError("\(name) exited \(code); see \(stderrLog)") }
        return ((try? String(contentsOfFile: stdoutPath, encoding: .utf8)) ?? "",
                (try? String(contentsOfFile: stderrPath, encoding: .utf8)) ?? "")
    }
}

// MARK: - Containers owned by this invocation: create first, start only a verified one

typealias Runner = (String, [String], Int) throws -> (stdout: String, stderr: String)

final class OwnedContainers {
    let run: Runner
    let journal: Journal
    let owner = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()

    init(run: @escaping Runner, journal: Journal) {
        self.run = run
        self.journal = journal
        journal["container_owner"] = owner
        journal.containers = []
        journal.save()
    }

    private func entry(_ index: Int, _ key: String) -> Any? { journal.containers[index][key] }
    private func name(_ index: Int) -> String { entry(index, "name") as? String ?? "" }
    private func id(_ index: Int) -> String? { entry(index, "id") as? String }

    private func inspect(_ index: Int, _ containerID: String) throws -> [String: Any] {
        let text = try run("inspect-owned-" + name(index), ["docker", "container", "inspect", containerID], 5).stdout
        guard let list = try JSONSerialization.jsonObject(with: Data(text.utf8)) as? [[String: Any]], let info = list.first else {
            throw RuntimeError("Unreadable inspect output")
        }
        let labels = (info["Config"] as? [String: Any])?["Labels"] as? [String: Any]
        guard info["Id"] as? String == containerID, info["Name"] as? String == "/" + name(index),
              labels?[ownerLabel] as? String == owner, id(index) == nil || id(index) == containerID else {
            throw RuntimeError("Container identity/ownership mismatch; refusing removal or start")
        }
        journal.containers[index]["id"] = containerID
        journal.containers[index]["creation_confirmed"] = true
        journal.containers[index]["last_inspected_state"] = info["State"] ?? NSNull()
        journal.save()
        return info
    }

    private func matchingIDs(_ index: Int) throws -> [String] {
        // Once creation returned a verified ID, absence must be checked by that
        // ID: a renamed container can still be running under another name.
        let selector = id(index).map { "id=" + $0 } ?? "name=^/" + name(index) + "$"
        let text = try run("find-owned-" + name(index),
                           ["docker", "container", "ls", "--all", "--quiet", "--no-trunc", "--filter", selector], 5).stdout
        let ids = text.split(whereSeparator: { $0 == "\n" || $0 == " " }).map(String.init)
        guard ids.count <= 1, ids.allSatisfy({ matches("[0-9a-f]{64}", $0) }),
              id(index) == nil || ids.allSatisfy({ $0 == id(index) }) else {
            throw RuntimeError("Unexpected container lookup result")
        }
        return ids
    }

    func cleanup(_ index: Int) throws {
        if entry(index, "removed_confirmed") as? Bool == true { return }
        journal["cleaning_up"] = true
        defer { journal["cleaning_up"] = false; journal.save() }
        do {
            let ids = try matchingIDs(index)
            if let first = ids.first {
                _ = try inspect(index, first)
                _ = try run("remove-owned-" + name(index), ["docker", "container", "rm", "--force", first], 5)
                if !(try matchingIDs(index)).isEmpty { throw RuntimeError("Owned container still exists after removal") }
            } else if entry(index, "creation_confirmed") as? Bool != true {
                // A timed-out create request may still complete at the daemon. It
                // cannot start work, but absence is not a confirmed outcome.
                throw RuntimeError("Container creation outcome is unconfirmed; retain timing lock")
            }
            journal.containers[index]["removed_confirmed"] = true
            journal.containers[index]["removed_at_utc"] = utc()
        } catch {
            var errors = journal.containers[index]["cleanup_errors"] as? [String] ?? []
            errors.append(describe(error))
            journal.containers[index]["cleanup_errors"] = errors
            throw error
        }
    }

    @discardableResult
    func callAsFunction(_ operation: String, _ options: [String], timeout: Int = 1200) throws -> (stdout: String, stderr: String) {
        journal.containers.append(["operation": operation, "name": "swift-validation-\(owner)-\(journal.containers.count)",
                                   "creation_confirmed": false, "removed_confirmed": false])
        let index = journal.containers.count - 1
        journal.save()
        var primaryError: Error?
        var result: (stdout: String, stderr: String) = ("", "")
        do {
            let created = try run("create-" + operation, ["docker", "container", "create", "--name", name(index),
                                                           "--label", ownerLabel + "=" + owner] + options, 60).stdout
            let containerID = created.trimmingCharacters(in: .whitespacesAndNewlines)
            guard matches("[0-9a-f]{64}", containerID) else { throw RuntimeError("Docker create did not return a full container ID") }
            _ = try inspect(index, containerID)
            result = try run(operation, ["docker", "container", "start", "--attach", containerID], timeout)
            let state = try inspect(index, containerID)["State"] as? [String: Any] ?? [:]
            // The attached client's exit code alone does not establish that the
            // container command completed successfully. Inspect its own state.
            guard state["Running"] as? Bool == false, state["Status"] as? String == "exited",
                  (state["ExitCode"] as? Int) == 0 else {
                throw RuntimeError("\(operation) container did not exit successfully: \(jsonString(state))")
            }
        } catch {
            primaryError = error
            journal.containers[index]["error"] = describe(error)
        }
        do { try cleanup(index) } catch { if primaryError == nil { throw error } }
        if let primaryError { throw primaryError }
        if let last = journal.interruptedSignals.last { throw ValidationInterrupted(signal: Int32(last)) }
        return result
    }

    func cleanupAll() -> Bool {
        for index in journal.containers.indices {
            try? cleanup(index)  // Each failure is recorded; no uncertain lock release below.
        }
        return journal.containers.allSatisfy { $0["removed_confirmed"] as? Bool == true }
            && !journal.commands.contains { $0["client_cleanup_error"] != nil }
    }
}

func finishCleanup(_ containers: OwnedContainers, _ journal: Journal, lock: String, lockInode: UInt64?) -> Bool {
    let confirmed = containers.cleanupAll()
    journal["owned_container_cleanup_confirmed"] = confirmed
    if !confirmed {
        journal["status"] = "failed"
        journal["cleanup_error"] = "Owned Docker cleanup is unconfirmed; timing lock retained"
    } else if !journal.interruptedSignals.isEmpty {
        journal["status"] = "failed"
        if journal["error"] == nil { journal["error"] = "Validation interrupted by signal" }
    }
    if let lockInode, let current = fileInode(lock), current == lockInode {
        var lockRecord = journal["runner_local_lock"] as? [String: Any] ?? [:]
        if confirmed {
            try? FileManager.default.removeItem(atPath: lock)
            lockRecord["removed_in_finally"] = true
        } else {
            lockRecord["retained_due_to_unconfirmed_cleanup"] = true
        }
        journal["runner_local_lock"] = lockRecord
    }
    return confirmed
}

func acquireLock(_ path: String, description: String) throws -> UInt64 {
    let descriptor = open(path, O_WRONLY | O_CREAT | O_EXCL, 0o600)
    guard descriptor >= 0 else { throw RuntimeError("Cannot create \(path): \(String(cString: strerror(errno)))") }
    var info = stat()
    fstat(descriptor, &info)
    let text = description + "\n"
    _ = text.withCString { write(descriptor, $0, strlen($0)) }
    close(descriptor)
    return UInt64(info.st_ino)
}

func exit(with error: Error) -> Never {
    FileHandle.standardError.write(Data("error: \(describe(error))\n".utf8))
    exit(1)
}

// MARK: - validate

func validate(_ arguments: [String]) throws {
    let usage = "Usage: linux-validation.swift validate --solution-root DIR --solution-revision SHA --workflow-root DIR --platform linux/amd64|linux/arm64 --output DIR --build-output DIR [--checks NAME ...]"
    var options: [String: String] = [:]
    var checks: [String]?
    var index = 0
    while index < arguments.count {
        let flag = arguments[index]
        if flag == "--checks" {
            var names: [String] = []
            index += 1
            while index < arguments.count, !arguments[index].hasPrefix("--") { names.append(arguments[index]); index += 1 }
            guard !names.isEmpty, names.allSatisfy({ checkNames.contains($0) }) else { throw RuntimeError("--checks takes names from \(checkNames.joined(separator: ", "))") }
            guard Set(names).count == names.count else { throw RuntimeError("Each requested check must appear only once.") }
            checks = names
            continue
        }
        guard ["--solution-root", "--solution-revision", "--workflow-root", "--platform", "--output", "--build-output"].contains(flag),
              index + 1 < arguments.count, options[flag] == nil else { throw RuntimeError(usage) }
        options[flag] = arguments[index + 1]
        index += 2
    }
    guard let solutionRoot = options["--solution-root"], let solutionRevision = options["--solution-revision"],
          let workflowRoot = options["--workflow-root"], let platform = options["--platform"],
          let outputPath = options["--output"], let buildPath = options["--build-output"] else { throw RuntimeError(usage) }
    guard matches("[0-9a-f]{40}", solutionRevision) else { throw RuntimeError("The solution revision must be a complete lowercase commit SHA.") }
    guard ["linux/amd64", "linux/arm64"].contains(platform) else { throw RuntimeError("--platform must be linux/amd64 or linux/arm64") }
    let requestedChecks = checkNames.filter { (checks ?? checkNames).contains($0) }
    let checkScope = requestedChecks == checkNames ? "full_suite" : "targeted"

    let output = URL(fileURLWithPath: outputPath).standardizedFileURL
    try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
    guard try FileManager.default.contentsOfDirectory(atPath: output.path).isEmpty else { throw RuntimeError("Output directory must be new and empty: \(output.path)") }
    try FileManager.default.createDirectory(at: output.appendingPathComponent("logs"), withIntermediateDirectories: false)
    let solution = URL(fileURLWithPath: solutionRoot).standardizedFileURL
    let package = solution.appendingPathComponent("experiments/swift")
    let workflow = URL(fileURLWithPath: workflowRoot).standardizedFileURL
    let builds = URL(fileURLWithPath: buildPath).standardizedFileURL
    let environment = ProcessInfo.processInfo.environment
    let hostSystem = (try? Process.output(["uname", "-s"])) ?? "unknown"
    let hostMachine = (try? Process.output(["uname", "-m"])) ?? "unknown"
    var github: [String: Any] = [:]
    for key in ["GITHUB_REPOSITORY", "GITHUB_SHA", "GITHUB_REF", "GITHUB_RUN_ID", "GITHUB_RUN_ATTEMPT",
                "GITHUB_SERVER_URL", "RUNNER_OS", "RUNNER_ARCH", "ImageOS", "ImageVersion"] {
        github[key] = environment[key] ?? NSNull()
    }
    let journal = Journal([
        "status": "running", "started_at_utc": utc(),
        "purpose": "Linux/Docker correctness and runtime compatibility only; no speed claim.",
        "requested_solution_revision": solutionRevision, "requested_platform": platform,
        "check_scope": checkScope, "requested_checks": requestedChecks, "completed_checks": [String](),
        "unrequested_checks": checkNames.filter { !requestedChecks.contains($0) },
        "host_system": hostSystem, "host_machine": hostMachine, "github": github,
    ], path: output.appendingPathComponent("validation.json"))
    if let server = environment["GITHUB_SERVER_URL"], let repository = environment["GITHUB_REPOSITORY"], let runID = environment["GITHUB_RUN_ID"],
       !server.isEmpty, !repository.isEmpty, !runID.isEmpty {
        journal["run_url"] = server + "/" + repository + "/actions/runs/" + runID
    }
    let run = CommandRunner(output: output, journal: journal)
    let containers = OwnedContainers(run: { try run($0, $1, timeout: $2) }, journal: journal)
    installSignalHandlers()
    var lockInode: UInt64?
    var failed = false
    let expectedMachine = platform == "linux/amd64" ? "x86_64" : "aarch64"

    func inspectImage(_ name: String, _ image: String) throws -> [String: Any] {
        let text = try run(name, ["docker", "image", "inspect", image], timeout: 60).stdout
        guard let list = try JSONSerialization.jsonObject(with: Data(text.utf8)) as? [[String: Any]], let info = list.first else {
            throw RuntimeError("Unreadable image inspect output for \(image)")
        }
        guard info["Os"] as? String == "linux", info["Architecture"] as? String == platform.split(separator: "/").last.map(String.init) else {
            throw RuntimeError("Unexpected image platform for \(image)")
        }
        var summary: [String: Any] = [:]
        for key in ["Id", "RepoTags", "RepoDigests", "Os", "Architecture", "Created"] { summary[key] = info[key] ?? NSNull() }
        return summary
    }

    do {
        journal.save()
        guard hostSystem == "Linux", hostMachine == expectedMachine else { throw RuntimeError("This workflow requires the matching native Linux runner.") }
        // This lock protects this Linux runner only. The branch must still be
        // pushed after local M4 timing finishes; no shared cross-host lock exists.
        lockInode = try acquireLock(lockPath, description: "Swift Linux/Docker compatibility: \(solutionRevision) \(platform)")
        journal["runner_local_lock"] = ["path": lockPath, "acquired_exclusively": true]
        try FileManager.default.createDirectory(at: builds, withIntermediateDirectories: true)
        guard try FileManager.default.contentsOfDirectory(atPath: builds.path).isEmpty else { throw RuntimeError("Build output directory must be new and empty") }
        let head = try run("solution-head", ["git", "-C", solution.path, "rev-parse", "HEAD"], timeout: 60).stdout.trimmingCharacters(in: .whitespacesAndNewlines)
        guard head == solutionRevision else { throw RuntimeError("Solution checkout does not match the pinned revision.") }
        journal["solution_revision"] = head
        let status = try run("solution-clean", ["git", "-C", solution.path, "status", "--porcelain"], timeout: 60).stdout
        guard status.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { throw RuntimeError("Solution checkout contains uncommitted files.") }
        let workflowHead = try run("workflow-head", ["git", "-C", workflow.path, "rev-parse", "HEAD"], timeout: 60).stdout.trimmingCharacters(in: .whitespacesAndNewlines)
        journal["workflow_revision"] = workflowHead
        if let expected = environment["GITHUB_SHA"], !expected.isEmpty, workflowHead != expected { throw RuntimeError("Workflow checkout does not match the event revision.") }
        journal["source_sha256"] = try hashes(package, sourceFiles)
        journal["workflow_sha256"] = try hashes(workflow, workflowFiles)
        try run("host-kernel", ["uname", "-a"], timeout: 60)
        try run("host-cpu", ["lscpu"], timeout: 60)
        let version = try run("docker-version", ["docker", "version", "--format", "{{json .}}"], timeout: 60).stdout
        journal["docker_version"] = try JSONSerialization.jsonObject(with: Data(version.utf8))
        let backend = try run("docker-platform", ["docker", "info", "--format", "{{.OSType}}/{{.Architecture}}"], timeout: 60).stdout.trimmingCharacters(in: .whitespacesAndNewlines)
        guard backend == platform || backend == "linux/" + expectedMachine else { throw RuntimeError("Docker daemon is not the requested native Linux architecture.") }

        // Keep the Dockerfile untouched. Pull its versioned bases once, retain their
        // immutable digests, then use local images without requesting a fresh pull.
        let dockerfile = try String(contentsOf: package.appendingPathComponent("Dockerfile"), encoding: .utf8)
        let regex = try NSRegularExpression(pattern: "^FROM\\s+(\\S+)(?:\\s+AS\\s+(\\S+))?\\s*$", options: [.anchorsMatchLines, .caseInsensitive])
        let fromLines = regex.matches(in: dockerfile, range: NSRange(dockerfile.startIndex..., in: dockerfile)).map { match -> (String, String) in
            let image = Range(match.range(at: 1), in: dockerfile).map { String(dockerfile[$0]) } ?? ""
            let stage = Range(match.range(at: 2), in: dockerfile).map { String(dockerfile[$0]) } ?? ""
            return (image, stage)
        }
        guard fromLines.count == 2, fromLines[0] == ("swift:6.3.3", "build"), fromLines[1] == ("swift:6.3.3-slim", "") else {
            throw RuntimeError("Review this validator for the changed Dockerfile stages.")
        }
        var baseImages: [String: Any] = [:]
        for (number, (image, _)) in fromLines.enumerated() {
            try run("pull-base-\(number)", ["docker", "pull", "--platform", platform, image])
            let info = try inspectImage("inspect-base-\(number)", image)
            guard let digests = info["RepoDigests"] as? [String], !digests.isEmpty else { throw RuntimeError("No immutable digest recorded for \(image)") }
            baseImages[image] = info
        }
        journal["base_images"] = baseImages

        let suffix = String(solutionRevision.prefix(12)) + "-" + expectedMachine.replacingOccurrences(of: "x86_64", with: "amd64").replacingOccurrences(of: "aarch64", with: "arm64")
        let builder = "swift-validation-build:" + suffix
        let runtime = "swift-validation-runtime:" + suffix
        let commonBuild = ["docker", "build", "--progress=plain", "--pull=false", "--platform", platform, "--file", package.appendingPathComponent("Dockerfile").path]
        try run("build-compiler-stage", commonBuild + ["--target", "build", "--tag", builder, "--iidfile", output.appendingPathComponent("build-image.id").path, package.path])
        try run("build-runtime-image", commonBuild + ["--tag", runtime, "--iidfile", output.appendingPathComponent("runtime-image.id").path, package.path])
        journal["build_image"] = try inspectImage("inspect-build-image", builder)
        journal["runtime_image"] = try inspectImage("inspect-runtime-image", runtime)
        let container = ["--platform", platform, "--network", "none"]
        let swiftVersion = try containers("container-swift-version", container + ["--entrypoint", "swiftc", builder, "--version"], timeout: 60).stdout
        journal["swift_version"] = swiftVersion.trimmingCharacters(in: .whitespacesAndNewlines)
        guard swiftVersion.contains("Swift version 6.3.3") else { throw RuntimeError("Unexpected Swift compiler version in build stage.") }
        let smoke = try containers("runtime-smoke", container + [runtime], timeout: 120)
        let line = smoke.stdout.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = line.split(separator: ";", omittingEmptySubsequences: false).map(String.init)
        guard line.split(separator: "\n").count == 1, fields.count == 5 else { throw RuntimeError("Runtime image did not emit exactly one benchmark result.") }
        guard !fields[0].isEmpty, let passes = Int(fields[1]), passes > 0, let seconds = Double(fields[2]), seconds.isFinite, seconds >= 5,
              fields[3] == "1", fields[4] == "algorithm=base,faithful=yes,bits=1",
              matches("Validated: 78498 primes; checksum: [0-9]+", smoke.stderr.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            throw RuntimeError("Runtime image failed benchmark-output validation.")
        }
        journal["runtime_smoke"] = ["passes": passes, "seconds": seconds, "threads": 1, "tags": fields[4], "prime_count": 78498, "performance_evidence": false]

        // Both code and checks come from the same immutable checkout. The only
        // writable host mount holds newly compiled verification executables.
        let checking = container + ["--mount", "type=bind,source=\(package.path),target=/source,readonly",
                                    "--mount", "type=bind,source=\(builds.path),target=/validation", "--workdir", "/validation"]
        var completed: [String] = []
        for (mode, flags) in [("asan", ["-O", "-sanitize=address"]), ("wmo", ["-O", "-whole-module-optimization"])] {
            for (name, sources) in [("verify", ["Verify.swift"]), ("extra-verify", ["ExtraVerify.swift"]),
                                    ("phase-verify", ["tools/phase-split/PhaseSieve.swift", "tools/phase-split/PhaseVerify.swift"])] {
                let checkName = "\(name)-\(mode)"
                guard requestedChecks.contains(checkName) else { continue }
                let executable = "/validation/\(name)-\(mode)"
                try containers("compile-\(checkName)", checking + ["--entrypoint", "swiftc", builder] + flags + ["/source/PrimeSieve.swift"] + sources.map { "/source/" + $0 } + ["-o", executable])
                try containers("run-\(checkName)", checking + ["--entrypoint", executable, builder])
                completed.append(checkName)
                journal["completed_checks"] = completed
                journal.save()
            }
        }
        guard completed == requestedChecks else { throw RuntimeError("The completed checks do not match the requested checks.") }
        let after = try hashes(package, sourceFiles)
        journal["source_sha256_after"] = after
        guard after == journal["source_sha256"] as? [String: String] else { throw RuntimeError("The checked-out source changed during validation.") }
        journal["status"] = checkScope == "full_suite" ? "passed" : "passed_targeted"
    } catch {
        failed = true
        journal["status"] = "failed"
        journal["error"] = describe(error)
        let confirmed = finishCleanup(containers, journal, lock: lockPath, lockInode: lockInode)
        journal["finished_at_utc"] = utc()
        journal.save()
        print("Evidence: \(output.appendingPathComponent("validation.json").path)")
        _ = confirmed
        restoreSignalHandlers()
        throw error
    }
    let confirmed = finishCleanup(containers, journal, lock: lockPath, lockInode: lockInode)
    journal["finished_at_utc"] = utc()
    journal.save()
    print("Evidence: \(output.appendingPathComponent("validation.json").path)")
    restoreSignalHandlers()
    if !failed, !confirmed || !journal.interruptedSignals.isEmpty {
        throw RuntimeError(journal["cleanup_error"] as? String ?? "Validation interrupted by signal")
    }
}

extension Process {
    static func output(_ command: [String]) throws -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = command
        let pipe = Pipe()
        process.standardOutput = pipe
        try process.run()
        let text = String(decoding: pipe.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self)
        process.waitUntilExit()
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - test-lifecycle: the fake Docker and the focused tests

final class FakeDocker {
    var items: [(id: String, info: [String: Any])] = []
    var calls: [[String]] = []
    var startError: Error?
    var failRemove = false
    var uncertainCreate = false
    var foreignCollision = false
    var containerExitCode = 0
    var failLookup = false
    var renameOnStart = false

    func run(_ name: String, _ command: [String], _ timeout: Int) throws -> (stdout: String, stderr: String) {
        calls.append(command)
        let action = command[2]
        switch action {
        case "create":
            if uncertainCreate { throw TimeoutExpired(name: name, seconds: timeout) }
            let containerName = command[command.firstIndex(of: "--name")! + 1]
            let label = command[command.firstIndex(of: "--label")! + 1]
            let parts = label.split(separator: "=", maxSplits: 1).map(String.init)
            let containerID = String(repeating: "0", count: 63 - String(items.count + 1).count + 1) + String(items.count + 1)
            items.append((containerID, ["Id": containerID, "Name": "/" + containerName,
                                        "Config": ["Labels": [parts[0]: foreignCollision ? "someone-else" : parts[1]]],
                                        "State": ["Running": false, "Status": "created", "ExitCode": 0]]))
            if foreignCollision { throw RuntimeError("Name is already in use") }
            return (containerID + "\n", "")
        case "inspect":
            guard let item = items.first(where: { $0.id == command[3] }) else { throw RuntimeError("No such container") }
            return (String(decoding: try JSONSerialization.data(withJSONObject: [item.info]), as: UTF8.self), "")
        case "ls":
            if failLookup { throw RuntimeError("Docker daemon is unavailable") }
            let filter = command.last!
            if filter.hasPrefix("id=") {
                let target = String(filter.dropFirst(3))
                return (items.contains { $0.id == target } ? target : "", "")
            }
            let nameFilter = String(filter.dropFirst("name=^".count).dropLast())
            return (items.filter { $0.info["Name"] as? String == nameFilter }.map(\.id).joined(separator: "\n"), "")
        case "start":
            let target = command.last!
            guard let position = items.firstIndex(where: { $0.id == target }) else { throw RuntimeError("No such container") }
            if renameOnStart { items[position].info["Name"] = "/renamed-while-running" }
            if let startError {
                items[position].info["State"] = ["Running": true, "Status": "running", "ExitCode": 0]
                throw startError
            }
            items[position].info["State"] = ["Running": false, "Status": "exited", "ExitCode": containerExitCode]
            return ("finished\n", "")
        case "rm":
            if failRemove { throw RuntimeError("Docker removal failed") }
            items.removeAll { $0.id == command.last! }
            return ("", "")
        default:
            throw AssertionError("Unexpected docker command: \(command)")
        }
    }
}

func check(_ condition: Bool, _ message: String) throws { if !condition { throw AssertionError(message) } }

struct LifecycleFixture {
    let journal: Journal
    let docker: FakeDocker
    let containers: OwnedContainers
    let lock: String
    let inode: UInt64

    init(directory: URL) throws {
        journal = Journal(["status": "running"], path: nil)
        docker = FakeDocker()
        let fake = docker
        containers = OwnedContainers(run: { try fake.run($0, $1, $2) }, journal: journal)
        lock = directory.appendingPathComponent("lock").path
        try "owned\n".write(toFile: lock, atomically: true, encoding: .utf8)
        inode = fileInode(lock)!
    }

    func finish() -> Bool { finishCleanup(containers, journal, lock: lock, lockInode: inode) }
    var lockExists: Bool { FileManager.default.fileExists(atPath: lock) }
    func expectFailure<T: Error>(_ type: T.Type, _ body: () throws -> Void) throws -> T {
        do { try body() } catch let error as T { return error } catch { throw AssertionError("Expected \(T.self), got \(describe(error))") }
        throw AssertionError("Expected \(T.self), but the call succeeded")
    }
}

func lifecycleTests(in directory: URL) -> [(String, (LifecycleFixture) throws -> Void)] {
    [
        ("normal run removes the verified id and preserves an unrelated container", { f in
            let foreign = String(repeating: "f", count: 64)
            f.docker.items.append((foreign, ["Id": foreign, "Name": "/unrelated", "Config": ["Labels": [String: String]()]]))
            try check(try f.containers("normal", ["image"]).stdout == "finished\n", "start output")
            try check(f.docker.items.map(\.id) == [foreign], "only the unrelated container remains")
            let entry = f.journal.containers[0]
            try check(entry["removed_confirmed"] as? Bool == true, "removal confirmed")
            let starts = f.docker.calls.filter { $0[2] == "start" }
            try check(starts == [["docker", "container", "start", "--attach", entry["id"] as! String]], "started exactly the verified id")
            try check(f.finish() && !f.lockExists, "lock released after confirmed cleanup")
        }),
        ("timeout and interrupt preserve the primary error and remove the container", { f in
            let errors: [Error] = [TimeoutExpired(name: "docker", seconds: 1), ValidationInterrupted(signal: SIGTERM)]
            for error in errors {
                f.docker.startError = error
                do { try f.containers("interrupted", ["image"]); throw AssertionError("expected \(describe(error))") }
                catch { try check(describe(error) == describe(f.docker.startError!), "primary error preserved: \(describe(error))") }
                try check(f.docker.items.isEmpty, "container removed")
                try check(f.journal.containers.last?["removed_confirmed"] as? Bool == true, "removal confirmed")
            }
            f.journal["interrupted_signals"] = nil
            try check(f.finish() && !f.lockExists, "lock released")
        }),
        ("cleanup failure retains the lock and the original timeout", { f in
            f.docker.startError = TimeoutExpired(name: "docker", seconds: 1)
            f.docker.failRemove = true
            _ = try f.expectFailure(TimeoutExpired.self) { try f.containers("timeout", ["image"]) }
            try check(!f.finish() && f.lockExists, "lock retained")
            try check(f.journal["status"] as? String == "failed", "status failed")
            try check(!(f.journal.containers[0]["cleanup_errors"] as? [String] ?? []).isEmpty, "cleanup error recorded")
        }),
        ("client success cannot hide a nonzero container exit", { f in
            f.docker.containerExitCode = 7
            let error = try f.expectFailure(RuntimeError.self) { try f.containers("nonzero", ["image"]) }
            try check(error.message.contains("container did not exit successfully"), "error names the container exit")
            try check((f.journal.containers[0]["last_inspected_state"] as? [String: Any])?["ExitCode"] as? Int == 7, "exit code recorded")
            try check(f.docker.items.isEmpty && f.finish(), "container removed and cleanup confirmed")
        }),
        ("uncertain create never starts and retains the lock even if the lookup is empty", { f in
            f.docker.uncertainCreate = true
            _ = try f.expectFailure(TimeoutExpired.self) { try f.containers("create-timeout", ["image"]) }
            try check(!f.docker.calls.contains { $0[2] == "start" }, "never started")
            try check(!f.finish() && f.lockExists, "lock retained")
        }),
        ("failed lookup is not treated as container absence", { f in
            f.docker.failLookup = true
            _ = try f.expectFailure(RuntimeError.self) { try f.containers("lookup-failure", ["image"]) }
            try check(!f.finish() && !f.docker.items.isEmpty && f.lockExists, "container kept, lock retained")
        }),
        ("foreign name collision is never removed or started", { f in
            f.docker.foreignCollision = true
            _ = try f.expectFailure(RuntimeError.self) { try f.containers("collision", ["image"]) }
            try check(!f.docker.calls.contains { $0[2] == "rm" || $0[2] == "start" }, "no rm or start")
            try check(!f.finish() && !f.docker.items.isEmpty && f.lockExists, "foreign container kept, lock retained")
        }),
        ("renamed known container is not mistaken for absence", { f in
            f.docker.renameOnStart = true
            f.docker.startError = TimeoutExpired(name: "docker", seconds: 1)
            _ = try f.expectFailure(TimeoutExpired.self) { try f.containers("renamed", ["image"]) }
            try check(!f.finish(), "cleanup unconfirmed")
            let entry = f.journal.containers[0]
            try check(entry["removed_confirmed"] as? Bool != true, "not marked removed")
            try check(f.docker.items.contains { $0.id == entry["id"] as? String }, "container still present")
            try check(f.docker.calls.contains { $0[2] == "ls" && $0.last == "id=" + (entry["id"] as! String) }, "looked up by id")
            try check(f.lockExists, "lock retained")
        }),
        ("unreaped client retains the lock without containers", { f in
            f.journal.commands.append(["client_cleanup_error": "Unable to stop client"])
            try check(!f.finish() && f.lockExists, "lock retained")
        }),
        ("lock with another inode is not removed", { f in
            let other = LifecycleFixture(journal: f.journal, docker: f.docker, containers: f.containers, lock: f.lock, inode: f.inode + 1)
            try check(other.finish() && f.lockExists, "foreign lock kept")
        }),
        ("signal is recorded, interrupts when idle and is deferred during cleanup", { f in
            installSignalHandlers()
            defer { restoreSignalHandlers() }
            kill(getpid(), SIGTERM); usleep(100_000)
            try check(f.journal.pendingInterrupt() == SIGTERM, "first signal interrupts")
            f.journal["cleaning_up"] = true
            kill(getpid(), SIGTERM); usleep(100_000)
            try check(f.journal.pendingInterrupt() == nil, "signal deferred during cleanup")
            f.journal["cleaning_up"] = false
            try check(f.journal.interruptedSignals == [Int(SIGTERM), Int(SIGTERM)], "both signals recorded: \(f.journal.interruptedSignals)")
        }),
        ("timeout stops the process group and reaps the client with partial logs", { f in
            let output = directory.appendingPathComponent("client-timeout")
            try FileManager.default.createDirectory(at: output.appendingPathComponent("logs"), withIntermediateDirectories: true)
            let journal = Journal([:], path: nil)
            let runner = CommandRunner(output: output, journal: journal)
            _ = try f.expectFailure(TimeoutExpired.self) { try runner("client", ["sh", "-c", "echo partial output; sleep 30"], timeout: 1) }
            let entry = journal.commands[0]
            try check(entry["client_reaped_after_error"] as? Bool == true, "client reaped")
            try check(entry["error"] != nil && entry["owned_process_group"] != nil, "error and group recorded")
            let log = try String(contentsOf: output.appendingPathComponent(entry["stdout_log"] as! String), encoding: .utf8)
            try check(log.contains("partial output"), "partial log preserved")
            let group = pid_t(entry["owned_process_group"] as! Int)
            usleep(100_000)
            try check(kill(-group, 0) != 0, "process group gone")
        }),
        ("interrupt stops the running command and reaps the client", { f in
            let output = directory.appendingPathComponent("client-interrupt")
            try FileManager.default.createDirectory(at: output.appendingPathComponent("logs"), withIntermediateDirectories: true)
            let journal = Journal([:], path: nil)
            let runner = CommandRunner(output: output, journal: journal)
            installSignalHandlers()
            defer { restoreSignalHandlers() }
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { kill(getpid(), SIGTERM) }
            let error = try f.expectFailure(ValidationInterrupted.self) { try runner("client", ["sh", "-c", "echo started; sleep 30"], timeout: 10) }
            try check(error.signal == SIGTERM, "SIGTERM reported")
            try check(journal.commands[0]["client_reaped_after_error"] as? Bool == true, "client reaped")
            try check(journal.interruptedSignals == [Int(SIGTERM)], "signal recorded")
        }),
    ]
}

extension LifecycleFixture {
    init(journal: Journal, docker: FakeDocker, containers: OwnedContainers, lock: String, inode: UInt64) {
        self.journal = journal; self.docker = docker; self.containers = containers; self.lock = lock; self.inode = inode
    }
}

func dockerProbe(output: URL, image: String) throws {
    try FileManager.default.createDirectory(at: output.appendingPathComponent("logs"), withIntermediateDirectories: true)
    let journal = Journal(["purpose": "Small Docker lifecycle probe; no Swift or performance validation.",
                           "status": "running", "started_at_utc": utc(), "probe_image": image],
                          path: output.appendingPathComponent("probe.json"))
    let run = CommandRunner(output: output, journal: journal)
    run.onStart = { name in
        // Creation and ownership inspection have completed at this point.
        if name == "probe-sigterm" { DispatchQueue.global().asyncAfter(deadline: .now() + 1) { kill(getpid(), SIGTERM) } }
    }
    let containers = OwnedContainers(run: { try run($0, $1, timeout: $2) }, journal: journal)
    installSignalHandlers()
    var lockInode: UInt64?
    var failed = false
    func requireStarted(_ name: String, _ marker: String) throws {
        guard let command = journal.commands.first(where: { $0["name"] as? String == name }),
              let log = try? String(contentsOf: output.appendingPathComponent(command["stdout_log"] as! String), encoding: .utf8),
              log.split(separator: "\n").contains(Substring(marker)) else {
            throw AssertionError("Interrupted probe did not establish that container work started")
        }
        var markers = journal["observed_start_markers"] as? [String: String] ?? [:]
        markers[name] = marker
        journal["observed_start_markers"] = markers
    }
    do {
        lockInode = try acquireLock(lockPath, description: "Swift validation Docker lifecycle probe")
        try run("probe-pull", ["docker", "pull", image], timeout: 120)
        let info = try run("probe-image", ["docker", "image", "inspect", image], timeout: 5).stdout
        journal["image_inspect"] = try JSONSerialization.jsonObject(with: Data(info.utf8))
        let options = ["--network", "none", image, "sh", "-c"]
        try containers("probe-normal", options + ["exit 0"], timeout: 5)
        do { try containers("probe-nonzero", options + ["exit 7"], timeout: 5); throw AssertionError("Expected a nonzero container exit to fail") }
        catch is RuntimeError {
            guard (journal.containers.last?["last_inspected_state"] as? [String: Any])?["ExitCode"] as? Int == 7 else { throw AssertionError("The nonzero container outcome was not recorded") }
            journal["nonzero_exit_observed"] = 7
        }
        do { try containers("probe-timeout", options + ["echo probe-started-timeout; exec sleep 10"], timeout: 1); throw AssertionError("Expected a client timeout") }
        catch is TimeoutExpired {
            try requireStarted("probe-timeout", "probe-started-timeout")
            journal["timeout_observed"] = true
        }
        do { try containers("probe-sigterm", options + ["echo probe-started-sigterm; exec sleep 10"], timeout: 5); throw AssertionError("Expected SIGTERM cancellation") }
        catch is ValidationInterrupted {
            try requireStarted("probe-sigterm", "probe-started-sigterm")
            let observed = journal.interruptedSignals
            journal["expected_interrupt_signals"] = observed
            journal["interrupted_signals"] = nil
            guard observed == [Int(SIGTERM)] else { throw AssertionError("Unexpected interrupt signal record: \(observed)") }
        }
        guard journal.containers.allSatisfy({ $0["removed_confirmed"] as? Bool == true }) else { throw AssertionError("An owned probe container remains") }
        journal["status"] = "passed_lifecycle_probe"
    } catch {
        failed = true
        journal["status"] = "failed"
        journal["error"] = describe(error)
        _ = finishCleanup(containers, journal, lock: lockPath, lockInode: lockInode)
        journal["finished_at_utc"] = utc()
        journal.save()
        restoreSignalHandlers()
        throw error
    }
    let confirmed = finishCleanup(containers, journal, lock: lockPath, lockInode: lockInode)
    journal["finished_at_utc"] = utc()
    journal.save()
    restoreSignalHandlers()
    if !failed, !confirmed { throw RuntimeError(journal["cleanup_error"] as? String ?? "cleanup unconfirmed") }
}

func testLifecycle(_ arguments: [String]) throws {
    var outputPath: String?
    var probe = false
    var image = "busybox:1.37.0"
    var index = 0
    while index < arguments.count {
        switch arguments[index] {
        case "--docker-probe": probe = true; index += 1
        case "--output": guard index + 1 < arguments.count else { throw RuntimeError("--output needs a directory") }; outputPath = arguments[index + 1]; index += 2
        case "--probe-image": guard index + 1 < arguments.count else { throw RuntimeError("--probe-image needs a name") }; image = arguments[index + 1]; index += 2
        default: throw RuntimeError("Usage: linux-validation.swift test-lifecycle [--output DIR] [--docker-probe] [--probe-image IMAGE]")
        }
    }
    if probe, outputPath == nil { throw RuntimeError("--docker-probe requires a new --output directory") }
    let output = outputPath.map { URL(fileURLWithPath: $0).standardizedFileURL }
    if let output {
        try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
        guard try FileManager.default.contentsOfDirectory(atPath: output.path).isEmpty else { throw RuntimeError("Output directory must be new and empty: \(output.path)") }
    }
    let scratch = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("linux-validation-tests-" + UUID().uuidString)
    try FileManager.default.createDirectory(at: scratch, withIntermediateDirectories: true)
    defer { try? FileManager.default.removeItem(at: scratch) }
    let started = utc()
    var lines: [String] = []
    var failures = 0
    let tests = lifecycleTests(in: scratch)
    for (number, (name, body)) in tests.enumerated() {
        let directory = scratch.appendingPathComponent("test-\(number)")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        do {
            try body(try LifecycleFixture(directory: directory))
            lines.append("\(name) ... ok")
        } catch {
            failures += 1
            lines.append("\(name) ... FAIL: \(describe(error))")
        }
        print(lines.last!)
        fflush(stdout)
    }
    let summary: [String: Any] = ["status": failures == 0 ? "passed" : "failed", "tests_run": tests.count, "failures": failures, "errors": 0,
                                  "started_at_utc": started, "finished_at_utc": utc(), "command": CommandLine.arguments,
                                  "source_sha256": ["linux-validation.swift": try sha256(URL(fileURLWithPath: #filePath))]]
    if let output {
        try (lines.joined(separator: "\n") + "\n").write(to: output.appendingPathComponent("unit-tests.log"), atomically: true, encoding: .utf8)
        try jsonData(summary).write(to: output.appendingPathComponent("unit-results.json"))
    }
    guard failures == 0 else { throw RuntimeError("\(failures) of \(tests.count) lifecycle tests failed") }
    if probe, let output { try dockerProbe(output: output.appendingPathComponent("docker-probe"), image: image) }
}

// MARK: - Entry point

do {
    let arguments = Array(CommandLine.arguments.dropFirst())
    switch arguments.first {
    case "validate": try validate(Array(arguments.dropFirst()))
    case "test-lifecycle": try testLifecycle(Array(arguments.dropFirst()))
    default: throw RuntimeError("Usage: linux-validation.swift validate ... | test-lifecycle ...")
    }
} catch {
    exit(with: error)
}
