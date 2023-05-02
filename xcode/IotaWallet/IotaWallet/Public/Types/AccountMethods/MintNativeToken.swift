import Foundation

public struct MintNativeToken: AccountMethod, Codable {
    let nativeTokenOptions: NativeTokenOptions
    let options: TransactionOptions?
}
