import Foundation

// Build an AliasOutput.
public struct BuildAliasOutput: Codable {
    var amount: String?
    var nativeTokens: [NativeToken]?
    var aliasId: String?
    var stateIndex: Int?
    var stateMetadata: [UnsignedByte]?
    var foundryCounter: Int?
    var unlockConditions: [UnlockCondition]
    var features: [Feature]?
    var immutableFeatures: [Feature]?
  
}

public struct UnsignedByte: Codable {}
