import Foundation

struct TransactionInput: Codable {
    var type: Int?
    var transactionId: String?
    var transactionOutputIndex: Int?
}
