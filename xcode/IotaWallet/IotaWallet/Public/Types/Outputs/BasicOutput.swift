import Foundation

class BasicOutput: Output {
    // Amount of IOTA tokens held by the output.
    var amount: String?
    // Native tokens held by the output.
    var nativeTokens: [NativeToken] = []
    // Native tokens held by the output.
    var unlockConditions: [UnlockCondition] = []
    var features: [Feature] = []
}
