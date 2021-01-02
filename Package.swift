// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GKPageScrollView",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GKPageScrollView",
            targets: ["GKPageScrollView"]
        ),
        .library(
            name: "GKPageScrollViewSwift",
            targets: ["GKPageScrollViewSwift"]
        ),
        .library(
            name: "GKPageSmoothView",
            targets: ["GKPageSmoothView"]
        ),
        .library(
            name: "GKPageSmoothViewSwift",
            targets: ["GKPageSmoothViewSwift"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GKPageScrollView",
            dependencies: [],
            path: "Sources",
            sources: ["GKPageScrollView"]
        ),
        .target(
            name: "GKPageScrollViewSwift",
            dependencies: [],
            path: "Sources",
            sources: ["GKPageScrollViewSwift"]
        ),
        .target(
            name: "GKPageSmoothView",
            dependencies: [],
            path: "Sources",
            sources: ["GKPageSmoothView"]
        ),
        .target(
            name: "GKPageSmoothViewSwift",
            dependencies: [],
            path: "Sources",
            sources: ["GKPageSmoothViewSwift"]
        )
    ]
)
