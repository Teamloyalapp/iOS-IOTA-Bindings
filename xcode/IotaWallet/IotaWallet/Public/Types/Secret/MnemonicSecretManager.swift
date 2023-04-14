import Foundation

public struct MnemonicSecretManager: SecretManager, Codable {
    let mnemonic: String
    
    var json: String {
        let json = try! JSONEncoder().encode(self)
        return String(data: json, encoding: .utf8)!
    }
}
