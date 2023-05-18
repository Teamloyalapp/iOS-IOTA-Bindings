import Foundation

public struct BasicOutput: Output {
    public var type: Int = 3
    // Amount of IOTA tokens held by the output.
    let amount: String?
    // Native tokens held by the output.
    let nativeTokens: [NativeToken]?
    // Native tokens held by the output.
    let unlockConditions: [UnlockConditionWrapper]?
    let features: [Feature]?
}
