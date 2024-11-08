// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Diagrams3d",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Diagrams3d",
            targets: ["Diagrams3d"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Diagrams3d"),
        .testTarget(
            name: "Diagrams3dTests",
            dependencies: ["Diagrams3d"]
        ),
    ]
)