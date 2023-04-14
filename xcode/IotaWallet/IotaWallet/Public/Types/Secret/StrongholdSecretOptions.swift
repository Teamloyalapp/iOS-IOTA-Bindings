import Foundation

public struct StrongholdSecretOptions: Codable {
    public let password: String
    public let timeout: Int?
    public let snapshotPath: String
    
    public init(password: String, timeout: Int? = nil, snapshotPath: String) {
        self.password = password
        self.timeout = timeout
        self.snapshotPath = snapshotPath
    }
}
