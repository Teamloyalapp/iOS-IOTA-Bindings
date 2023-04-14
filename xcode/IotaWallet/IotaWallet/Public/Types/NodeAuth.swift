import Foundation

struct NodeAuth: Codable {
    /// JWT.
    var jwt: String
    /// Username and password.
    var basic_auth_name_pwd: [String : String]
}
