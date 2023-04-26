import Foundation

public struct PrepareTransaction: AccountMethod, Codable {
    let outputs: [Output]
    let options: TransactionOptions
}
