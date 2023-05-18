import Foundation

// MARK: - UnlockCondition
public protocol UnlockCondition: Codable {
    var type: Int { get }
}

public enum UnlockConditionWrapper: Codable {
    
    fileprivate enum Keys: String, CodingKey {
        case type
    }
    
    case address(AddressUnlockCondition)
    case storageDepositReturn(StorageDepositReturnUnlockCondition)
    case timelock(TimelockUnlockCondition)
    case expiration(ExpirationUnlockCondition)
    case stateControllerAddress(StateControllerAddressUnlockCondition)
    case governorAddress(GovernorAddressUnlockCondition)
    case immutableAliasAddress(ImmutableAliasAddressUnlockCondition)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let itemType = try container.decode(Int.self, forKey: Keys.type)
        switch itemType {
        case 0: self = .address(try AddressUnlockCondition(from: decoder))
        case 1: self = .storageDepositReturn(try StorageDepositReturnUnlockCondition(from: decoder))
        case 2: self = .timelock(try TimelockUnlockCondition(from: decoder))
        case 3: self = .expiration(try ExpirationUnlockCondition(from: decoder))
        case 4: self = .stateControllerAddress(try StateControllerAddressUnlockCondition(from: decoder))
        case 5: self = .governorAddress(try GovernorAddressUnlockCondition(from: decoder))
        case 6: self = .immutableAliasAddress(try ImmutableAliasAddressUnlockCondition(from: decoder))
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
        case .address(let value):
            try container.encode(value)
        case .storageDepositReturn(let value):
            try container.encode(value)
        case .timelock(let value):
            try container.encode(value)
        case .expiration(let value):
            try container.encode(value)
        case .stateControllerAddress(let value):
            try container.encode(value)
        case .governorAddress(let value):
            try container.encode(value)
        case .immutableAliasAddress(let value):
            try container.encode(value)
        }
    }
}
