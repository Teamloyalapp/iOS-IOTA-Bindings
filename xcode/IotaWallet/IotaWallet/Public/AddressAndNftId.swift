//
//  AddressAndNftId.swift
//  IotaWallet
//
//  Created by Andrii Moso on 03.01.2023.
//

import Foundation

class AddressAndNftId: Codable {
    
    /// Bech32 encoded address
    var address: String?
    /// Nft id
    var nftId: NftId?
    
    init(address: String? = nil, nftId: NftId? = nil) {
        self.address = address
        self.nftId = nftId
    }
}

class NftId: Codable {
    /// Nft id string
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
}
