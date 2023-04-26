import Foundation

public struct ClaimOutputs: AccountMethod, Codable {
    let outputIdsToClaim: [OutputId]
}
