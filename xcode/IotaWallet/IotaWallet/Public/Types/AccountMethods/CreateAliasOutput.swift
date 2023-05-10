import Foundation

public struct CreateAliasOutput: AccountMethod, Codable {
    var aliasOutputOptions: AliasOutputOptions = .init()
    var options: TransactionOptions? = nil
}

public struct AliasOutputOptions: Codable {
    var address: String?
    var immutableMetadata: String?
    var metadata: String?
}
