import Foundation

public struct GovernorAddressUnlockCondition: UnlockCondition {
    public var type: Int = 5
    let address: AddressWrapper
}
