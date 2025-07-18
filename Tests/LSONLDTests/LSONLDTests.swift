import Foundation
import Testing
import JSONLD

struct JSONLDTests {
	@Test func keywordMapDecode() async throws {
		let content = """
{"@id": "hello", "@type": "sometype"}
"""

		let data = try JSONEncoder().encode([Keyword.id: "hello", Keyword.type: "sometype"])
		print(String(decoding: data, as: UTF8.self))

		
		let value = try JSONDecoder().decode(ExpandedTermDefinition.self, from: Data(content.utf8))


		#expect(value == [.id: "hello", .type: "sometype"])

	}

	@Test func contextWithIRI() async throws {
		let content = """
{"@context":"https://www.w3.org/ns/activitystreams"}
"""

		let document = try JSONDecoder().decode(ContextOnlyDocument.self, from: Data(content.utf8))

		let expected = ContextOnlyDocument(
			context: "https://www.w3.org/ns/activitystreams"
		)

		#expect(document == expected)
	}

	@Test func contextWithListOfIRI() async throws {
		let content = """
{"@context":["https://www.w3.org/ns/activitystreams","https://w3id.org/security/v1"]}
"""

		let document = try JSONDecoder().decode(ContextOnlyDocument.self, from: Data(content.utf8))

		let expected = ContextOnlyDocument(
			context: [
				"https://www.w3.org/ns/activitystreams",
				.simple("https://w3id.org/security/v1"),
			]
		)

		#expect(document == expected)
	}

	@Test func contextWithListOfExpandedObject() async throws {
		let content = """
{"@context":[{"manuallyApprovesFollowers":"as:manuallyApprovesFollowers"}]}
"""

		let document = try JSONDecoder().decode(ContextOnlyDocument.self, from: Data(content.utf8))

		let expected = ContextOnlyDocument(
			context: [
				.map(["manuallyApprovesFollowers": .simple("as:manuallyApprovesFollowers")])
			]
		)

		#expect(document == expected)
	}

	@Test func contextWithListOfExpandedObjectKeywords() async throws {
		let content = """
{"@context":[{"manuallyApprovesFollowers":{"@id": "hello", "@type": "sometype"}}]}
"""

		let document = try JSONDecoder().decode(ContextOnlyDocument.self, from: Data(content.utf8))

		let expected = ContextOnlyDocument(
			context: [
				.map(["manuallyApprovesFollowers": .expanded([.id: "hello", .type: "sometype"])])
			]
		)

		#expect(document == expected)
	}

	@Test func mastodonUser() async throws {
		let content = """
{
	"@context": [
		"https://www.w3.org/ns/activitystreams",
		"https://w3id.org/security/v1",
		{
			"manuallyApprovesFollowers":"as:manuallyApprovesFollowers",
			"toot":"http://joinmastodon.org/ns#",
			"featured":{
				"@id":"toot:featured",
				"@type":"@id"
			},
			"featuredTags":{
				"@id":"toot:featuredTags",
				"@type":"@id"
			},
			"alsoKnownAs":{
				"@id":"as:alsoKnownAs",
				"@type":"@id"
			},
			"movedTo":{
				"@id":"as:movedTo",
				"@type":"@id"
			},
			"schema":"http://schema.org#",
			"PropertyValue":"schema:PropertyValue",
			"value":"schema:value",
			"discoverable":"toot:discoverable",
			"suspended":"toot:suspended",
			"memorial":"toot:memorial",
			"indexable":"toot:indexable",
			"attributionDomains":{
				"@id":"toot:attributionDomains",
				"@type":"@id"
			},
			"focalPoint":{
				"@container":"@list",
				"@id":"toot:focalPoint"
			}
		}
	]
}
"""
		let document = try JSONDecoder().decode(ContextOnlyDocument.self, from: Data(content.utf8))

		let expected = ContextOnlyDocument(
			context: [
				.simple("https://www.w3.org/ns/activitystreams"),
				.simple("https://w3id.org/security/v1"),
				[
					"manuallyApprovesFollowers": "as:manuallyApprovesFollowers",
					"toot": "http://joinmastodon.org/ns#",
					"featured": [.id: "toot:featured", .type: "@id"],
					"featuredTags": [.id: "toot:featuredTags", .type: "@id"],
					"alsoKnownAs": [.id: "as:alsoKnownAs", .type: "@id"],
					"movedTo": [.id: "as:movedTo", .type: "@id"],
					"schema": "http://schema.org#",
					"PropertyValue": "schema:PropertyValue",
					"value": "schema:value",
					"discoverable": "toot:discoverable",
					"suspended": "toot:suspended",
					"memorial": "toot:memorial",
					"indexable": "toot:indexable",
					"attributionDomains": [.id: "toot:attributionDomains", .type: "@id"],
					"focalPoint": [.container: "@list", .id: "toot:focalPoint"],
				]
			]
		)

		#expect(document == expected)
	}

	@Test func encodeContext() throws {
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
		let decoded = try JSONDecoder().decode(ContextOnlyDocument.self, from: data)

		#expect(document == decoded)
	}
}
