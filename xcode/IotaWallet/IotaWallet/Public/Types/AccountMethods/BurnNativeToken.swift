import Foundation

public struct BurnNativeToken: AccountMethod, Codable {
    var tokenId: String
    var burnAmount: String
    var transactionOptions: TransactionOptions?
}
