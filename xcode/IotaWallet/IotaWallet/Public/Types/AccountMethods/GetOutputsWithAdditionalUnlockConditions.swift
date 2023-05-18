import Foundation

public struct GetOutputsWithAdditionalUnlockConditions: AccountMethod, Codable {
    
    let outputsToClaim: OutputsToClaim
    
    enum OutputsToClaim: String, Codable {
        case none = "None"
        case microTransactions = "MicroTransactions"
        case nativeTokens = "NativeTokens"
        case nfts = "Nfts"
        case all = "All"
     }
}


