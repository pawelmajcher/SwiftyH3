// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "SwiftyH3",
    products: [
        .library(
            name: "SwiftyH3",
            targets: ["SwiftyH3"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pawelmajcher/Ch3.git", from: "4.3.0")
    ],
    targets: [
        .target(
            name: "SwiftyH3",
            dependencies: ["Ch3"]
        ),
        .testTarget(
            name: "SwiftyH3Tests",
            dependencies: ["SwiftyH3"]
        ),
    ]
)
