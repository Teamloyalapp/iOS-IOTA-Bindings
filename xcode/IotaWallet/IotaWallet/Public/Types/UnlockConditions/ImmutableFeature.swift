import Foundation

// MARK: - ImmutableFeature
struct ImmutableFeature: Codable {
    let type: Int?
    let address: AddressWrapper?
    let data: String?
}

