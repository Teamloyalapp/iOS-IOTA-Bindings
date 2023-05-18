import Foundation

public struct Ed25519Address: Address {
    public var type: Int = 0
    public let pubKeyHash: String
}
