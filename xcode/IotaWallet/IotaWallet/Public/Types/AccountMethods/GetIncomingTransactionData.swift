import Foundation

public struct GetIncomingTransactionData: AccountMethod, Codable {
    let transactionId: String
}
