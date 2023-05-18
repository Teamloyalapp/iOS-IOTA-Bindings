import Foundation

public struct SendNativeTokens: AccountMethod, Codable {
    let addressesNativeTokens: [AddressNativeTokens]
    var options: TransactionOptions?
}
