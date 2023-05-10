import Foundation

public struct OutputData: Codable {
    /// The output id.
    var outputId: String?
    /// The metadata of the output.
    var metadata: OutputMetadata?
    /// The actual Output.
    var output: Output?
    /// If an output is spent.
    var isSpent: Bool?
    /// Associated account address.
    var address: Address?
    /// Network ID.
    var networkId: String?
    /// Remainder.
    var remainder: Bool?
    /// Bip32 path.
    var chain: [Segment]?
    
}
