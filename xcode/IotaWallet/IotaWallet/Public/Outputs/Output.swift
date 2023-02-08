//
//  Output.swift
//  IotaWallet
//
//  Created by Andrii Moso on 09.01.2023.
//

import Foundation

/// Transaction output
struct TransactionOutput: Codable {
    /// Transaction type
    var type: Int?
    /// Amount of IOTA tokens held by the output.
    var amount: String?
    /// Unique identifier of the NFT.
    var nftId: String?
    /// Unlock conditions
    var unlockConditions: [UnlockCondition]?
    /// Immutable features
    var immutableFeatures: [ImmutableFeature]?
}

// MARK: - Immutable Features
struct ImmutableFeature: Codable {
    let type: Int?
    /// Defined address
    let address: Address?
    /// immutable features for address
    let data: String?
}

// MARK: - Unlock Conditions object
struct UnlockCondition: Codable {
    /// Type
    let type: Int?
    /// Unlock by given address
    let address: Address?
}

// MARK: - Address
struct Address: Codable {
    /// Type
    let type: Int?
    /// Public key hash
    let pubKeyHash: String?
}
