import Foundation

public struct ExpirationUnlockCondition: UnlockCondition {
    public var type: Int = 3
    let returnAddress: AddressWrapper
    let unixTime: Int
}
