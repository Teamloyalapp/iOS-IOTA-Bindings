import Foundation

public struct MintTokenTransaction: Codable {
    var tokenId: TokenId
    var transaction: Transaction?
}
