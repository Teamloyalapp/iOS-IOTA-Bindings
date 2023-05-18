import Foundation

public struct StateControllerAddressUnlockCondition: UnlockCondition {
    public var type: Int = 4
    let address: AddressWrapper
}
