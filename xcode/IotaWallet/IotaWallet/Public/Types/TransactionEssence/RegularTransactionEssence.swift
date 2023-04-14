import Foundation

class RegularTransactionEssence: TransactionEssence {
    var networkId: String?
    var inputs: [TransactionInput]?
    var inputsCommitment: String?
    var outputs: [TransactionOutput]?
    var payload: TaggedDataPayload?
}
