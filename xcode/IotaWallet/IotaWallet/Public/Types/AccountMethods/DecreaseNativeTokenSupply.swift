import Foundation

public struct DecreaseNativeTokenSupply: AccountMethod, Codable {
    let tokenId: String
    let meltAmount: String
    let options: TransactionOptions?
}
