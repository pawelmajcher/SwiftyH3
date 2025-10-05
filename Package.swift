// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SwiftyH3",
    products: [
        .library(
            name: "SwiftyH3",
            targets: ["SwiftyH3"]),
    ],
    targets: [
        .target(
            name: "Ch3"
        ),
        .target(
            name: "SwiftyH3",
            dependencies: ["Ch3"]
        ),
        .testTarget(
            name: "SwiftyH3Tests",
            dependencies: ["SwiftyH3"]
        ),
    ],
    swiftLanguageVersions: [.version("6"), .v5]
)
