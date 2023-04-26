import Foundation

public struct RetryTransactionUntilIncluded: AccountMethod, Codable {
    let transactionId: TransactionId
    let interval: Int
    let maxAttempts: Int
}
