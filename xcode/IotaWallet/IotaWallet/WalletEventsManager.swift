//
//  WalletEventsManager.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

public struct ManagerOptions: Codable {

    var storagePath: String?
    var clientOptions: ClientOption?
    var secretManager: SecretManager?
    var coinType: Int?
    
    enum CodingKeys: String, CodingKey {
        case storagePath
        case clientOptions
        case secretManager
        case coinType
    }
    
    public init(storagePath: String? = nil, clientOptions: ClientOption? = nil, secretManager: SecretManager? = nil, coinType: Int? = nil) {
        self.storagePath = storagePath
        self.clientOptions = clientOptions
        self.secretManager = secretManager
        self.coinType = coinType
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storagePath = try values.decode(String?.self, forKey: .storagePath)
        clientOptions = try values.decode(ClientOption?.self, forKey: .clientOptions)
        coinType = try values.decode(Int?.self, forKey: .coinType)
        if let manager = try values.decode(StrongholdSecretManager?.self, forKey: .secretManager) {
            self.secretManager = manager
        } else if let manager = try values.decode(MnemonicSecretManager?.self, forKey: .secretManager) {
            self.secretManager = manager
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(storagePath, forKey: .storagePath)
        try container.encode(clientOptions, forKey: .clientOptions)
        try container.encode(coinType, forKey: .coinType)
        if let manager = secretManager as? StrongholdSecretManager {
            try container.encode(manager, forKey: .secretManager)
        } else if let manager = secretManager as? MnemonicSecretManager {
            try container.encode(manager, forKey: .secretManager)
        }
    }
    
}

public struct IOTANode: Codable {
    let url: String
    let auth: String?
    let disabled: Bool
}

public struct ClientOption: Codable {
    let localPow: Bool
    let apiTimeout: WalletDuration
    let nodes: [IOTANode]
    
    var json: String {
        let json = try! JSONEncoder().encode(self)
        return String(data: json, encoding: .utf8)!
    }
}

func managerOptions(nodeUrl: String = "https://localhost", mnemonicSecretManager: MnemonicSecretManager, storagePath: String, coinType: Int, apiTimeoutInSeconds: Int = 20) -> ManagerOptions {
    let secretManager = mnemonicSecretManager
    let clientOptions = ClientOption(
        localPow: true,
        apiTimeout: WalletDuration(secs: apiTimeoutInSeconds, nanos: 0),
        nodes: [IOTANode(url: nodeUrl, auth: nil, disabled: false)]
    )
    
    return ManagerOptions(storagePath: storagePath, clientOptions: clientOptions, secretManager: secretManager, coinType: coinType)
}

func managerOptions(nodeUrl: String = "https://localhost", strongholdSecretManager: StrongholdSecretManager ,storagePath: String, coinType: Int, apiTimeoutInSeconds: Int = 20) -> ManagerOptions {
    let secretManager = strongholdSecretManager
    let clientOptions = ClientOption(
        localPow: true,
        apiTimeout: WalletDuration(secs: apiTimeoutInSeconds,nanos: 0),
        nodes: [IOTANode(url: nodeUrl, auth: nil, disabled: false)]
    )
    
    return ManagerOptions(storagePath: storagePath, clientOptions: clientOptions, secretManager: secretManager, coinType: coinType)
}

class WalletEventsManager {
    fileprivate(set) var isRunning: Bool = false
    fileprivate var hasBeenStarted = false
    fileprivate(set) var storagePath: String
    fileprivate(set) var identifier: String
    fileprivate(set) var coinType: Int
    fileprivate(set) var wallet: Wallet?
    
    init(storagePath: String = URL.libraryDirectory.path, secretManager: SecretManager, coinType: Int, nodeUrl: String) {
        self.storagePath = storagePath
        self.coinType = coinType
        identifier = WalletEventsManager.generateId(path: storagePath)
        let options: String
        switch(secretManager) {
        case let mnemonicSecretManager as MnemonicSecretManager:
            let json = try! JSONEncoder().encode(managerOptions(nodeUrl: nodeUrl, mnemonicSecretManager: mnemonicSecretManager, storagePath: storagePath, coinType: coinType))
            options = String(data: json, encoding: .utf8)!
        case let strongholdSecretManager as StrongholdSecretManager:
            let json = try! JSONEncoder().encode(managerOptions(nodeUrl: nodeUrl, strongholdSecretManager: strongholdSecretManager, storagePath: storagePath, coinType: coinType))
            options = String(data: json, encoding: .utf8)!
        default:
            options = ""
            fatalError("Unknown secret manager")
        }
        do {
            wallet = try Wallet(managerOptions: options)
        } catch {
            print(error)
        }
        if wallet != nil {
            isRunning = true
        }
    }
    
    fileprivate func setup() {
        identifier = WalletEventsManager.generateId(path: storagePath)
    }
    
    static func generateId(path: String) -> String { String("\(path.hashValue)".suffix(8)) }
    
    func stop() {
        guard isRunning else { return }
        // guard let wallet = wallet else { return }
        // wallet.dealloc()
        isRunning = false
    }
    
    func sendCommand(id: String, cmd: String, payload: Any?, callback: @escaping ((String?, Error?) -> Void)) {
        guard isRunning else {
            callback(nil, IOTAError(message: "wallet error"))
            return
        }
        let currentId = WalletUtils.randomId(from: id)+identifier
        guard let json = ["actorId": identifier, "id": currentId, "cmd": cmd, "payload": payload].json else {
            callback(nil, IOTAError(message: "serialization-error")) //("{\"error\": \"serialization-error\"}")
            return
        }
        wallet?.sendMessage(json, completion: callback)
    }
}
