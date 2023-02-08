//
//  Input.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

struct TransactionInput: Codable {
    var type: Int?
    var transactionId: String?
    var transactionOutputIndex: Int?
}
