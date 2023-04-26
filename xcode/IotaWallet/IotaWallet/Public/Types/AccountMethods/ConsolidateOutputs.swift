import Foundation

public struct ConsolidateOutputs: AccountMethod, Codable {
    var force: Bool
    var outputConsolidationThreshold: Int?
}
