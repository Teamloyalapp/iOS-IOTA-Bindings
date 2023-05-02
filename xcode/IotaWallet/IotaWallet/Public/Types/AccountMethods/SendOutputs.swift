import Foundation

public struct SendOutputs: AccountMethod, Codable {
    let outputs: [Output]
    let options: TransactionOptions?
}
