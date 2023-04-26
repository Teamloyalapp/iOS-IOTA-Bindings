import Foundation

public struct GenerateAddresses: AccountMethod, Codable {
    let amount: Int
    let options: AddressGenerationOptions
}

public struct AddressGenerationOptions: AccountMethod, Codable {
    let isInternal: Bool
    let options: GenerateAddressOptions
    
    public enum CodingKeys: String, CodingKey {
        case isInternal = "internal"
        case options
    }
}

public struct GenerateAddressOptions: AccountMethod, Codable {
    let ledgerNanoPrompt: Bool
}
