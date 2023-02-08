//
//  RegularTransactionEssence.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

struct RegularTransactionEssence: TransactionEssence {
    var type: Int?
    var networkId: String?
    var inputs: [TransactionInput]?
    var inputsCommitment: String?
    var outputs: [TransactionOutput]?
    var payload: TaggedDataPayload?
}
