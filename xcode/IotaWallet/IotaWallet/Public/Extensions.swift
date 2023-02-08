//
//  Extensions.swift
//  IotaWallet
//
//  Created by Andrii Moso on 14.01.2023.
//

import Foundation

extension URL {
    /// Get library folder
    static var libraryDirectory: URL {
        let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension String {
    /// Get unsafe pointer for string
    var pointerValue: UnsafePointer<CChar>? {
        NSString(string: self).utf8String
    }
    
    /// Get unsafe mutable pointer for string
    var mutablePointerValue: UnsafeMutablePointer<CChar> {
        return self.withCString { s in
            UnsafeMutablePointer(mutating: s)
        }
    }
    
    /// Decode json response to WalletGenericResponse
    var decodedResponse: WalletGenericResponse? {
        WalletGenericResponse.decode(self)
    }
}

extension UnsafePointer where Pointee == CChar {
    /// Get string value given by unsafe pointer
    var stringValue: String? {
        return String(cString: self)
    }
}

extension Dictionary {
    /// get json from Dictionary
    var json: String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}

extension Decodable {
    /// decode json string to object
    static func decode(_ from: String?) -> Self? {
        guard let from = from else { return nil }
        let data = Data(from.utf8)
        do {
            return try JSONDecoder().decode(self.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

extension URL {
    /// Return query parameters dictionary from the url
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    /// Iota wallet folder
    public static var iotaDir: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let iotaDir = docs.appendingPathComponent("iota")
        return iotaDir
    }
    
    /// Iota logs folder
    public static var iotaLogsDir: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let iotaDir = docs.appendingPathComponent("iota-logs")
        return iotaDir
    }
}
