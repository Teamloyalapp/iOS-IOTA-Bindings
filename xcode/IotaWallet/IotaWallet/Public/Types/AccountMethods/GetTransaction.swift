import Foundation

public struct GetTransaction: AccountMethod, Codable {
    public let transactionId: String
}
