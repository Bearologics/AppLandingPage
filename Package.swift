// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "AppLandingPage",
    products: [
        .executable(name: "AppLandingPage", targets: ["AppLandingPage"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "AppLandingPage",
            dependencies: ["Publish"]
        )
    ]
)
