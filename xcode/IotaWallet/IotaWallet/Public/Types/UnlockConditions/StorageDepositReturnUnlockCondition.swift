import Foundation

public struct StorageDepositReturnUnlockCondition: UnlockCondition {
    public var type: Int = 1
    var returnAddress: AddressWrapper
    var amount: String
}
