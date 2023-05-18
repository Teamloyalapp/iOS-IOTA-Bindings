import Foundation

public struct MintNfts: AccountMethod, Codable {
    let nftsOptions: [NftOptions]
    var options: TransactionOptions?
}
