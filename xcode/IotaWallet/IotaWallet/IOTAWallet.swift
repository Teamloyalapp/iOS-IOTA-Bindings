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
    "silver cherry food captain demand mind exit hub naive fantasy monkey motor feed caution unaware traffic decade link rebel solve lottery problem pepper language"
    
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
                account.getBalance(onResult: { balanceResult in
                    switch balanceResult {
                    case .success(let balance):
                        onResult(.success(balance.nfts))
                    case .failure(let error):
                        onResult(.failure(error))
                    }
                })
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
    
    public func generateAddresses(alias: String, options: GenerateAddresses, onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.generateAddresses(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func sendNFT(alias: String, options: SendNft, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sendNFT(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func setAlias(alias: String, options: SetAlias, onResult: ((Result<Bool, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.setAlias(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getAddresses(alias: String, onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getAddresses(onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getAddressesWithUnspentOutputs(alias: String, onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getAddressesWithUnspentOutputs(onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getOutputs(alias: String, options: Outputs, onResult: ((Result<[OutputData], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getOutputs(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getPendingTransactions(alias: String, onResult: ((Result<[Transaction], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getPendingTransactions(onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getTransactions(alias: String, onResult: ((Result<[Transaction], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getTransactions(onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getUnspentOutputs(alias: String, options: UnspentOutputs, onResult: ((Result<[OutputData], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getUnspentOutputs(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func buildAliasOutput(alias: String, options: BuildAliasOutput, onResult: ((Result<Output, Error>) -> Void)? = nil) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.buildAliasOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func buildBasicOutput(alias: String, options: BuildBasicOutput, onResult: ((Result<Output, Error>) -> Void)? = nil) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.buildBasicOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func buildFoundryOutput(alias: String, options: BuildFoundryOutput, onResult: ((Result<Output, Error>) -> Void)? = nil) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.buildFoundryOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func buildNftOutput(alias: String, options: BuildNftOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.buildNftOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func burnNativeToken(alias: String, options: BurnNativeToken, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.burnNativeToken(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func burnNFT(alias: String, options: BurnNft, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.burnNFT(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }

    public func consolidateOutputs(alias: String, options: ConsolidateOutputs, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.consolidateOutputs(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func destroyAlias(alias: String, options: DestroyAlias, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.destroyAlias(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func destroyFoundry(alias: String, options: DestroyFoundry, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.destroyFoundry(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getOutput(alias: String, options: GetOutput, onResult: ((Result<OutputData, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getFoundryOutput(alias: String, options: GetFoundryOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getFoundryOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getOutputsWithAdditionalUnlockConditions(alias: String, options: GetOutputsWithAdditionalUnlockConditions, onResult: ((Result<[Output], Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getOutputsWithAdditionalUnlockConditions(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getTransaction(alias: String, options: GetTransaction, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getTransaction(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getIncomingTransactionData(alias: String, options: GetIncomingTransactionData, onResult: ((Result<String, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getIncomingTransactionData(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func meltNativeToken(alias: String, options: DecreaseNativeTokenSupply, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.meltNativeToken(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func minimumRequiredStorageDeposit(alias: String, options: MinimumRequiredStorageDeposit, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.minimumRequiredStorageDeposit(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func mintNativeToken(alias: String, options: MintNativeToken, onResult: ((Result<MintTokenTransaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.mintNativeToken(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func mintNfts(alias: String, options: MintNfts, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.mintNfts(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func getBalance(alias: String, onResult: ((Result<AccountBalance, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.getBalance(onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func prepareOutput(alias: String, options: PrepareOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.prepareOutput(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func prepareTransaction(alias: String, options: PrepareTransaction, onResult: ((Result<PreparedTransactionData, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.prepareTransaction(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func retryTransactionUntilIncluded(alias: String, options: RetryTransactionUntilIncluded, onResult: ((Result<BlockId, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.retryTransactionUntilIncluded(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func prepareSendAmount(alias: String, options: PrepareSendAmount, onResult: ((Result<PreparedTransactionData, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.prepareSendAmount(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func sendAmount(alias: String, options: SendAmount, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sendAmount(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func sendMicroTransaction(alias: String, options: SendMicroTransaction, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sendMicroTransaction(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func sendNativeTokens(alias: String, options: SendNativeTokens, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sendNativeTokens(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func sendOutputs(alias: String, options: SendOutputs, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.sendOutputs(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func signTransactionEssence(alias: String, options: SignTransactionEssence, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.signTransactionEssence(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func submitAndStoreTransaction(alias: String, options: SubmitAndStoreTransaction, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.submitAndStoreTransaction(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func claimOutputs(alias: String, options: ClaimOutputs, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.claimOutputs(options: options, onResult: onResult)
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }
    
    public func createAliasOutput(alias: String, options: CreateAliasOutput, onResult: ((Result<Transaction, Error>) -> Void)?) {
        syncAccount(alias: alias) { result in
            switch result {
            case .success(let account):
                account.createAliasOutput(options: options, onResult: onResult)
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
                        onResult?(.success(account))
                    }
                }
            case .failure(let error):
                onResult?(.failure(error))
            }
        }
    }

}

