import PackageDescription

let package = Package(
    name: "SimpleNet",
    targets: [
        Target(name: "LoggerAPI", dependencies: []),
        Target(name: "Threading", dependencies: []),
        Target(name: "SimpleNet", dependencies: ["Threading", "LoggerAPI"])
    ],
    dependencies: [
        .Package(url: "https://github.com/baberthal/RingBuffer.git", majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", majorVersion: 0, minor: 11)
    ],
    exclude: ["Makefile", "docs/*", "README.md"]
)
