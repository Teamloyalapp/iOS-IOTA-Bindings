import Foundation

public struct RegularTransactionEssence: Codable {
    var type: Int?
    var networkId: String?
    var inputs: [TransactionInput]?
    var inputsCommitment: String?
    var outputs: [TransactionOutput]?
    var payload: TaggedDataPayload?
}
