import Foundation

public struct FilterOptions: Codable {
    /// Filter all outputs where the booked milestone index is below the specified timestamp
    var lowerBoundBookedTimestamp: Int?
    /// Filter all outputs where the booked milestone index is above the specified timestamp
    var upperBoundBookedTimestamp: Int?
    /// Filter all outputs for the provided types (Basic = 3, Alias = 4, Foundry = 5, NFT = 6)
    var outputTypes: [Int]
}
