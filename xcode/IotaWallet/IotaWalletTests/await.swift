// Copyright 2022 IOTA Stiftung
// SPDX-License-Identifier: Apache-2.0

import Foundation

import XCTest
@testable import IotaWallet

class SwiftAwait: XCTestCase {
    
    struct ManagerOptions: Codable {
        var storagePath: String?
        var clientOptions: ClientOptions?
        var coinType: Int?
        var secretManager: [String:String]?
    }
    
    struct ClientOptions: Codable {
        var nodes: [Node]?
        var localPow: Bool?
        var apiTimeout: WalletDuration?
    }
    
    struct Node: Codable {
        var url: String?
        var auth: String?
        var disabled: Bool?
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let secret_manager = "acoustic trophy damage hint search taste love bicycle foster cradle brown govern endless depend situate athlete pudding blame question genius transfer van random vast"
   
    
    let client_options = """
    {
        "clientOptions": {
            "nodes":[
            {
                "url":"https://localhost",
                "auth":null,
                "disabled":false
            }
            ],
            "localPow":true,
            "apiTimeout":{
                "secs":20,
                "nanos":0
            }
        },
        "coinType": 4219,
        "storagePath": "teststorage",
        "secretManager": {"Mnemonic":"acoustic trophy damage hint search taste love bicycle foster cradle brown govern endless depend situate athlete pudding blame question genius transfer van random vast"}
    }
    """
    
    func defaultManagerOptions() -> ManagerOptions {
         
        let client_options = """
        {
            "nodes":[
                {
                    "url":"https://localhost",
                    "auth":null,
                    "disabled":false
                }
            ],
            "localPow":true,
            "apiTimeout":{
                "secs":20,
                "nanos":0
            }
        }
        """
        /*let client_options = """
        {
            "nodes": ["https://api.testnet.shimmer.network"]
        }
        """*/
        let clientOptions = ClientOptions(
            nodes: [Node(url: "https://localhost", disabled: false)],
            localPow: true,
            apiTimeout: WalletDuration(secs: 20, nanos: 0)
        )
        
        let secretManager = ["Mnemonic" : secret_manager]
        
        return ManagerOptions(storagePath: "teststorage", clientOptions: clientOptions, coinType: 4219, secretManager: secretManager)
    }
    
    @available(iOS 13.0.0, *)
    func testCreateAccount() async throws {
        let json = try JSONEncoder().encode(defaultManagerOptions())
        let options = String(data: json, encoding: .utf8)!
        let wallet = try! IotaWallet.Wallet(managerOptions: options)
        
        let request = "{\"cmd\": \"createAccount\", \"payload\": {\"alias\": null, \"coin_type\": null} }";
        
        let response = try! await wallet.sendMessage(request)
        print("\(response)")
    }
    
    @available(iOS 13.0.0, *)
    func testManagerOptions() async throws {
        let json = try JSONEncoder().encode(defaultManagerOptions())
        let options = String(data: json, encoding: .utf8)!
        let _ = try! IotaWallet.Wallet(managerOptions: options)
    }
    
    @available(iOS 13.0.0, *)
    func testEvents() async throws {
        let json = try JSONEncoder().encode(defaultManagerOptions())
        let options = String(data: json, encoding: .utf8)!
        let wallet = try! IotaWallet.Wallet(managerOptions: options)
        
        let expectation = self.expectation(description: "TestEvents")

        try! wallet.listen([]) { (message: String?, error: Error?) in
            print("Event received: \(message!)")
            expectation.fulfill()
        }
        
        let test_event = "{\"cmd\": \"EmitTestEvent\", \"payload\": { \"TransactionProgress\": \"SelectingInputs\" } }"
        try! await wallet.sendMessage(test_event)
        
        await self.waitForExpectations(timeout: 2) { error in
            if let err = error {
                print("\(err)")
            }
        }
    }

}

