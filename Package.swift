// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyH3",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftyH3",
            targets: ["SwiftyH3"]),
    ],
    // dependencies: [
    //     .package(url: "https://github.com/pawelmajcher/Ch3.git", from: "4.0.0")
    // ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftyH3"),
        .testTarget(
            name: "SwiftyH3Tests",
            dependencies: ["SwiftyH3"]
        ),
    ]
)
