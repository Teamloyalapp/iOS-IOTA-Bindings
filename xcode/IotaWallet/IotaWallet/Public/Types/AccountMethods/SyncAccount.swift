import Foundation

public struct SyncAccount: AccountMethod, Codable {
    public func hasData() -> Bool {
        return true
    }
}
