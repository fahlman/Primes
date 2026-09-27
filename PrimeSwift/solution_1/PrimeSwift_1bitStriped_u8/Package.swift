// swift-tools-version:6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PrimeSieveSwift",
    platforms: [.macOS(.v27)],
    products: [
        .executable(
            name: "PrimeSieveSwift",
            targets: ["PrimeSieveSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.8.2")
    ],
    targets: [
        // The observer stays opaque to the executable's optimizer. Do not enable
        // cross-module optimization when building this package.
        .target(
            name: "BenchmarkObserver",
            swiftSettings: [
                .unsafeFlags(["-disable-cmo"], .when(configuration: .release)),
            ]),
        .executableTarget(
            name: "PrimeSieveSwift",
            dependencies: [
                "BenchmarkObserver",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            swiftSettings: [
                .unsafeFlags(["-whole-module-optimization", "-disable-cmo"], .when(configuration: .release)),
            ]),
    ]
)
