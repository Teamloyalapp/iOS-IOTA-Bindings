import Foundation

public struct Transaction: Codable {
    /// The transaction payload
    var payload: TransactionPayload?
    /// BlockId when it got sent to the Tangle
    var blockId: String?
    /// Inclusion state of the transaction
    var inclusionState: InclusionState?
    /// Timestamp
    var timestamp: String?
    /// Transaction ID
    var transactionId: String?
    /// Network id to ignore outputs when set_client_options is used to switch to another network
    var networkId: String?
    /// If the transaction was created by the wallet or if it was sent by someone else and is incoming
    var incoming: Bool?
    /// Note.
    var note: String?

    public enum InclusionState: String, Codable {
        case Pending = "Pending"
        case Confirmed = "Confirmed"
        case Conflicting = "Conflicting"
        case UnknownPruned = "UnknownPruned"
    }
}
