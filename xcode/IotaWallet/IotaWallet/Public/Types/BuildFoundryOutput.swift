import Foundation

/// Build a FoundryOutput.
public struct BuildFoundryOutput: AccountMethod, Codable {
    
    // If not provided, minimum storage deposit will be used
    var amount: String?
    var nativeTokens: [NativeToken]?
    let serialNumber: Int
    let tokenScheme: TokenScheme
    var unlockConditions: [UnlockConditionWrapper]
    var features: [Feature]?
    var immutableFeatures: [Feature]?
    
}
