//
//  Input.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

/// Transaction Input
struct TransactionInput: Codable {
    /// Transaction type
    var type: Int?
    var transactionId: String?
    var transactionOutputIndex: Int?
}
