//
//  TransferModel.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

// MARK: - Transfer response model
public struct TransferResponse: Codable {
    /// Transfer id
    public let id: String
    /// Transfer version
    public let version: Int
    /// list of parents transfers
    public let parents: [String]
    /// Payload length
    public let payloadLength: Int
    /// Transfer payload
    public let payload: TransferPayload
    public let timestamp: String
    public let nonce: Decimal
    public let broadcasted: Bool
    public let reattachmentMessageID: String?

    public enum CodingKeys: String, CodingKey {
        case id, version, parents, payloadLength, payload, timestamp, nonce, broadcasted
        case reattachmentMessageID = "reattachmentMessageId"
    }
}

// MARK: - TransferPayload
public struct TransferPayload: Codable {
    public let type: String
    /// Transfer payload with data
    public let data: TransferPayloadData
}

// MARK: - TransferPayloadData
public struct TransferPayloadData: Codable {
    /// Transfer essence
    public let essence: TransferEssence
    /// Transfer unlock blocks
    public let unlockBlocks: [TransferUnlockBlock]

    public enum CodingKeys: String, CodingKey {
        case essence
        case unlockBlocks = "unlock_blocks"
    }
}

// MARK: - TransferEssence
public struct TransferEssence: Codable {
    public let type: String
    /// Transfer essence data
    public let data: TransferEssenceData
}

// MARK: - TransferEssenceData
public struct TransferEssenceData: Codable {
    /// List of inputs
    public let inputs: [TransferInput]
    /// List of outputs
    public let outputs: [TransferOutput]
    //public let payload: String?
    /// dataInternal - this is internal data, icomning - this is incoming transfer
    public let dataInternal, incoming: Bool
    /// value - transfer value, remainderValue - transfer remainder value
    public let value, remainderValue: Int

    public enum CodingKeys: String, CodingKey {
        case inputs, outputs
        case dataInternal = "internal"
        case incoming, value, remainderValue
    }
}

// MARK: - TransferInput
public struct TransferInput: Codable {
    public let type: String
    /// Transfer input data
    public let data: TransferInputData
}

// MARK: - TransferInputData
public struct TransferInputData: Codable {
    /// Transfer input
    public let input: String
    /// Transfer meta data
    public let metadata: TransferMetadata
}

// MARK: - TransferMetadata
public struct TransferMetadata: Codable {
    /// transactionID - transaction id, messageID - message id
    public let transactionID, messageID: String
    /// index - transaction index, amount - transaction amount
    public let index, amount: Int
    /// true for spend
    public let isSpent: Bool
    /// address - transfer address, kind - kind of transfer
    public let address, kind: String

    public enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case messageID = "messageId"
        case index, amount, isSpent, address, kind
    }
}

// MARK: - TransferOutput
public struct TransferOutput: Codable {
    public let type: String
    /// Transfer output data
    public let data: TransferOutputData
}

// MARK: - TransferOutputData
public struct TransferOutputData: Codable {
    /// Transfer output address
    public let address: String
    /// Transfer output amount
    public let amount: Int
    /// this is remainder transfer
    public let remainder: Bool
}

// MARK: - TransferUnlockBlock
public struct TransferUnlockBlock: Codable {
    public let type: String
    /// Transfer unlock block data
    public let data: TransferUnlockBlockData
}

// MARK: - TransferUnlockBlockData
public struct TransferUnlockBlockData: Codable {
    public let type: String
    /// Unlock block transfer data
    public let data: TransferData
}

// MARK: - TransferDataData
public struct TransferData: Codable {
    /// publicKey - list of public keys indecies, signature - list of signatures indicies
    public let publicKey, signature: [Int]

    public enum CodingKeys: String, CodingKey {
        case publicKey = "public_key"
        case signature
    }
}
