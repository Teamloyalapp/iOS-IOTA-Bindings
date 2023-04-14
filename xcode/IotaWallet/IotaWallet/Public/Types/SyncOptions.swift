import Foundation

public struct SyncOptions: Codable {
    /// Specific Bech32 encoded addresses of the account to sync, if addresses are provided, then `address_start_index`
    /// will be ignored
    var addresses: [String] = []
    /// Address index from which to start syncing addresses. 0 by default, using a higher index will be faster because
    /// addresses with a lower index will be skipped, but could result in a wrong balance for that reason
    var addressStartIndex: Int = 0
    /// Address index from which to start syncing internal addresses. 0 by default, using a higher index will be faster
    /// because addresses with a lower index will be skipped, but could result in a wrong balance for that reason
    var addressStartIndexInternal: Int = 0
    /// Usually syncing is skipped if it's called in between 200ms, because there can only be new changes every
    /// milestone and calling it twice "at the same time" will not return new data
    /// When this to true, we will sync anyways, even if it's called 0ms after the las sync finished.
    var forceSyncing: Bool = false
    /// Try to sync transactions from incoming outputs with their inputs. Some data may not be obtained if it has been
    /// pruned.
    var syncIncomingTransactions: Bool = false
    /// Checks pending transactions and promotes/reattaches them if necessary.
    var syncPendingTransactions: Bool = false
    /// Specifies if only basic outputs should be synced or also alias and nft outputs
    var syncAliasesAndNfts: Bool = true
    /// Specifies if only basic outputs with an AddressUnlockCondition alone should be synced, will overwrite
    var syncOnlyMostBasicOutputs: Bool = false
    /// Sync native token foundries, so their metadata can be returned in the balance.
    var syncNativeTokenFoundries: Bool = false
}
