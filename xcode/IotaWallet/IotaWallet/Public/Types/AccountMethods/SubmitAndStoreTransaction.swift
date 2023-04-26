import Foundation

public struct SubmitAndStoreTransaction: AccountMethod, Codable {
    let signedTransactionData: SignedTransactionData
}
