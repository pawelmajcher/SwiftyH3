// swift-tools-version: 6.2

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
            name: "Ch3",
             cSettings: [
                 // M_PI and M_PI_2 are defined ambiguously in v4.4.1 of H3
                 .disableWarning("ambiguous-macro")
             ]
        ),
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
