// swift-tools-version: 6.1

import PackageDescription

let package = Package(
	name: "LSONLD",
	products: [
		.library(
			name: "LSONLD",
			targets: ["LSONLD"]),
	],
	targets: [
		.target(
			name: "LSONLD"),
		.testTarget(
			name: "LSONLDTests",
			dependencies: ["LSONLD"]
		),
	]
)
