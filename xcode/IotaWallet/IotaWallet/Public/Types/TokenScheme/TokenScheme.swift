import Foundation

public struct TokenScheme: Codable {
    var type: Int?
    var mintedTokens: String
    var meltedTokens: String
    var maximumSupply: String
}
