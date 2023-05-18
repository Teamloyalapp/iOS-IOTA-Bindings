import Foundation

struct RemainderData: Codable {
    /// The remainder output
    var output: OutputWrapper?
    /// The chain derived from seed, for the remainder addresses
    var chain: [Segment]
    /// The remainder address
    var address: AddressWrapper?
}
