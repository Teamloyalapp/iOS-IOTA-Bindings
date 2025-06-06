import Foundation

public class NativeTokensBalance: Codable {
    /// Token id
    let tokenId: String
    /// Token foundry immutable metadata
    let metadata: String?
    /// Total amount
    let total: String
    /// Balance that can currently be spent
    let available: String

}
