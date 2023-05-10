import Foundation

public struct AddressWithUnspentOutputs: Codable {
    /// The address.
    var address: String
    /// The address key index.
    var keyIndex:Int
    /// Determines if an address is a public or an internal (change) address.
    var isInternal: Bool
    /// Output ids.
    var outputIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case address
        case keyIndex
        case isInternal = "internal"
        case outputIds = "output_ids"
    }
}
