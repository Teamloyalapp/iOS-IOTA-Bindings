import Foundation

struct NftOptions: Codable {
    /// Bech32 encoded address to which the Nft will be minted. Default will use the first address of the account
    var address: String?
    /// Immutable nft metadata, hex encoded bytes
    var immutableMetadata: String?
    /// Nft metadata, hex encoded bytes
    var metadata: String?
}
