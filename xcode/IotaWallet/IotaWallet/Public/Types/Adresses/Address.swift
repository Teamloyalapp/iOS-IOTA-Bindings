import Foundation

// MARK: - Address
public protocol Address: Codable {
    var type: Int { get set }
}

public enum AddressWrapper: Codable {
    
    fileprivate enum Keys: String, CodingKey {
        case type
    }
    
    case ed25519(Ed25519Address)
    case alias(AliasAddress)
    case nft(NftAddress)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let itemType = try container.decode(Int.self, forKey: Keys.type)
        switch itemType {
        case 0: self = .ed25519(try Ed25519Address(from: decoder))
        case 8: self = .alias(try AliasAddress(from: decoder))
        case 16: self = .nft(try NftAddress(from: decoder))
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
        case .ed25519(let value):
            try container.encode(value)
        case .alias(let value):
            try container.encode(value)
        case .nft(let value):
            try container.encode(value)
        }
    }
}
