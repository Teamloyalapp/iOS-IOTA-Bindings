//
//  TransactionEssence.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

/// Transaction essence protocol
protocol TransactionEssence: Codable {
    var type: Int? { get set }
}
