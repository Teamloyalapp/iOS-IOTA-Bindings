import Foundation

public struct BurnNft: AccountMethod, Codable {
    let nftId: NftId
    let transactionOptions: TransactionOptions
}
