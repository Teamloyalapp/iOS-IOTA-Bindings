import Foundation

public class Output: Codable {
    var type: Int?
    
    init(type: Int? = nil) {
        self.type = type
    }
}
