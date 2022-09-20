// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "AppLandingPage",
    products: [
        .executable(name: "AppLandingPage", targets: ["AppLandingPage"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .executableTarget(
            name: "AppLandingPage",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ]
        )
    ]
)
