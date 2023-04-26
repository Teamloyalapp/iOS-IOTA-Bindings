import Foundation

public struct GetIncomingTransactionData: AccountMethod, Codable {
    private let transactionId: TransactionId
}
