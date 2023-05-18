//
//  PrivateModels.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

typealias IotaCallback = (String) -> Void

struct IOTAError: Error {
    let message: String
}

struct WalletResponse<T: Decodable>: Decodable {
    let type: String
    let payload: T?
    var isError: Bool { type == "error" }
    var isOk: Bool { type == "ok" }
}

struct WalletGenericResponse: Decodable {
    let type: String
    var isError: Bool { type == "error" }
}

struct WalletSyncResponse: Decodable {
    var publicAddresses: [IOTAAccount.Address]
}

struct WalletDuration: Codable {
    let secs: Int
    let nanos: Int
    var dict: [String: Int] { ["secs": secs, "nanos": nanos] }
}
