import Foundation

public struct FoundryOutput: Output {
    public var type: Int = 5
    // Amount of IOTA tokens held by the output.
    var amount: String
    // Native tokens held by the output.
    var nativeTokens: [NativeToken]?
    // The serial number of the foundry with respect to the controlling alias.
    var serialNumber: Int
    var tokenScheme: TokenScheme
    var unlockConditions: [UnlockConditionWrapper]?
    var features: [Feature]?
    var immutableFeatures: [Feature]?
}
