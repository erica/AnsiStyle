// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnsiStyle",
    platforms: [
      .macOS(.v10_12)
    ],
    products: [
        .library(
            name: "AnsiStyle",
            targets: ["AnsiStyle"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AnsiStyle",
            dependencies: [],
            path: "Sources/"
            ),
    ],
    swiftLanguageVersions: [
      .v5
    ]
)
