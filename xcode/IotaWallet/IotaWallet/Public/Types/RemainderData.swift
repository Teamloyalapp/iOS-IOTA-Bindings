import Foundation

struct RemainderData: Codable {
    /// The remainder output
    var output: Output?
    /// The chain derived from seed, for the remainder addresses
    var chain: [Segment]
    /// The remainder address
    var address: Address?
}
