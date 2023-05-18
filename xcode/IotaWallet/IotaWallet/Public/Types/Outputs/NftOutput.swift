import Foundation

public struct NftOutput: Output {
    public var type: Int = 6
    // Amount of IOTA tokens held by the output.
    var amount: String
    // Native tokens held by the output.
    var nativeTokens: [NativeToken]?
    // Unique identifier of the NFT.
    var nftId: String
    var unlockConditions: [UnlockConditionWrapper]?
    var features: [Feature]?
    var immutableFeatures: [Feature]?
}
