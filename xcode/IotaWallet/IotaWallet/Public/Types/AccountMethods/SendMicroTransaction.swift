import Foundation

public struct SendMicroTransaction: AccountMethod, Codable {
    let addressesWithMicroAmount: [AddressWithMicroAmount]
    let options: TransactionOptions?
}
