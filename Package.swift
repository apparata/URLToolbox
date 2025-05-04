// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "URLToolbox",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15), .visionOS(.v1)
    ],
    products: [
        .library(name: "URLToolbox", targets: ["URLToolbox"])
    ],
    targets: [
        .target(
            name: "URLToolbox",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ]),
        .testTarget(name: "URLToolboxTests", dependencies: ["URLToolbox"]),
    ]
)
