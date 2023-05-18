import Foundation

public struct ImmutableAliasAddressUnlockCondition: UnlockCondition {
    public var type: Int = 6
    let address: AddressWrapper
}
