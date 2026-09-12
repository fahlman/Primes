// Compile with PhaseSourceGuard.swift. This generator never runs a sieve.
import Foundation

@main
struct GenerateCurrentPhaseSieve {
    static func main() throws {
        let arguments = Array(CommandLine.arguments.dropFirst())
        guard arguments.count == 4, arguments[0] == "--source", arguments[2] == "--output" else {
            throw phaseSourceError("Usage: generate-current-phase --source PrimeSieve.swift --output NEW_DIRECTORY")
        }
        let sourceURL = URL(fileURLWithPath: arguments[1]).standardizedFileURL
        let outputURL = URL(fileURLWithPath: arguments[3]).standardizedFileURL
        guard !FileManager.default.fileExists(atPath: outputURL.path) else {
            throw phaseSourceError("Refusing to overwrite generated input directory: \(outputURL.path)")
        }
        let sourceData = try Data(contentsOf: sourceURL)
        guard let source = String(data: sourceData, encoding: .utf8) else {
            throw phaseSourceError("Production source is not UTF-8")
        }
        let substitutions = [
            ("final class PrimeSieve {", "final class CurrentPhaseSieve {"),
            ("    func runSieve() {", "    func runSieve(throughFactor cap: Int = .max) {"),
            ("        while p <= limit / p {", "        while p <= limit / p && p <= cap {"),
        ]
        var derived = source
        for (original, replacement) in substitutions {
            guard derived.components(separatedBy: original).count == 2,
                  !derived.contains(replacement) else {
                throw phaseSourceError("Expected exactly one supported source anchor and no existing replacement: \(original). Review the transformation for this production revision.")
            }
            derived = derived.replacingOccurrences(of: original, with: replacement)
        }
        var normalized = derived
        for (original, replacement) in substitutions.reversed() {
            normalized = normalized.replacingOccurrences(of: replacement, with: original)
        }
        guard Data(normalized.utf8) == sourceData else {
            throw phaseSourceError("Normalization did not reproduce the complete production source")
        }
        let sourceBlob = try phaseGitBlob(sourceData)
        let header = "// GENERATED diagnostic; regenerate from current production, never edit.\n"
            + "// Production Git blob: \(sourceBlob)\n"
            + "// Only class name, runSieve signature and factor cutoff differ.\n"
        let derivedData = Data((header + derived).utf8)
        let derivedURL = outputURL.appendingPathComponent("CurrentPhaseSieve.swift")
        let identity = PhaseSourceIdentity(productionPath: sourceURL.path,
                                          productionGitBlob: sourceBlob,
                                          derivedPath: derivedURL.path,
                                          derivedGitBlob: try phaseGitBlob(derivedData))
        let metadata = "// Generated identity of the two source files used by this diagnostic.\n"
            + "enum CurrentPhaseBuild {\n"
            + "    static let identity = PhaseSourceIdentity(\n"
            + "        productionPath: \(String(reflecting: identity.productionPath)),\n"
            + "        productionGitBlob: \(String(reflecting: identity.productionGitBlob)),\n"
            + "        derivedPath: \(String(reflecting: identity.derivedPath)),\n"
            + "        derivedGitBlob: \(String(reflecting: identity.derivedGitBlob)))\n"
            + "}\n"
        try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: false)
        try derivedData.write(to: derivedURL, options: .withoutOverwriting)
        try Data(metadata.utf8).write(to: outputURL.appendingPathComponent("CurrentPhaseIdentity.swift"),
                                     options: .withoutOverwriting)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        try encoder.encode(identity).write(to: outputURL.appendingPathComponent("source-identity.json"),
                                           options: .withoutOverwriting)
        try identity.check()
        print("Generated current diagnostic from production Git blob \(sourceBlob); exactly three reversible substitutions.")
    }
}
