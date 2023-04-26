import Foundation

public struct SendAmount: AccountMethod, Codable {
    let addressesWithAmount: [AddressWithAmount]
    let options: TransactionOptions
}
