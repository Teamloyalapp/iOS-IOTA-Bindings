import Foundation

public struct BurnNativeToken: AccountMethod, Codable {
    var tokenId: TokenId
    var burnAmount: String
    var transactionOptions: TransactionOptions
}
