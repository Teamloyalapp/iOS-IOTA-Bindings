//
//  TransactionPayload.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

// MARK: - Transaction payload
public struct TransactionPayload: Payload {
    /// Type
    var type: Int?
    /// 
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
