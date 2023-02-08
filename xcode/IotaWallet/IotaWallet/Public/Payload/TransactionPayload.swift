//
//  TransactionPayload.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

// MARK: - TransactionPayload
public struct TransactionPayload: Payload {
    var type: Int?
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
