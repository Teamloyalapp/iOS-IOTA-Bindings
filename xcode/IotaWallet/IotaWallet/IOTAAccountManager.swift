//
//  AccountManager.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

/// The entry point for the IOTA Wallet library.
public class IOTAAccountManager {
    
    fileprivate var storagePath: String
    fileprivate var nodeURL: String
    fileprivate var secretManager: SecretManager
    fileprivate var coinType: Int
    fileprivate(set) var walletManager: WalletEventsManager?
    
    /// Creates a new instance of the `IOTAAccountManager`.
    /// - Parameters:
    ///   - storagePath: The path where the database file will be saved
    ///   - startsAutomatically: Starts automatically if it is set to `true`. Default `true`
    public init(storagePath: String? = nil, secretManager: SecretManager, coinType: CoinType, nodeURL: String, startsAutomatically: Bool = true) {
        self.storagePath = storagePath ?? URL.libraryDirectory.path
        self.secretManager = secretManager
        self.coinType = coinType.rawValue
        self.nodeURL = nodeURL
        if startsAutomatically {
            start()
        }
    }
    
    deinit {
        if walletManager != nil {
            closeConnection()
        }
    }
    
    /// Starts the manager, does nothing if it is already started.
    public func start() {
        if walletManager?.isRunning ?? false { return }
        walletManager = WalletEventsManager(storagePath: storagePath, secretManager: secretManager, coinType: coinType, nodeUrl: nodeURL)
    }
    
    /// Close the connection, stops the polling and release the inner instance
    public func closeConnection() {
        walletManager?.stop()
        walletManager = nil
    }
    
    /// Sets the Stronghold password.
    /// - Parameters:
    ///   - password: The storage password
    ///   - onResult: The result or error
    public func setStrongholdPassword(_ password: String,
                                      onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "SetStrongholdPassword",
                                   cmd: "setStrongholdPassword",
                                   payload: password) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Clear the Stronghold password.
    /// - Parameters:
    ///   - password: The storage password
    ///   - onResult: The result or error
    public func clearStrongholdPassword(onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "ClearStrongholdPassword",
                                   cmd: "clearStrongholdPassword",
                                   payload: nil) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Changes the Stronghold password.
    /// - Parameters:
    ///   - newPassword: The new password
    ///   - onResult: The result or error
    public func changeStrongholdPassword(newPassword: String,
                                         currentPassword: String,
                                         onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "ChangeStrongholdPassword",
                                   cmd: "changeStrongholdPassword",
                                   payload: ["newPassword": newPassword,
                                             "currentPassword": currentPassword]) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Checks if the Stronghold password is available.
    /// - Parameter onResult: The result or error
    public func isStrongholdPasswordAvailable(onResult: ((Result<StrongholdStatus, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "IsStrongholdPasswordAvailable",
                                   cmd: "isStrongholdPasswordAvailable",
                                   payload: nil) { result, error in
            guard let onResult = onResult else { return }
            if let response = WalletResponse<StrongholdStatus>.decode(result)?.payload {
                onResult(.success(response))
            } else if let error = error {
                onResult(.failure(error))
            } else {
                onResult(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Locks Stronghold if needed.
    /// - Parameter onResult: The result or error
    public func lockStronghold(onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "LockStronghold",
                                   cmd: "lockStronghold",
                                   payload: nil) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Sets Stronghold password clear interval.
    /// - Parameters:
    ///   - interval: The interval in seconds
    ///   - onResult: The result or error
    public func setStrongholdPasswordClearInterval(_ interval: Int,
                                                   onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "SetStrongholdPasswordClearInterval",
                                   cmd: "setStrongholdPasswordClearInterval",
                                   payload: interval * 1000) { result, error in
            guard let decodedResult = WalletResponse<Bool>.decode(result) else {
               onResult?(.failure(IOTAResponseError(type: "Generic", payload: .init(type: "Generic", error: result ?? ""))))
               return
           }
            let isError = decodedResult.isError
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Removes the latest account (account with the largest account index).
    /// - Parameter onResult: The result or error
    public func removeLatestAccount(onResult: @escaping (Result<String, Error>) -> Void) {
        walletManager?.sendCommand(id: "RemoveLatestAccount",
                                   cmd: "removeLatestAccount",
                                   payload: nil) { result, error in
            if let response = WalletResponse<String>.decode(result)?.type {
                onResult(.success(response))
            } else if let error = error {
                onResult(.failure(error))
            } else {
                onResult(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Generates a new mnemonic.
    /// - Parameter onResult: The generated mnemonic or error
    public func generateMnemonic(onResult: @escaping (Result<String, Error>) -> Void) {
        walletManager?.sendCommand(id: "GenerateMnemonic",
                                   cmd: "generateMnemonic",
                                   payload: nil) { result, error in
            if let response = WalletResponse<String>.decode(result)?.payload {
                onResult(.success(response))
            } else if let error = error {
                onResult(.failure(error))
            } else {
                onResult(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Stores a mnemonic for the given signer type.
    /// - Parameters:
    ///   - mnemonic: The provided mnemonic
    ///   - onResult: The result or error
    public func storeMnemonic(mnemonic: String,
                              onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "StoreMnemonic",
                                   cmd: "storeMnemonic",
                                   payload: mnemonic) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Checks is the mnemonic is valid. If a mnemonic was generated with `generateMnemonic(onResult:)`, the mnemonic here should match the generated.
    /// - Parameters:
    ///   - mnemonic: The provided mnemonic
    ///   - onResult: The result
    public func verifyMnemonic(mnemonic: String,
                               onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "VerifyMnemonic",
                                   cmd: "verifyMnemonic",
                                   payload: mnemonic) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Find accounts with unspent outputs.
    public func recoverAccounts(accountStartIndex: Int, accountGapLimit: Int, addressGapLimit: Int, syncOptions: SyncOptions?, onResult: ((Result<[Account], Error>) -> Void)? = nil) { 
        let payload: [String : Any?] = [
            "accountStartIndex": accountStartIndex,
            "accountGapLimit": accountGapLimit,
            "addressGapLimit": addressGapLimit,
            "syncOptions": syncOptions
        ]
        walletManager?.sendCommand(id: "RecoverAccounts",
                                   cmd: "recoverAccounts",
                                   payload: payload) { result, error in
            if let status = WalletResponse<[Account]>.decode(result)?.payload {
                onResult?(.success(status))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Updates the client options for all accounts.
    public func setClientOptions(options: ClientConfig, onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "SetClientOptions",
                                   cmd: "setClientOptions",
                                   payload: options.dictionary) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError{
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Get the node info
    public func getNodeInfo(url: String, onResult: ((Result<NodeInfoResponse, Error>) -> Void)? = nil) {
        let payload: [String : Any] = ["url": url]
        walletManager?.sendCommand(id: "GetNodeInfo",
                                   cmd: "getNodeInfo",
                                   payload: payload) { result, error in
            if let data = WalletResponse<NodeInfoResponse>.decode(result)?.payload {
                onResult?(.success(data))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Creates a new account.
    /// - Parameters:
    ///   - alias: The provided alias for the account
    ///   - mnemonic: The provided mnemonic
    ///   - url: The provided node url
    ///   - localPow: The provided local PoW setting
    ///   - onResult: The result
    public func createAccount(alias: String,
                              mnemonic: String? = nil,
                              url: String,
                              localPow: Bool,
                              onResult: ((Result<IOTAAccount, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "CreateAccount",
                                   cmd: "createAccount",
                                   payload: ["alias": alias, "mnemonic": mnemonic as Any, "clientOptions": ["node": ["url": url]], "localPow": localPow]) { result, error in
            if let account = WalletResponse<IOTAAccount>.decode(result)?.payload {
                account.accountManager = self
                onResult?(.success(account))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Gets the account with the given identifier.
    /// - Parameters:
    ///   - alias: The provided account alias
    ///   - onResult: The result
    public func getAccount(alias: String,
                           onResult: ((Result<IOTAAccount, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "GetAccount",
                                   cmd: "getAccount",
                                   payload: alias) { result, error in
            if let account = WalletResponse<IOTAAccount>.decode(result)?.payload {
                account.accountManager = self
                onResult?(.success(account))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Removes the account with the given identifier.
    /// - Parameters:
    ///   - alias: The provided account alias
    ///   - onResult: The result or error
    public func removeAccount(alias: String,
                              onResult: ((Result<String, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "RemoveAccount",
                                   cmd: "removeAccount",
                                   payload: alias) { result, error in
            if let response = WalletResponse<String>.decode(result)?.payload {
                onResult?(.success(response))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Deletes the storage (database and/or Stronghold)
    /// - Parameter onResult: The result or error
    public func deleteStorage(onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        if (try? FileManager.default.contentsOfDirectory(atPath: storagePath).count) == 0 {
            onResult?(.success(true))
            return
        }
        walletManager?.sendCommand(id: "DeleteStorage",
                                   cmd: "deleteStorage",
                                   payload: nil) { result, error in
            if let response = WalletResponse<Bool>.decode(result)?.payload {
                onResult?(.success(response))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Gets all stored accounts.
    /// - Parameter onResult: The list of accounts or error
    public func getAccounts(onResult: ((Result<[IOTAAccount], Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "GetAccounts",
                                   cmd: "getAccounts",
                                   payload: nil) { result, error in
            if let accounts = WalletResponse<[IOTAAccount]>.decode(result)?.payload {
                accounts.forEach({ $0.accountManager = self })
                onResult?(.success(accounts))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Backups the storage to the given destination
    /// - Parameters:
    ///   - destination: The path to the backup file
    ///   - password: The backup Stronghold password
    ///   - onResult: The result or error
    public func backup(destination: String,
                       password: String,
                       onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        guard destination.hasSuffix(".stronghold") else {
            onResult?(.failure(IOTAResponseError(type: "InvalidName", payload: IOTAResponseError.Details(type: "InvalidName", error: "Invalid destination name, expected a .stronghold file output"))))
            return
        }
        walletManager?.sendCommand(id: "Backup",
                                   cmd: "backup",
                                   payload: ["destination": destination, "password": password]) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Imports a database file.
    /// - Parameters:
    ///   - source: The path to the backup file
    ///   - password: The backup Stronghold password
    ///   - onResult: The result or error
    public func restoreBackup(source: String,
                              password: String,
                              onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        guard source.hasSuffix(".stronghold") else {
            onResult?(.failure(IOTAResponseError(type: "InvalidName", payload: IOTAResponseError.Details(type: "InvalidName", error: "Invalid destination name, expected a .stronghold file output"))))
            return
        }
        walletManager?.sendCommand(id: "RestoreBackup",
                                   cmd: "restoreBackup",
                                   payload: ["source": source, "password": password]) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Starts the background polling and MQTT monitoring.
    /// - Parameters:
    ///   - pollingInterval: The polling interval in seconds
    ///   - automaticOutputConsolidation: If outputs should get consolidated automatically
    ///   - onResult: The result or error
    public func startBackgroundSync(pollingInterval: Int,
                                    automaticOutputConsolidation: Bool,
                                    onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "StartBackgroundSync",
                                   cmd: "startBackgroundSync",
                                   payload: [
                                    "pollingInterval": WalletDuration(secs: pollingInterval, nanos: 0).dict,
                                    "automaticOutputConsolidation": automaticOutputConsolidation
                                   ]) { result, error in
                                       let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
                                       if !isError {
                                           onResult?(.success(true))
                                       } else if let error = error {
                                           onResult?(.failure(error))
                                       } else {
                                           onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
                                       }
        }
    }
    
    /// Stops the background polling and MQTT monitoring.
    /// - Parameter onResult: The result or error
    public func stopBackgroundSync(onResult: ((Result<Bool, Error>) -> Void)? = nil) {
        walletManager?.sendCommand(id: "StopBackgroundSync",
                                   cmd: "stopBackgroundSync",
                                   payload: nil) { result, error in
            let isError = WalletResponse<Bool>.decode(result)?.isError ?? true
            if !isError {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
}
