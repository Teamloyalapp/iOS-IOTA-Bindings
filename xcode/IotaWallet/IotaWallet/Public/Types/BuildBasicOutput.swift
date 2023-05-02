import Foundation

// Build an BasicOutput.
public struct BuildBasicOutput: AccountMethod, Codable {
    let amount: String
    let nativeTokens: [NativeToken]
    let unlockConditions: [UnlockCondition]
    let features: [Feature]
}
