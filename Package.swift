// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "PermissionSheets",
    platforms: [
        .iOS(.v16),
        .macOS(.v14)
    ],
    products: [
        // Core library with shared protocols and utilities
        .library(
            name: "PermissionSheets",
            targets: ["PermissionSheets"]
        ),
        
        // Individual permission libraries
        .library(
            name: "NotificationPermissionSheet",
            targets: ["NotificationPermissionSheet"]
        ),
        .library(
            name: "LocationPermissionSheet",
            targets: ["LocationPermissionSheet"]
        ),
    ],
    dependencies: [],
    targets: [
        // Core target containing shared code
        .target(
            name: "PermissionSheets",
            dependencies: []
        ),
        
        // Notification permission library
        .target(
            name: "NotificationPermissionSheet",
            dependencies: ["PermissionSheets"]
        ),
        
        // Location permission library
        .target(
            name: "LocationPermissionSheet",
            dependencies: ["PermissionSheets"],
            resources: [
                .process("Media.xcassets")
            ]
        ),

        .testTarget(
            name: "PermissionSheetsTests",
            dependencies: ["PermissionSheets"]
        )
    ]
)
