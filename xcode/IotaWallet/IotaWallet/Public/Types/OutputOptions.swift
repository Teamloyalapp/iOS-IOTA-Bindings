import Foundation

struct OutputOptions: Codable {
    var recipientAddress: String
    var amount: String
    var assets: Assets?
    var features: Features?
    var unlocks: Unlocks?
    var storageDeposit: StorageDeposit?
}

struct Assets: Codable {
    var nftId: String?
    var nativeTokens: [NativeToken]
}

struct Features: Codable {
    var tag: String?
    var metadata: String?
}

struct Unlocks: Codable {
    var expirationUnixTime: Int?
    var timelockUnixTime: Int?
}

struct StorageDeposit: Codable {
    var returnStrategy: ReturnStrategy?
    var useExcessIfLow: Bool?
}

enum ReturnStrategy: String, Codable {
    case Return
    case Gift
}
