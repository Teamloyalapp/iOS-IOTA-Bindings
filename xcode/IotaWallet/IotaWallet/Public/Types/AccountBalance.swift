import Foundation

struct AccountBalance: Codable {
    /// Total and available amount of the base coin
    var baseCoin: BaseCoinBalance?
    /// Current required storage deposit amount
    var requiredStorageDeposit: RequiredStorageDeposit?
    /// Native tokens
    var nativeTokens: [NativeTokensBalance]
    /// Nfts
    var nfts: [NftId]
    /// Aliases
    var aliases: [AliasId]
    /// Foundries
    var foundries: [FoundryId]
    /// Outputs with multiple unlock conditions and if they can currently be spent or not. If there is a
    /// [`TimelockUnlockCondition`] or [`ExpirationUnlockCondition`] this can change at any time
    var potentiallyLockedOutputs: [OutputId : Bool]    
}
