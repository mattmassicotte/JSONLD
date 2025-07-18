// swift-tools-version: 6.1

import PackageDescription

let package = Package(
	name: "JSONLD",
	products: [
		.library(
			name: "JSONLD",
			targets: ["JSONLD"]),
	],
	targets: [
		.target(
			name: "JSONLD"),
		.testTarget(
			name: "JSONLDTests",
			dependencies: ["JSONLD"]
		),
	]
)
