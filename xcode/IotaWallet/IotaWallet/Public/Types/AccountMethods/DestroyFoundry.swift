import Foundation

public struct DestroyFoundry: AccountMethod, Codable {
    let foundryId: FoundryId
    let transactionOptions: TransactionOptions
}
