import Foundation

public struct AddressUnlockCondition: UnlockCondition {
    public var type: Int = 0
    let address: AddressWrapper
}
