import Foundation

public struct Response<Element> where Element: ItemRepresentable {
    var items: [Element]

    public init(items: [Element] = []) {
        self.items = items
    }

    public mutating func append(item: Element) {
        items.append(item)
    }

    public mutating func append(contentsOf items: [Element]) {
        self.items.append(contentsOf: items)
    }

    public func output() throws -> String {
        let json = try Self.encoder().encode(self)
        return String(data: json, encoding: .utf8)!
    }

    static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }
}

extension Response: Encodable {
    private enum CodingKeys: String, CodingKey {
        case items
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items.map(\.item), forKey: .items)
    }
}
