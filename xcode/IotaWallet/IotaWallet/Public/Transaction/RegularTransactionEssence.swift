//
//  RegularTransactionEssence.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

/// Transaction essence object
struct RegularTransactionEssence: TransactionEssence {
    /// Type
    var type: Int?
    /// Transaction network id
    var networkId: String?
    /// Transaction inputs
    var inputs: [TransactionInput]?
    /// Input commitments
    var inputsCommitment: String?
    /// Transaction ouputs
    var outputs: [TransactionOutput]?
    /// Tagged payload with data
    var payload: TaggedDataPayload?
}
