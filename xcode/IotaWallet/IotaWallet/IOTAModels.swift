//
//  IOTAModels.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

/// The generic response error.
public struct IOTAResponseError: Error, Decodable {
    
    /// The details about the error.
    public struct Details: Decodable {
        
        /// The specified type of the error.
        public let type: String
        
        /// The error itself.
        public let error: String
    }
    
    /// The default unknown error.
    public static let unknown = IOTAResponseError(type: "Unknown", payload: Details(type: "", error: ""))
    
    /// The kind of error.
    public let type: String

    /// The error's payload.
    public let payload: Details
    
    static func decode(from: String) -> IOTAResponseError {
        IOTAResponseError.decode(from) ?? IOTAResponseError.unknown
    }
}

/// The log level.
public enum LogLevel: Int {
    /// No logs at all (use this for a production env)
    case none
    /// Errors only
    case errors
    /// Warnings only
    case warnings
    /// All the debug logs, useful for debug purposes
    case debug
}

/// The signer type.
public enum SignerType: String {
    /// Stronghold
    case stronghold = "Stronghold"
}

/// The address associated to an account.
public struct IOTAAddress: Decodable, Hashable {
    
    /// The address output for a transaction.
    public struct AddressOutput: Decodable, Hashable {
        
        /// The transaction ID.
        public let transactionId: String
        
        /// The message ID.
        public let messageId: String
        
        /// The index.
        public let index: Int
        
        /// The amount carried with the transaction.
        public let amount: Int
        
        /// The output kind.
        public let kind: OutputKind?
        
        /// Tells if is spent.
        public let isSpent: Bool?
    }
    
    /// The address.
    public let address: String
    
    /// The balance of the address.
    public let balance: Int
    
    /// The index of the address.
    public let keyIndex: Int
    
    /// The outputs associated to the address.
    public let outputs: [String: AddressOutput]?
    
    /// The equatable function.
    /// - Returns: The equality between two addresses
    public static func == (lhs: IOTAAddress, rhs: IOTAAddress) -> Bool {
        return lhs.address == rhs.address
    }
}

/// The IOTAAccount that defines a IOTA account.
public class IOTAAccount: Decodable {
    
    /// The address associated to an account.
    public struct Address: Decodable, Hashable {
        
        /// The address.
        public let address: String
        
        /// The index of the address.
        public let keyIndex: Int
        
        /// The equatable function.
        /// - Returns: The equality between two addresses
        public static func == (lhs: Address, rhs: Address) -> Bool {
            return lhs.address == rhs.address
        }
    }
    
    /// The ID for the output.
    public var id: String { alias }
    
    /// The alias.
    public let alias: String
    
    /// The addresses.
    public internal(set) var publicAddresses: [Address]
    
    weak var accountManager: IOTAAccountManager?
    
    private enum CodingKeys: String, CodingKey {
        case alias, publicAddresses
    }
}

/// The output kind associated to an `AddressOutput`.
public enum OutputKind: String, Decodable {
    /// The `SignatureLockedSingle` output kind
    case signatureLockedSingle = "SignatureLockedSingle"
    /// The `SignatureLockedDustAllowance` output kind
    case signatureLockedDustAllowance = "SignatureLockedDustAllowance"
}

/// The Stronghold status of the wallet.
public struct StrongholdStatus: Decodable {
    
    /// The status itself.
    public enum Status: String, Decodable {
        /// Locked status
        case locked = "Locked"
        ///Unlocked status
        case unlocked = "Unlocked"
    }
    
    /// The time represented in seconds and nanoseconds.
    public struct Data: Decodable {
        
        /// The seconds.
        public let secs: Int
        
        /// The nanoseconds.
        public let nanos: Int
    }
    
    /// The Snapshot of the Stronghold status
    public struct Snapshot: Decodable {
        
        /// The status itself
        public let status: Status
        
        /// The current time associated to the snapshot.
        public let data: Data?
    }
    
    /// The snapshot path of Stronghold.
    public let snapshotPath: String
    
    /// The snapshot itself.
    public let snapshot: Snapshot
}

/// The transfer options, normally associated to a Transfer.
public struct TransferOptions {
    
    /// The remainder strategy.
    public enum RemainderValueStrategy {
        /// Change address strategy
        case changeAddress
        /// Reuse address strategy
        case reuseAddress
        /// Specifies a different account address
        case accountAddress(address: String)
        
        var dict: [String: Any] {
            let strategyKey = "strategy"
            switch self {
            case .changeAddress: return [strategyKey: "ChangeAddress"]
            case .reuseAddress: return [strategyKey: "ReuseAddress"]
            case .accountAddress(let address): return [strategyKey: "ReuseAddress", "value": address]
            }
        }
    }
    
    /// The reminder strategy.
    public let remainderValueStrategy: RemainderValueStrategy?
    
    /// Tells if the skip should be skipped or not.
    public let skipSync: Bool?
    
    /// The output kind.
    public let outputKind: OutputKind?
    
    var dict: [String: Any] {
        var result: [String: Any] = [:]
        result["remainder_value_strategy"] = remainderValueStrategy?.dict
        result["skip_sync"] = skipSync
        result["output_kind"] = outputKind?.rawValue
        return result
    }
}

public struct IOTABalance: Codable {
    let baseCoin: BaseCoin
    let requiredStorageDeposit: RequiredStorageDeposit
    let nativeTokens, nfts, aliases, foundries: [String]
    let potentiallyLockedOutputs: PotentiallyLockedOutputs
}

// MARK: - BaseCoin
struct BaseCoin: Codable {
    let total, available: String
}

// MARK: - PotentiallyLockedOutputs
struct PotentiallyLockedOutputs: Codable {
}
