import Foundation

public struct TransactionOptions: Codable {
    var remainderValueStrategy: RemainderValueStrategy = .ReuseAddress
    var taggedDataPayload: TaggedDataPayload?
    var customInputs: [String]
    var allowBurning: Bool?
    var note: String?
}

enum RemainderValueStrategy: Codable {
    case ReuseAddress
    case ChangeAddress
    case CustomAddress(content: AccountAddress)
}
