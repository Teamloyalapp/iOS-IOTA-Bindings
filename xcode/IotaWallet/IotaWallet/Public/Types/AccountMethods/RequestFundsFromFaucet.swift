import Foundation

public struct RequestFundsFromFaucet: AccountMethod, Codable {
    let url: String
    let address: String
}
