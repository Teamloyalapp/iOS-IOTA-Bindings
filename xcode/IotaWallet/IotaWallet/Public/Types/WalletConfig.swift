import Foundation

struct WalletConfig: Codable {
    var storagePath: String?
    var clientOptions: ClientConfig?
    var coinType: Int?
 //   var secretManager: SecretManager?
}
