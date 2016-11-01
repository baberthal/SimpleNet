import PackageDescription

let package = Package(
    name: "SimpleNet",
    targets: [
        Target(name: "LoggerAPI", dependencies: []),
        Target(name: "SimpleNet", dependencies: ["LoggerAPI"])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/BlueSocket.git",
                 majorVersion: 0, minor: 11)
    ],
    exclude: ["Makefile", "docs/*", "README.md"]
)
