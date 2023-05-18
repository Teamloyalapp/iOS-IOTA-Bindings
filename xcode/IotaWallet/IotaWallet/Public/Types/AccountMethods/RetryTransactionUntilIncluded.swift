import Foundation

public struct RetryTransactionUntilIncluded: AccountMethod, Codable {
    let transactionId: String
    var interval: Int?
    var maxAttempts: Int?
}
