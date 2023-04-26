import Foundation

public struct PrepareOutput: AccountMethod, Codable {
    let options: OutputOptions
    let transactionOptions: TransactionOptions
}
