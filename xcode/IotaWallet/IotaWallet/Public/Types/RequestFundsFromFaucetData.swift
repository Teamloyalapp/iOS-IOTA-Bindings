import Foundation

public struct RequestFundsFromFaucetData: Codable {
    var address: String
    var waitingRequests: Int
}
