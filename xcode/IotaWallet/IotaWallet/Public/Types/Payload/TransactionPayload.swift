import Foundation

// MARK: - TransactionPayload
class TransactionPayload: Payload {
    var essence: RegularTransactionEssence?
    var unlocks: [Unlock]?
}

// MARK: - Unlock
struct Unlock: Codable {
    let type: Int?
    let signature: Signature?
}

// MARK: - Signature
struct Signature: Codable {
    let type: Int?
    let publicKey, signature: String?
}
