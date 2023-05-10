import Foundation

public struct BuildNftOutput: AccountMethod, Codable {
    // If not provided, minimum storage deposit will be used
    var amount: String?
    var nativeTokens: [NativeToken]?
    var nftId: String
    var unlockConditions: [UnlockCondition]?
    var features: [Feature]?
    var immutableFeatures: [Feature]?
}
