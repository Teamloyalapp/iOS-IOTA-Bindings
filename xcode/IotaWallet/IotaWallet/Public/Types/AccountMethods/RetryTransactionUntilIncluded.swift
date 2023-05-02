import Foundation

public struct RetryTransactionUntilIncluded: AccountMethod, Codable {
    let transactionId: String
    let interval: Int
    let maxAttempts: Int
}
