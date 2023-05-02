import Foundation

/// Build a FoundryOutput.
public struct BuildFoundryOutput: AccountMethod, Codable {
    
    // If not provided, minimum storage deposit will be used
    let amount: String
    let nativeTokens: [NativeToken]
    let serialNumber: Int
    let tokenScheme: TokenScheme
    let unlockConditions: [UnlockCondition]
    let features: [Feature]
    let immutableFeatures: [Feature]
    
}
