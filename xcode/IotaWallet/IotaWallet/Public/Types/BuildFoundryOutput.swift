import Foundation

/// Build a FoundryOutput.
public struct BuildFoundryOutput: AccountMethod, Codable {
    
    // If not provided, minimum storage deposit will be used
    var amount: String?
    var nativeTokens: [NativeToken]?
    var serialNumber: Int?
    var tokenScheme: TokenScheme?
    var unlockConditions: [UnlockCondition]?
    var features: [Feature]?
    var immutableFeatures: [Feature]?
    
}
