//
//  Output.swift
//  IotaWallet
//
//  Created by Andrii Moso on 09.01.2023.
//

import Foundation

struct TransactionOutput: Codable {
    var type: Int?
    var amount: String?
    var nftId: String?
    var unlockConditions: [UnlockCondition]?
    var immutableFeatures: [ImmutableFeature]?
}

// MARK: - ImmutableFeature
struct ImmutableFeature: Codable {
    let type: Int?
    let address: Address?
    let data: String?
}

// MARK: - UnlockCondition
struct UnlockCondition: Codable {
    let type: Int?
    let address: Address?
}

// MARK: - Address
struct Address: Codable {
    let type: Int?
    let pubKeyHash: String?
}
