// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let embeddedSwiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("Embedded"),
    .enableExperimentalFeature("Extern"),
    .interoperabilityMode(.Cxx),
    .unsafeFlags([
        "-wmo", "-disable-cmo",
        "-Xfrontend", "-gnone", "-disable-stack-protector"
    ])
]

let embeddedCSettings: [CSetting] = [
    .unsafeFlags(["-fdeclspec"])
]

let linkerSettings: [LinkerSetting] = [
    .unsafeFlags([
        "-Xclang-linker", "-nostdlib",
        "-Xlinker", "--no-entry"
    ])
]

let package = Package(
    name: "hello",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "hello",
            targets: ["hello"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "hello",
            cSettings: embeddedCSettings,
            swiftSettings: embeddedSwiftSettings,
            linkerSettings: linkerSettings),
        .testTarget(
            name: "helloTests",
            dependencies: ["hello"]
        ),
    ]
)
