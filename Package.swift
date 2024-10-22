// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorKeyboardLanguage",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorKeyboardLanguage",
            targets: ["KeyboardLanguagePlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "KeyboardLanguagePlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/KeyboardLanguagePlugin"),
        .testTarget(
            name: "KeyboardLanguagePluginTests",
            dependencies: ["KeyboardLanguagePlugin"],
            path: "ios/Tests/KeyboardLanguagePluginTests")
    ]
)
