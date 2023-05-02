import Foundation

public struct BurnNft: AccountMethod, Codable {
    let nftId: String
    let transactionOptions: TransactionOptions?
}
