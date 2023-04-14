import Foundation

public class AbstractId: Hashable, Codable {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    public static func == (lhs: AbstractId, rhs: AbstractId) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
