import Foundation

public struct AliasOutput: Output {
    public var type: Int = 4
    let amount: String
    let nativeTokens: [NativeToken]?
    let aliasId: String
    let stateIndex: Int
    let stateMetadata: String
    let foundriesCounter: Int?
    let unlockConditions: [UnlockConditionWrapper]?
    let features: [Feature]?
    let immutableFeatures: [Feature]?
}
