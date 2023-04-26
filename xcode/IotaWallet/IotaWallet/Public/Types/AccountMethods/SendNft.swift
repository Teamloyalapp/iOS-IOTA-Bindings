import Foundation

public struct SendNft: AccountMethod, Codable {
    let addressesAndNftIds: [AddressAndNftId]
    let options: TransactionOptions?
}
