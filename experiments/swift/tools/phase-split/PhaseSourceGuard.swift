import Foundation
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

func phaseExitWithError(_ error: Error) -> Never {
    FileHandle.standardError.write(Data("error: \(error.localizedDescription)\n".utf8))
    exit(1)
}

// Git blob identities include Git's object header; these are not SHA256 file hashes.
// Git is already required by the experiment workflow. No package dependency is added.
func phaseGitBlob(_ data: Data) throws -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = ["git", "hash-object", "--stdin"]
    let input = Pipe()
    let output = Pipe()
    let errors = Pipe()
    process.standardInput = input
    process.standardOutput = output
    process.standardError = errors
    try process.run()
    input.fileHandleForWriting.write(data)
    try input.fileHandleForWriting.close()
    let result = output.fileHandleForReading.readDataToEndOfFile()
    let diagnostic = errors.fileHandleForReading.readDataToEndOfFile()
    process.waitUntilExit()
    let identity = String(decoding: result, as: UTF8.self)
        .trimmingCharacters(in: .whitespacesAndNewlines)
    guard process.terminationStatus == 0,
          [40, 64].contains(identity.count),
          identity.allSatisfy({ "0123456789abcdef".contains($0) }) else {
        throw phaseSourceError("Cannot compute Git blob identity: "
            + String(decoding: diagnostic, as: UTF8.self))
    }
    return identity
}

func phaseSourceError(_ message: String) -> NSError {
    NSError(domain: "CurrentPhaseSource", code: 1,
            userInfo: [NSLocalizedDescriptionKey: message])
}

struct PhaseSourceIdentity: Codable {
    let productionPath: String
    let productionGitBlob: String
    let derivedPath: String
    let derivedGitBlob: String

    func check() throws {
        for (path, expected) in [(productionPath, productionGitBlob),
                                 (derivedPath, derivedGitBlob)] {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            guard try phaseGitBlob(data) == expected else {
                throw phaseSourceError("Source changed since this diagnostic was generated: \(path). Rebuild from current production.")
            }
        }
    }
}
