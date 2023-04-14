import Foundation

class NftOutput: Output {
    // Amount of IOTA tokens held by the output.
    var amount: String?
    // Native tokens held by the output.
    var nativeTokens: [NativeToken] = []
    // Unique identifier of the NFT.
    var nftId: NftId?
    var unlockConditions: [UnlockCondition] = []
    var features: [Feature] = []
    var immutableFeatures: [Feature] = []
}
