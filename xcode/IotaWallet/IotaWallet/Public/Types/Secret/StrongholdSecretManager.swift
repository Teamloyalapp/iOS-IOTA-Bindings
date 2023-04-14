import Foundation

public struct StrongholdSecretManager: SecretManager, Codable {
    public let Stronghold: StrongholdSecretOptions
    
    public init(Stronghold: StrongholdSecretOptions) {
        self.Stronghold = Stronghold
    }

    public var json: String {
        let json = try! JSONEncoder().encode(self)
        return String(data: json, encoding: .utf8)!
    }
}
