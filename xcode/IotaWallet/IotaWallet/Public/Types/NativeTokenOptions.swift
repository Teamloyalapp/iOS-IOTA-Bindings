import Foundation

struct NativeTokenOptions: Codable {
    /// Bech32 encoded address. Needs to be an account address. Default will use the first address of the account
    var accountAddress: String?
    /// Circulating supply
    var circulatingSupply: String?
    /// Maximum supply
    var maximumSupply: String?
    /// Foundry metadata, hex encoded bytes
    var foundryMetadata: String?
}
