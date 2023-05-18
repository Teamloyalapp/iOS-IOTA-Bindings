import Foundation

public struct SendOutputs: AccountMethod, Codable {
    let outputs: [OutputWrapper]
    let options: TransactionOptions?
}
