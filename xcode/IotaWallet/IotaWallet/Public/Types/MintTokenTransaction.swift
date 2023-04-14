import Foundation

struct MintTokenTransaction: Codable {
    var tokenId: TokenId
    var transaction: Transaction?
}
