import Foundation

public struct DecreaseNativeTokenSupply: AccountMethod, Codable {
    let tokenId: TokenId
    let meltAmount: String
    let options: TransactionOptions
}
