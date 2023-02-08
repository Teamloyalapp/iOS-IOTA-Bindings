//
//  Payload.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

protocol Payload: Codable {
    var type: Int? { get set }
}
