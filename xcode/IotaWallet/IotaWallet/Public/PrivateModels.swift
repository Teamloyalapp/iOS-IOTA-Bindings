//
//  PrivateModels.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

typealias IotaCallback = (String) -> Void

/// IOTA Error object
struct IOTAError: Error {
    /// Error message
    let message: String
}

/// Wallet Response with typed payload
struct WalletResponse<T: Decodable>: Decodable {
    /// Request result. Contains "Error" for error
    let type: String
    /// Result payload
    let payload: T?
    /// if true request was unsuccessful otherwize false
    var isError: Bool { type == "Error" }
}

/// Wallet response without payload
struct WalletGenericResponse: Decodable {
    /// Request result. Contains "Error" for error
    let type: String
    /// if true request was unsuccessful otherwize false
    var isError: Bool { type == "Error" }
}

/// IOTA Wallet account syncronize response
struct WalletSyncResponse: Decodable {
    /// Public addresses connected with iota account
    var publicAddresses: [IOTAAccount.Address]
}

/// IOTA Wallet operations duration in seconds, nanoseconds
struct WalletDuration: Codable {
    /// Seconds
    let secs: Int
    /// Nanoseconds
    let nanos: Int
    var dict: [String: Int] { ["secs": secs, "nanos": nanos] }
}
