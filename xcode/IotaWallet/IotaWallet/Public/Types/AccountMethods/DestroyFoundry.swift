import Foundation

public struct DestroyFoundry: AccountMethod, Codable {
    let foundryId: String
    let transactionOptions: TransactionOptions?
}
