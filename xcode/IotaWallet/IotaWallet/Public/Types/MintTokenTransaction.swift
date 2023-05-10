import Foundation

public struct MintTokenTransaction: Codable {
    var tokenId: String
    var transaction: Transaction?
}
