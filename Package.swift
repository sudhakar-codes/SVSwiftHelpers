
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SVSwiftHelpers",
    platforms: [
        .iOS(.v14) // Minimum supported platform
    ],
    products: [
        .library(
            name: "SVSwiftHelpers",
            targets: ["SVSwiftHelpers"]
        )
    ],
    dependencies: [
        // Add dependencies here, for example:
        //.package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0"),
    ],
    targets: [
        .target(
            name: "SVSwiftHelpers",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Sources/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,json}") // Include all resources
            ]
        ),
        .testTarget(
            name: "SVSwiftHelpersTests",
            dependencies: ["SVSwiftHelpers"],
            path: "Tests"
        )
    ]
)
