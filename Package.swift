// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "UIImage-PDF",
    products: [
        .library(
            name: "UIImage-PDF",
            targets: ["UIImage-PDF"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UIImage-PDF",
            dependencies: []
        ),
        .testTarget(
            name: "UIImage-PDFTests",
            dependencies: ["UIImage-PDF"],
            resources: [.copy("YinYang.pdf")]
        ),
    ]
)
