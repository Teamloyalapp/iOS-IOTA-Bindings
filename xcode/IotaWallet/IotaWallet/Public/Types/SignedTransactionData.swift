import Foundation

struct SignedTransactionData: Codable {
    /// Transaction essence
    var transactionPayload: TransactionPayload
    /// Required address information for signing
    var inputsData: [InputSigningData]
}
