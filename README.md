<div align="center">

[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]
[![Matrix][matrix badge]][matrix]

</div>

# JSON-LD
A JSON-LD library for Swift.

This is an implementation of the [JSON-LD](https://json-ld.org) specification.

## Integration

```swift
dependencies: [
    .package(url: "https://github.com/mattmassicotte/JSONLD", branch: "main")
]
```

## Usage

```swift
import JSONLD

// decode
let document = try JSONDecoder().decode(ContextOnlyDocument.self, from: jsonldData)

print(document.context)

// encode
let document = ContextOnlyDocument(
    context: [
        "https://www.w3.org/ns/activitystreams",
        "https://w3id.org/security/v1",
        [
            "manuallyApprovesFollowers": "as:manuallyApprovesFollowers",
            "alsoKnownAs": [.id: "as:alsoKnownAs", .type: "@id"],
        ],
    ]
)

let data = try JSONEncoder().encode(document)
```

## Contributing and Collaboration

I would love to hear from you! Issues or pull requests work great. Both a [Matrix space][matrix] and [Discord][discord] are available for live help, but I have a strong bias towards answering in the form of documentation. You can also find me on [the web](https://www.massicotte.org).

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/mattmassicotte/LSON-LD/actions
[build status badge]: https://github.com/mattmassicotte/LSON-LD/workflows/CI/badge.svg
[platforms]: https://swiftpackageindex.com/mattmassicotte/LSON-LD
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattmassicotte%2FLSON-LD%2Fbadge%3Ftype%3Dplatforms
[documentation]: https://swiftpackageindex.com/mattmassicotte/LSON-LD/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue
[matrix]: https://matrix.to/#/%23chimehq%3Amatrix.org
[matrix badge]: https://img.shields.io/matrix/chimehq%3Amatrix.org?label=Matrix
[discord]: https://discord.gg/esFpX6sErJ

