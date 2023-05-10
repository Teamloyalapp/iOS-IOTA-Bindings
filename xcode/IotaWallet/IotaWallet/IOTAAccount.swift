import Foundation

extension IOTAAccount {
    
    /// Synchronizes the account with the Tangle.
    /// - Parameter onResult: The result or error
    public func sync(onResult: ((Result<IOTABalance, Error>) -> Void)?) {
        callAccountMethod(SyncAccount(), onResult: onResult)
    }
    
    // TODO: check response
    /// Generates a new unused address and returns it.
    /// - Parameter onResult: The address or error
    public func generateAddresses(options: GenerateAddresses, onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func getAddresses(onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        callAccountMethod(Addresses(), onResult: onResult)
    }
    
    public func getAddressesWithUnspentOutputs(onResult: ((Result<[IOTAAccount.Address], Error>) -> Void)?) {
        callAccountMethod(AddressesWithUnspentOutputs(), onResult: onResult)
    }
    
    public func getOutputs(options: Outputs, onResult: ((Result<[OutputData], Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func getPendingTransactions(onResult: ((Result<[Transaction], Error>) -> Void)?) {
        callAccountMethod(PendingTransactions(), onResult: onResult)
    }
    
    public func getTransactions(onResult: ((Result<[Transaction], Error>) -> Void)?) {
        callAccountMethod(Transactions(), onResult: onResult)
    }
    
    public func getUnspentOutputs(options: UnspentOutputs, onResult: ((Result<[OutputData], Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    /// Returns the account's balance information object.
    /// - Parameter onResult: The balance response or error
    public func getBalance(onResult: ((Result<AccountBalance, Error>) -> Void)?) {
        callAccountMethod(GetBalance(), onResult: onResult)
    }
    
    public func sendNFT(options: SendNft, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    /// Updates the account alias.
    /// - Parameters:
    ///   - newAlias: The new alias
    ///   - onResult: The result or error
    public func setAlias(options: SetAlias, onResult: ((Result<Bool, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func buildAliasOutput(options: BuildAliasOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func buildBasicOutput(options: BuildBasicOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func buildFoundryOutput(options: BuildFoundryOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func buildNftOutput(options: BuildNftOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func burnNativeToken(options: BurnNativeToken, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func burnNFT(options: BurnNft, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func consolidateOutputs(options: ConsolidateOutputs, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func destroyAlias(options: DestroyAlias, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func destroyFoundry(options: DestroyFoundry, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func getOutput(options: GetOutput, onResult: ((Result<OutputData, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func getFoundryOutput(options: GetFoundryOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func getOutputsWithAdditionalUnlockConditions(options: GetOutputsWithAdditionalUnlockConditions, onResult: ((Result<[Output], Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func getTransaction(options: GetTransaction, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    // TODO: Unkown result
    public func getIncomingTransactionData(options: GetIncomingTransactionData, onResult: ((Result<String, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }

    public func meltNativeToken(options: DecreaseNativeTokenSupply, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func minimumRequiredStorageDeposit(options: MinimumRequiredStorageDeposit, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func mintNativeToken(options: MintNativeToken, onResult: ((Result<MintTokenTransaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func mintNfts(options: MintNfts, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func prepareOutput(options: PrepareOutput, onResult: ((Result<Output, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func prepareTransaction(options: PrepareTransaction, onResult: ((Result<PreparedTransactionData, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func retryTransactionUntilIncluded(options: RetryTransactionUntilIncluded, onResult: ((Result<BlockId, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func prepareSendAmount(options: PrepareSendAmount, onResult: ((Result<PreparedTransactionData, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func sendAmount(options: SendAmount, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func sendMicroTransaction(options: SendMicroTransaction, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func sendNativeTokens(options: SendNativeTokens, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func sendOutputs(options: SendOutputs, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func signTransactionEssence(options: SignTransactionEssence, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func submitAndStoreTransaction(options: SubmitAndStoreTransaction, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func claimOutputs(options: ClaimOutputs, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    public func createAliasOutput(options: CreateAliasOutput, onResult: ((Result<Transaction, Error>) -> Void)?) {
        callAccountMethod(options, onResult: onResult)
    }
    
    private func callAccountMethod<T: Decodable>(_ method: AccountMethod, onResult: ((Result<T, Error>) -> Void)?) {
        let methodName = String(describing: type(of: method))
        let data = method.dictionary ?? [:]
        var methodPatload: [String:Any] = [
            "name": methodName.prefix(1).lowercased() + methodName.dropFirst(),
            "data": data
        ]
        if !method.hasData() {
            methodPatload["data"] = nil
        }
        let payload: [String:Any] = [
            "accountId": self.id,
            "method": methodPatload
        ]
        accountManager?.walletManager?.sendCommand(
            id: methodName,
            cmd: "callAccountMethod",
            payload: payload,
            callback: { result, error in
                if let output = WalletResponse<T>.decode(result)?.payload {
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
