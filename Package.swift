// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "WeakRef",
    products: [
        .library(name: "WeakRef", targets: ["WeakRef"]),
    ],
    targets: [
        .target(name: "WeakRef", dependencies: []),
        .testTarget(name: "WeakRefTests", dependencies: ["WeakRef"]),
    ],
    swiftLanguageVersions: [.v5]
)
