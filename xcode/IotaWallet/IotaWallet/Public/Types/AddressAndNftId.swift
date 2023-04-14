import Foundation

class AddressAndNftId: Codable {
    /// Bech32 encoded address
    var address: String?
    /// Nft id
    var nftId: NftId?
    
    init(address: String? = nil, nftId: NftId? = nil) {
        self.address = address
        self.nftId = nftId
    }
}
