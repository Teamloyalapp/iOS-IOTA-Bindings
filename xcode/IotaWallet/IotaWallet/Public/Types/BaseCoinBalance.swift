import Foundation

struct BaseCoinBalance: Codable {
    /// Total amount
    var total: Int
    /// Balance that can currently be spent
    var available: Int
}
