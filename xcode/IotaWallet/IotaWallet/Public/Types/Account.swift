import Foundation

public struct Account: Codable {
    /// The account index.
    var index: Int?
    /// The coin type.
    var coinType: Int?
    /// The account alias.
    var alias: String?
    /// Public addresses.
    var publicAddresses: [AccountAddress]
    /// Internal addresses.
    var internalAddresses: [AccountAddress]
    /// Addresses with unspent outputs.
    var addressesWithUnspentOutputs: [AddressWithUnspentOutputs]
    /// Outputs.
   // var outputs: [OutputId : OutputData]
    /// Unspent outputs that are currently used as input for transactions
    var lockedOutputs: Set<OutputId>
    /// Unspent outputs.
    //var unspentOutputs: [OutputData]
    /// Sent transactions.
    //var transactions: [TransactionId : Transaction]
    /// Pending transactions.
    //var pendingTransactions: Set<TransactionId>
    /// Incoming transactions.
    //var incomingTransactions: [TransactionId: Transaction]
}
