import Foundation

public struct SendNativeTokens: AccountMethod, Codable {
    let addressesNativeTokens: [AddressNativeTokens]
    let options: TransactionOptions
}
