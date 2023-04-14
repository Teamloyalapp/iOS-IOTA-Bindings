import Foundation

struct OutputMetadata: Codable {
    var blockId: BlockId?
    var transactionId: TransactionId?
    var outputIndex: Int?
    var isSpent: Bool?
    var milestoneIndexSpent: Int?
    var milestoneTimestampSpent: Int?
    var transactionIdSpent: TransactionId?
    var milestoneIndexBooked: Int?
    var milestoneTimestampBooked: Int?
    var ledgerIndex: Int?
}
