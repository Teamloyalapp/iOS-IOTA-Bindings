import Foundation

struct PreparedTransactionData: Codable {
    var essence: TransactionEssence?
    var inputsData: [InputSigningData]
    var remainderData: RemainderData?
}
