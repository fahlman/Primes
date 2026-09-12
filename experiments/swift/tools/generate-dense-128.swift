// Compatibility entry point for existing checks. Both dense switches now come
// from the canonical generator; forward arguments, working directory and stdio.
import Foundation

let generator = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
    .appendingPathComponent("generate-dense.swift")
let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
process.arguments = ["swift", generator.path] + Array(CommandLine.arguments.dropFirst())
do {
    try process.run()
    process.waitUntilExit()
    exit(process.terminationStatus)
} catch {
    FileHandle.standardError.write(Data((error.localizedDescription + "\n").utf8))
    exit(1)
}
