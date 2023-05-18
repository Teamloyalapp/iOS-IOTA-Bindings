import Foundation

public struct PrepareTransaction: AccountMethod, Codable {
    let outputs: [OutputWrapper]
    let options: TransactionOptions?
}
