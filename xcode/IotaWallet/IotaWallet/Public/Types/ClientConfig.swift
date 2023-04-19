import Foundation

public struct ClientConfig: Codable {
    var primaryNode: String?
    var primaryPowNode: String?
    var nodes: [String]
    var permanodes: [String]
    var nodeSyncEnabled: Bool
    var nodeSyncInterval: NodeSyncInterval?
    var quorum: Bool
    var minQuorumSize: Int?
    var quorumThreshold: Int?
    var network: String?
    var bech32Hrp: String?
    var minPowScore: Double?
    var localPow: Bool
    var fallbackToLocalPow: Bool
    var tipsInterval: Int?
    var rentStructure: RentStructure?
    var apiTimeout: ApiTimeout?
    var remotePowTimeout: RemotePowTimeout?
    var offline: Bool
    var powWorkerCount: Int?
}

public struct NodeSyncInterval: Codable {
    var secs: Int
    var nanos: Int
}

public struct RentStructure: Codable {
    var vByteCost: Int
    var vByteFactorKey: Int
    var vByteFactorData: Int
}

public struct ApiTimeout: Codable {
    var secs: Int
    var nanos: Int
}

public struct RemotePowTimeout: Codable {
    var secs: Int
    var nanos: Int
}
