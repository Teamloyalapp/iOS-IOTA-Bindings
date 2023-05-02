import Foundation

public struct DestroyAlias: AccountMethod, Codable {
    let aliasId: String
    let transactionOptions: TransactionOptions?
}
