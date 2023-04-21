import Foundation

/// The Node Info response.
public struct NodeInfoResponse: Decodable {
    
    /// The Node Info data.
    public let nodeInfo: NodeInfo
    
    /// The URL associated to the node.
    public let url: String
}

// MARK: - NodeInfo
public struct NodeInfo: Decodable {
    /// The name associated to the node.
    let name: String
    /// The current version of the node.
    let version: String
    /// The status of the node.
    let status: NodeInfoStatus
    ///
    let supportedProtocolVersions: [Int]
    ///
    let nodeInfoProtocol: NodeProtocolClass
    ///
    // let pendingProtocolParameters: [?]
    ///
    let baseToken: NodeBaseToken
    ///
    let metrics: NodeMetrics
    /// The current features associated to the node.
    let features: [String]

    enum CodingKeys: String, CodingKey {
        case name, version, status, supportedProtocolVersions
        case nodeInfoProtocol = "protocol"
        case baseToken, metrics, features
        // case pendingProtocolParameters
    }
}

// MARK: - NodeInfoStatus
public struct NodeInfoStatus: Codable {
    let isHealthy: Bool
    let latestMilestone, confirmedMilestone: Milestone
    let pruningIndex: Int
}

// MARK: - NodeProtocolClass
struct NodeProtocolClass: Codable {
    let version: Int
    let networkName, bech32Hrp: String
    let minPowScore, belowMaxDepth: Int
    let rentStructure: NodeRentStructure
    let tokenSupply: String
}

// MARK: - NodeRentStructure
struct NodeRentStructure: Codable {
    let vByteCost, vByteFactorKey, vByteFactorData: Int
}

// MARK: - BaseToken
struct NodeBaseToken: Codable {
    let name, tickerSymbol, unit, subunit: String
    let decimals: Int
    let useMetricPrefix: Bool
}

// MARK: - Metrics
struct NodeMetrics: Codable {
    let blocksPerSecond, referencedBlocksPerSecond, referencedRate: Double
}

// MARK: - Milestone
struct Milestone: Codable {
    let index, timestamp: Int
    let milestoneID: String

    enum CodingKeys: String, CodingKey {
        case index, timestamp
        case milestoneID = "milestoneId"
    }
}

