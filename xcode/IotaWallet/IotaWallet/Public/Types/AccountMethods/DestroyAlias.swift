import Foundation

public struct DestroyAlias: AccountMethod, Codable {
    let aliasId: AliasId
    let transactionOptions: TransactionOptions
}
