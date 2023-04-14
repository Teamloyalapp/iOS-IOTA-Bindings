import Foundation

struct InputSigningData: Codable {
    /// The output
    var output: Output?
    /// The output metadata
    var outputMetadata: OutputMetadata?
    /// The chain derived from seed, only for ed25519 addresses
    /// Bip32 path.
    var chain: [Segment]
    /// The bech32 encoded address, required because of alias outputs where we have multiple possible unlock
    /// conditions, because we otherwise don't know which one we need
}
