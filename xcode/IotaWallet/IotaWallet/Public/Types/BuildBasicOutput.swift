import Foundation

// Build an BasicOutput.
public struct BuildBasicOutput: AccountMethod, Codable {
    var amount: String?
    var nativeTokens: [NativeToken]?
    var unlockConditions: [UnlockCondition]?
    var features: [Feature]?
}
