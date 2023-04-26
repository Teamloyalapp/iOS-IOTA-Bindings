import Foundation

public struct PreparedTransactionData: AccountMethod, Codable {
    var essence: TransactionEssence?
    var inputsData: [InputSigningData]
    var remainderData: RemainderData?
}
