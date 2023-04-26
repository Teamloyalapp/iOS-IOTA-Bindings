import Foundation

public struct SignTransactionEssence: AccountMethod, Codable {
    let preparedTransactionData: PreparedTransactionData
}
