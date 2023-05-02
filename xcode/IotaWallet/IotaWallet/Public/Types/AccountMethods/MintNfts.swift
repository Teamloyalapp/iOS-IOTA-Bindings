import Foundation

public struct MintNfts: AccountMethod, Codable {
    let nftsOptions: [NftOptions]
    let options: TransactionOptions?
}
