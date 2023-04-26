import Foundation

public struct PrepareSendAmount: AccountMethod, Codable {
    let addressesWithAmount: [AddressWithAmount]
    let options: TransactionOptions
}
