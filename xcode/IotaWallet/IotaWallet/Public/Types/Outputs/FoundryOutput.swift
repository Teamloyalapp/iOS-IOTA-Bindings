import Foundation

class FoundryOutput: Output {
    // Amount of IOTA tokens held by the output.
    var amount: String?
    // Native tokens held by the output.
    var nativeTokens: [NativeToken] = []
    // The serial number of the foundry with respect to the controlling alias.
    var serialNumber: Int?
    var tokenScheme: TokenScheme?
    var unlockConditions: [UnlockCondition] = []
    var features: [Feature] = []
    var immutableFeatures: [Feature] = []
}
