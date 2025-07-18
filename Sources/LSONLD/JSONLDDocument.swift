public protocol JSONLDDocument: Codable {
	var context: ContextDefinition { get }
}

public struct ContextOnlyDocument: JSONLDDocument, Hashable, Sendable {
	public enum CodingKeys: String, CodingKey {
		case context = "@context"
	}

	public var context: ContextDefinition

	public init(context: ContextDefinition) {
		self.context = context
	}
}
