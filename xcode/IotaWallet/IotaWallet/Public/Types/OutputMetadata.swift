import Foundation

struct OutputMetadata: Codable {
    var blockId: String?
    var transactionId: String?
    var outputIndex: Int?
    var isSpent: Bool?
    var milestoneIndexSpent: Int?
    var milestoneTimestampSpent: Int?
    var transactionIdSpent: String?
    var milestoneIndexBooked: Int?
    var milestoneTimestampBooked: Int?
    var ledgerIndex: Int?
}
