import Foundation

public struct NativeToken: Codable {
    // Identifier of the native token.
    var tokenId: String
    var total: String?
    var available: String?

}
