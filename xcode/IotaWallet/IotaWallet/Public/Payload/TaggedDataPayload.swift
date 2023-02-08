//
//  TaggedDataPayload.swift
//  IotaWallet
//
//  Created by Andrii Moso on 10.01.2023.
//

import Foundation

/// Tagged payload with data
struct TaggedDataPayload: Payload {
    var type: Int?
    /// Payload tag
    var tag: String?
    /// Payload data
    var data: String?
}
