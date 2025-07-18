/// Internationalized Resource Identifier
public typealias IRI = String

public enum ContextDefinition: Hashable, Sendable {
	case simple(ContextDefinitionEntry)
	case list([ContextDefinitionEntry])
}

extension ContextDefinition: Decodable {
	public init(from decoder: Decoder) throws {
		let single = try? decoder.singleValueContainer()

		if let value = try? single?.decode(ContextDefinitionEntry.self) {
			self = .simple(value)
			return
		}

		if let value = try? single?.decode([ContextDefinitionEntry].self) {
			self = .list(value)
			return
		}

		throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "failed to decode JSON object"))
	}
}

extension ContextDefinition: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case let .simple(value):
			try container.encode(value)
		case let .list(value):
			try container.encode(value)
		}
	}
}

extension ContextDefinition: ExpressibleByArrayLiteral {
	public init(arrayLiteral elements: ContextDefinitionEntry...) {
		var array = [ContextDefinitionEntry]()

		for element in elements {
			array.append(element)
		}

		self = .list(array)
	}
}

extension ContextDefinition: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self = .simple(.simple(value))
	}
}

public enum ContextDefinitionEntry: Hashable, Sendable {
	case simple(IRI)
	case map([String: TermDefinition])
}

extension ContextDefinitionEntry: Decodable {
	public init(from decoder: Decoder) throws {
		let single = try? decoder.singleValueContainer()

		if let value = try? single?.decode(IRI.self) {
			self = .simple(value)
			return
		}

		if let value = try? single?.decode(([String: TermDefinition]).self) {
			self = .map(value)
			return
		}

		throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "failed to decode JSON object"))
	}
}

extension ContextDefinitionEntry: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case let .simple(value):
			try container.encode(value)
		case let .map(value):
			try container.encode(value)
		}
	}
}

extension ContextDefinitionEntry: CustomStringConvertible {
	public var description: String {
		switch self {
		case let .simple(value):
			value.description
		case let .map(value):
			value.description
		}
	}
}

extension ContextDefinitionEntry: ExpressibleByDictionaryLiteral {
	public init(dictionaryLiteral elements: (String, TermDefinition)...) {
		var hash = [String: TermDefinition]()

		for element in elements {
			hash[element.0] = element.1
		}

		self = .map(hash)
	}
}

extension ContextDefinitionEntry: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self = .simple(value)
	}
}

public enum Keyword: String, Codable, CodingKeyRepresentable, Hashable, Sendable {
	case context = "@context"
	case id = "@id"
	case container = "@container"
	case type = "@type"
}

public typealias ExpandedTermDefinition = [Keyword: String]

public enum TermDefinition: Hashable, Sendable {
	case simple(String)
	case expanded(ExpandedTermDefinition)
}

extension TermDefinition: Decodable {
	public init(from decoder: Decoder) throws {
		let single = try? decoder.singleValueContainer()

		if let value = try? single?.decode(String.self) {
			self = .simple(value)
			return
		}

		if let value = try? single?.decode(ExpandedTermDefinition.self) {
			self = .expanded(value)
			return
		}

		throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "failed to decode JSON object"))
	}
}

extension TermDefinition: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case let .simple(value):
			try container.encode(value)
		case let .expanded(value):
			try container.encode(value)
		}
	}
}

extension TermDefinition: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self = .simple(value)
	}
}

extension TermDefinition: ExpressibleByDictionaryLiteral {
	public init(dictionaryLiteral elements: (Keyword, String)...) {
		var hash = [Keyword: String]()

		for element in elements {
			hash[element.0] = element.1
		}

		self = .expanded(hash)
	}
}

extension TermDefinition: CustomStringConvertible {
	public var description: String {
		switch self {
		case let .simple(value):
			value.description
		case let .expanded(value):
			value.description
		}
	}
}
