import Foundation

public struct BaseCoinBalance: Codable {
    /// Total amount
    var total: String
    /// Balance that can currently be spent
    var available: String
}
