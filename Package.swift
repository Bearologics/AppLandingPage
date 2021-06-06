// swift-tools-version:5.4

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
        .executableTarget(
            name: "AppLandingPage",
            dependencies: ["Publish"]
        )
    ]
)
