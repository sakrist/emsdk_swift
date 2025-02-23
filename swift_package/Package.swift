// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

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

guard let EMSDK = Context.environment["EMSDK"] else {
    fatalError("EMSDK environment variable not set")
}


let linkerSettings: [LinkerSetting] = [
    .unsafeFlags([
        "-L\(EMSDK)/upstream/emscripten/cache/sysroot/lib/wasm32-emscripten",
        "\(EMSDK)/upstream/emscripten/cache/sysroot/lib/wasm32-emscripten/crt1_reactor.o",
        "-lc",
        "-Xlinker", "-lc",
        "-Xlinker", "-ldlmalloc",
        "-Xlinker", "-lcompiler_rt",
        "-Xlinker", "-lstubs",
        "-Xlinker", "-lal",
        "-Xlinker", "-lc++",
        "-Xlinker", "-lc++abi",
        "-Xlinker", "-lembind",
        "-Xlinker", "-lhtml5",
        "-Xlinker", "-lnoexit",

        // export
        "-Xlinker", "--export-if-defined=main",
        "-Xlinker", "--export-if-defined=fflush",
        "-Xlinker", "--export=__funcs_on_exit",
        "-Xlinker", "--export=strerror",
        "-Xlinker", "--export=emscripten_stack_init",
        "-Xlinker", "--export=emscripten_stack_get_current",
        "-Xlinker", "--export-if-defined=__main_argc_argv",
        "-Xlinker", "--export-table",
        "-Xlinker", "--max-memory=2147483648",
    // "-Xlinker", "--initial-heap=16777216",

        // "-Xlinker", "--allow-undefined",
        "-Xclang-linker", "-nostdlib",
        "-Xlinker", "--no-entry",
        "-Xlinker", "--export-all"
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
