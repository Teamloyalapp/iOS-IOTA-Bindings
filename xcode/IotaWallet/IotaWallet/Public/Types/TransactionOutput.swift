import Foundation

struct TransactionOutput: Codable {
    var type: Int?
    var amount: String?
    var nftId: String?
    var unlockConditions: [UnlockCondition]?
    var immutableFeatures: [ImmutableFeature]?
}

