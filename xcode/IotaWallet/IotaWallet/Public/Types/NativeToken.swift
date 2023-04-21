import Foundation

public struct NativeToken: Codable {
    // Identifier of the native token.
    var id: TokenId
    var amount: String?
}
