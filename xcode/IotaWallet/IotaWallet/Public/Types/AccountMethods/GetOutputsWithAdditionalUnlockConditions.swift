import Foundation

public struct GetOutputsWithAdditionalUnlockConditions: AccountMethod, Codable {
    
    let outputsToClaim: OutputsToClaim
    
    enum OutputsToClaim: String, Codable {
        case none
        case microTransactions
        case nativeTokens
        case nfts
        case all
     }
}


