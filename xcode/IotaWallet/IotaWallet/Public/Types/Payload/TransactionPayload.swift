import Foundation

// MARK: - TransactionPayload
public struct TransactionPayload: Codable { //Payload {
    var type: Int
    var essence: RegularTransactionEssence
    var unlocks: [Unlock]?
}

// MARK: - Unlock
public struct Unlock: Codable {
    let type: Int?
    let signature: Signature?
}

// MARK: - Signature
public struct Signature: Codable {
    let type: Int?
    let publicKey, signature: String?
}
