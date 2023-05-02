import Foundation

public protocol AccountMethod: Codable {
    func hasData() -> Bool
}

public extension AccountMethod {
    func hasData() -> Bool {
        return !(dictionary?.isEmpty ?? true)
    }
}
