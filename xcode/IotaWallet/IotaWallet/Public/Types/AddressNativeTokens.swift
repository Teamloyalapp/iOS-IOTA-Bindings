import Foundation

struct NativeTokenTuple: Codable {
    var tokenId: String
    var amount: String
}

struct AddressNativeTokens: Codable {
    /// Bech32 encoded address
    var address: String
    /// Native tokens
    var nativeTokens: [[String]]
    /// Bech32 encoded address return address, to which the storage deposit will be returned. Default will use the
    /// first address of the account
    var returnAddress: String?
    /// Expiration in seconds, after which the output will be available for the sender again, if not spent by the
    /// receiver before. Default is 1 day
    var expiration: Int?
}
