// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "TournoiDesPiliers",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(name: "TournoiDesPiliers", targets: ["TournoiDesPiliers"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "TournoiDesPiliers",
            path: "",
            sources: ["main.swift", "Models.swift", "TerminalUI.swift", "ConnectFourGame.swift", "GameController.swift"]
        )
    ]
) 