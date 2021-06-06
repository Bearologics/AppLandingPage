// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "AppLandingPage",
    products: [
        .executable(name: "AppLandingPage", targets: ["AppLandingPage"])
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "AppLandingPage",
            dependencies: ["Publish"]
        )
    ]
)
