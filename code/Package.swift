// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "PathTracingApp",
    dependencies: [
        // Simple pixel-based image type
        .package(
            url: "https://github.com/koher/swift-image.git",
            from: "0.8.0"
        ),

        // Image encoding/decoding (PNG, JPEG, etc.)
        .package(
            url: "https://github.com/stackotter/swift-image-formats.git",
            from: "0.2.0"
        )
    ],
    targets: [
        .executableTarget(
            name: "PathTracer",
            dependencies: [
                .product(name: "SwiftImage", package: "swift-image"),
                .product(name: "ImageFormats", package: "swift-image-formats")
            ]
        )
    ]
)
