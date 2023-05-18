import Foundation

public protocol Output: Codable {
    var type: Int { get }
}

public enum OutputWrapper: Codable {
    
    fileprivate enum Keys: String, CodingKey {
        case type
    }
    
    case treasury(TreasuryOutput)
    case basic(BasicOutput)
    case alias(AliasOutput)
    case foundry(FoundryOutput)
    case nft(NftOutput)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let itemType = try container.decode(Int.self, forKey: Keys.type)
        switch itemType {
        case 2:  self = .treasury(try TreasuryOutput(from: decoder))
        case 3:  self = .basic(try BasicOutput(from: decoder))
        case 4:  self = .alias(try AliasOutput(from: decoder))
        case 5:  self = .foundry(try FoundryOutput(from: decoder))
        case 6:  self = .nft(try NftOutput(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(
                forKey: .type,
                in: container,
                debugDescription: "Unhandled type: \(itemType)"
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .treasury(let value):
            try container.encode(value)
        case .basic(let value):
            try container.encode(value)
        case .alias(let value):
            try container.encode(value)
        case .foundry(let value):
            try container.encode(value)
        case .nft(let value):
            try container.encode(value)
        }
    }
}
