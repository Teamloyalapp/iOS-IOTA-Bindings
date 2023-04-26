import Foundation

public struct AddressAndNftId: Codable {
    /// Bech32 encoded address
    let address: String
    /// Nft id
    let nftId: String
}
