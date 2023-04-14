import Foundation

struct LedgerNanoStatus: Codable {
    /// Ledger is available and ready to be used.
    var connected: Bool
    /// Ledger is connected and locked.
    var locked: Bool
    /// Ledger blind signing enabled
    var blindSigningEnabled: Bool
    /// Ledger opened app.
    var app: LedgerApp?
    /// Ledger device
    var device: LedgerDeviceType?
    /// Buffer size on device
    var bufferSize: Int
}

struct LedgerApp: Codable {
    /// Opened app name.
    var name: String
    /// Opened app version.
    var version: String
}

enum LedgerDeviceType: Codable {
    /// Device Type Nano S
    case LedgerNanoS
    /// Device Type Nano X
    case LedgerNanoX
    /// Device Type Nano S Plus
    case LedgerNanoSPlus
}
