import Foundation

public struct Transaction: Codable {
    /// The transaction payload
    var payload: TransactionPayload
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
    
    public init(from decoder: Decoder) throws {
        enum CodingKeys: String, CodingKey {
            case payload
            case transactionPayload
            case blockId
            case inclusionState
            case timestamp
            case transactionId
            case networkId
            case incoming
            case note
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let payload = try? container.decode(TransactionPayload.self, forKey: .payload) {
            self.payload = payload
        } else if let payload = try? container.decode(TransactionPayload.self, forKey: .transactionPayload) {
            self.payload = payload
        } else {
            throw DecodingError.keyNotFound(
                CodingKeys.payload,
                DecodingError.Context(
                    codingPath: [CodingKeys.payload, CodingKeys.transactionPayload],
                    debugDescription: "Cannot find key 'payload' or 'transactionPayload'"
                )
            )
        }
        
        blockId = try? container.decode(String.self, forKey: .blockId)
        inclusionState = try? container.decode(InclusionState.self, forKey: .inclusionState)
        timestamp = try? container.decode(String.self, forKey: .timestamp)
        transactionId = try? container.decode(String.self, forKey: .transactionId)
        networkId = try? container.decode(String.self, forKey: .networkId)
        incoming = try? container.decode(Bool.self, forKey: .incoming)
        note = try? container.decode(String.self, forKey: .note)
    }
}
