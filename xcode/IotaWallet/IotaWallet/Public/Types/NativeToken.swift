import Foundation

public struct NativeToken: Codable {
    // Identifier of the native token.
    var tokenId: String
    var total: String?
    var available: String?
    
    public init(from decoder: Decoder) throws {
        enum CodingKeys: String, CodingKey {
            case tokenId
            case total
            case available
            case id
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tokenId = try? container.decode(String.self, forKey: .tokenId) {
            self.tokenId = tokenId
        } else if let tokenIdAlternative = try? container.decode(String.self, forKey: .id) {
            self.tokenId = tokenIdAlternative
        } else {
            throw DecodingError.keyNotFound(
                CodingKeys.tokenId,
                DecodingError.Context(
                    codingPath: [CodingKeys.tokenId, CodingKeys.id],
                    debugDescription: "Cannot find key 'tokenId' or 'id'"
                )
            )
        }
        
        total = try container.decodeIfPresent(String.self, forKey: .total)
        available = try? container.decode(String.self, forKey: .available)
    }
}
