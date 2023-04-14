import Foundation

struct AddressWithAmount: Codable {
    /// Bech32 encoded address
    var address: String
    /// Amount
    var amount: String
}
