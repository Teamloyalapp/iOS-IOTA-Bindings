import Foundation

public struct AccountAddress: Codable {
    /// The address.
    var address: String
    /// The address key index.
    var keyIndex: Int
    /// Determines if an address is a public or an internal (change) address.
    var isInternal: Bool
    /// do we want this field? Could be useful if we don't store spent output ids and because of that wouldn't know if
    /// an address was used or not just by looking at it
    var used: Bool
    
    public enum CodingKeys: String, CodingKey {
        case address, keyIndex, used
        case isInternal = "internal"
    }
}
