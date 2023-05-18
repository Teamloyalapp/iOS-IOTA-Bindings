import Foundation

public struct PreparedTransactionData: AccountMethod, Codable {
    var essence: RegularTransactionEssence?
    var inputsData: [InputSigningData]
    var remainderData: RemainderData?
}
