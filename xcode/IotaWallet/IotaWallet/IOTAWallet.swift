//
//  IOTAWallet.swift
//  IotaWallet
//
//  Created by Andrii Moso on 15.01.2023.
//

import Foundation

public class IOTAWallet {
    public var currentAccountManager: IOTAAccountManager?
    var storagePath: String
    var backupPath: String
    var secretManager: SecretManager
    var nodeUrl: String
    
    let DEFAULT_DEVELOPMENT_MNEMONIC =
    "human any chuckle early velvet fall silly act desk dress winner kingdom power element north hurdle liar little purse goat knee love hollow drip"
    
    public init(storagePath: String, backupPath: String, secretManager: SecretManager, coinType: CoinType, nodeUrl: String) {
        let accountManager = IOTAAccountManager(storagePath: storagePath, secretManager: secretManager, coinType: coinType, nodeURL: nodeUrl)
        self.storagePath = storagePath
        self.secretManager = secretManager
        self.nodeUrl = nodeUrl
        self.backupPath = backupPath
        currentAccountManager = accountManager
        
        let url = URL.iotaDir.appendingPathComponent("Logs.log")
        let loggerStatus = Wallet.init_logger(url.path, level_filter: "Debug")
        print("iota wallet logger status - \(loggerStatus)")
    }
    
    // alias - unique identifier, that identify user (userId with prefix)
    public func createIOTAWallet(alias: String, onResult: ((Result<Bool, Error>) -> Void)? = nil)  {
        self.currentAccountManager?.generateMnemonic(onResult: { result in
            let mnemonic: String
            if let mnemonicResult = try? result.get() {
                mnemonic = mnemonicResult
            } else {
                mnemonic = self.DEFAULT_DEVELOPMENT_MNEMONIC
            }
            self.currentAccountManager?.storeMnemonic(mnemonic: mnemonic, onResult: { result in
                self.currentAccountManager?.getAccount(alias: alias) { result in
                    let account = try? result.get()
                    if account == nil {
                        self.currentAccountManager?.createAccount(alias: alias, url: self.nodeUrl, localPow: true, onResult: { result in
                            if let strongholdSecretManager = self.secretManager as? StrongholdSecretManager {
                                let password = strongholdSecretManager.Stronghold.password
                                self.currentAccountManager?.backup(destination: self.backupPath, password: password, onResult: { result in
                                    onResult?(result)
                                })
                            } else {
                                onResult?(.failure(NSError()))
                            }
                        })
                    }
                }
            })
        })
    }
    
    public func getAccountAddress(alias: String, onResult: @escaping (Result<String?, Error>) -> Void) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                onResult(.success(account.publicAddresses.first?.address))
            case .failure(let error):
                onResult(.failure(error))
            }
        }
    }
    
    public func getAccountListNftsIds(alias: String, onResult: @escaping (Result<[String], Error>) -> Void) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.balance { balanceResult in
                    switch balanceResult {
                    case .success(let balance):
                        onResult(.success(balance.nfts))
                    case .failure(let error):
                        onResult(.failure(error))
                    }
                }
            case .failure(let error):
                onResult(.failure(error))
            }
        }
    }
    
    public func restoreBackup(alias: String, onResult: ((Result<IOTAAccount, Error>) -> Void)? = nil) {
        if let strongholdSecretManager = secretManager as? StrongholdSecretManager {
            currentAccountManager?.restoreBackup(source: backupPath, password: strongholdSecretManager.Stronghold.password, onResult: { result in
                self.syncAccount(alias: alias) { result in
                    onResult?(result)
                }
            })
        }
    }
    
    public func sendNFT(alias: String, address: String, nftId: String, onResult: ((Result<Transaction, Error>) -> Void)? = nil) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sendNFT(address: address, nftId: nftId) { result in
                    switch result {
                    case .success(let data):
                        onResult?(.success(data))
                    case .failure(let error):
                        onResult?(.failure(error))
                    }
                }
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func buildAliasOutput(alias: String, options: BuildAliasOutput, onResult: ((Result<Output, Error>) -> Void)? = nil) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.buildAliasOutput(options: options) { result in
                    switch result {
                    case .success(let data):
                        onResult?(.success(data))
                    case .failure(let error):
                        onResult?(.failure(error))
                    }
                }
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    
    func syncAccount(alias: String, onResult: ((Result<IOTAAccount, Error>) -> Void)? = nil) {
        currentAccountManager?.getAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sync { syncResult in
                    switch syncResult {
                    case .failure(let syncError):
                        onResult?(.failure(syncError))
                    case .success:
                        onResult?(Result.success(account))
                    }
                }
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
}
