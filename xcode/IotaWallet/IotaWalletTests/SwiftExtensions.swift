// Copyright 2022 IOTA Stiftung
// SPDX-License-Identifier: Apache-2.0

import Foundation
import IotaWallet

extension Wallet {

    convenience init() throws {
        try self.init(managerOptions: nil)
    }
    
}
