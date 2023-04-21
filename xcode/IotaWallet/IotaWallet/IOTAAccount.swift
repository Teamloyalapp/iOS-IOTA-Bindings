//
//  IOTAAccount.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

extension IOTAAccount {
    /// Synchronizes the account with the Tangle.
    /// - Parameter onResult: The result or error
    public func sync(onResult: ((Result<Bool, Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "SyncAccount",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id, "method": ["name": "syncAccount", "data": [:]]]) { result, error in
            if (WalletResponse<IOTABalance>.decode(result)?.payload) != nil {
                onResult?(.success(true))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Generates a new unused address and returns it.
    /// - Parameter onResult: The address or error
    public func generateAddresses(count: Int, onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        let count = max(1, count)
        accountManager?.walletManager?.sendCommand(id: "GenerateAddresses",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id, "method": ["name": "generateAddresses", "data": ["amount":count]]]) { result, error in
            if let addresses = WalletResponse<[IOTAAccount.Address]>.decode(result)?.payload {
                onResult?(.success(addresses))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Returns the latest address (the one with the biggest keyIndex).
    /// - Parameter onResult: The address or error
    public func latestAddress(onResult: ((Result<IOTAAccount.Address, Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "GetLatestAddress",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id, "method": ["name": "getLatestAddress"]]) { result, error in
            if let address = WalletResponse<IOTAAccount.Address>.decode(result)?.payload {
                onResult?(.success(address))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Returns the account's balance information object.
    /// - Parameter onResult: The balance response or error
    public func balance(onResult: ((Result<BalanceResponse, Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "GetBalance",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id, "method": ["name": "getBalance"]]) { result, error in
            if let balance = WalletResponse<BalanceResponse>.decode(result)?.payload {
                onResult?(.success(balance))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Updates the account alias.
    /// - Parameters:
    ///   - newAlias: The new alias
    ///   - onResult: The result or error
    public func setAlias(_ newAlias: String, onResult: ((Result<Bool, Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "S5etAlias",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id,
                                                             "method": ["name": "setAlias", "data": ["alias": newAlias]]
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
    
    /// Returns the account's addresses.
    /// - Parameter onResult: The addresses or error
    public func addresses(onResult: ((Result<[Address], Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "ListAddresses",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id,
                                                             "method": ["name": "listAddresses"]
                                                            ]) { result, error in
            if let addresses = WalletResponse<[Address]>.decode(result)?.payload {
                onResult?(.success(addresses))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Return the account's unspent addresses
    /// - Parameter onResult: The list of addresses or error
    public func unspentAddresses(onResult: ((Result<[Address], Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "ListAddresses",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id,
                                                             "method": ["name": "ListUnspentAddresses"]
                                                            ]) { result, error in
            if let addresses = WalletResponse<[Address]>.decode(result)?.payload {
                onResult?(.success(addresses))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Returns the account's spent addresses
    /// - Parameter onResult: The list of addresses or error
    public func spentAddresses(onResult: ((Result<[Address], Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "ListAddresses",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id,
                                                             "method": ["name": "listSpentAddresses"]
                                                            ]) { result, error in
            if let addresses = WalletResponse<[Address]>.decode(result)?.payload {
                onResult?(.success(addresses))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    /// Returns the account's unused addresses
    /// - Parameter onResult: The list of addresses or error
    public func unusedAddress(onResult: ((Result<Address, Error>) -> Void)?) {
        accountManager?.walletManager?.sendCommand(id: "ListAddresses",
                                                   cmd: "callAccountMethod",
                                                   payload: ["accountId": id, "method": ["name": "getUnusedAddress"]]) { result, error in
            let isError = WalletResponse<Address>.decode(result)?.isError ?? true
            let payload = WalletResponse<Address>.decode(result)?.payload
            if let payload = payload, !isError {
                onResult?(.success(payload))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
        /*accountManager?.walletManager?.sendCommand(id: "ListAddresses",
                                                   cmd: "CallAccountMethod",
                                                   payload: ["accountId": id,
                                                             "method": ["name": "GetUnusedAddress"]
                                                            ]) { result, error in
            let isError = result.decodedResponse?.isError ?? true
            let payload = WalletResponse<IOTAAccount.Address>.decode(result)?.payload
            if !isError {
                onResult?(.success(payload))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }*/
    }
    
    /// Send funds to the given address.
    /// - Parameters:
    ///   - address: The bech32 string of the transfer address
    ///   - amount: The transfer amount
    ///   - options: The transfer options
    ///   - onResult: The result or error
    public func sendTransfer(address: String, amount: Int, options: TransferOptions? = nil, onResult: ((Result<TransferResponse, Error>) -> Void)?) {
        var currentOptions: TransferOptions? = options
        var transfer: [String: Any] = ["address": address, "amount": amount]
        if currentOptions == nil {
            currentOptions = TransferOptions(remainderValueStrategy: .changeAddress, skipSync: false, outputKind: nil)
        }
        currentOptions!.dict.forEach({ transfer[$0.key] = $0.value })
        accountManager?.walletManager?.sendCommand(id: "SendTransfer",
                                                   cmd: "sendTransfer",
                                                   payload: ["accountId": id,
                                                             "transfer": transfer
                                                            ]) { result, error in
            if let output = WalletResponse<TransferResponse>.decode(result)?.payload {
                onResult?(.success(output))
            } else if let error = error {
                onResult?(.failure(error))
            } else {
                onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
            }
        }
    }
    
    public func sendNFT(address: String, nftId: String, onResult: ((Result<Transaction, Error>) -> Void)?) {
        let addressesAndNftIds = [["address":address, "nftId": nftId]]
        self.accountManager?.walletManager?.sendCommand(
            id: "SendNFT",
            cmd: "callAccountMethod",
            payload: [
                "accountId": self.id,
                "method": [
                    "name": "sendNft",
                    "data": ["addressesAndNftIds": addressesAndNftIds]
                ]
            ],
            callback: { result, error in
                if let output = WalletResponse<Transaction>.decode(result)?.payload {
                    onResult?(.success(output))
                } else if let error = error {
                    onResult?(.failure(error))
                } else {
                    onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
                }
            }
        )
    }
    
    public func buildAliasOutput(options: BuildAliasOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        self.accountManager?.walletManager?.sendCommand(
            id: "BuildAliasOutput",
            cmd: "callAccountMethod",
            payload: [
                "accountId": self.id,
                "method": [
                    "name": "buildAliasOutput",
                    "data": options.dictionary ?? [:]
                ]
            ],
            callback: { result, error in
                if let output = WalletResponse<Output>.decode(result)?.payload {
                    onResult?(.success(output))
                } else if let error = error {
                    onResult?(.failure(error))
                } else {
                    onResult?(.failure(IOTAResponseError.decode(from: result ?? "")))
                }
            }
        )
    }
}
