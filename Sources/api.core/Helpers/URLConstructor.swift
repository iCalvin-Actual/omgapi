//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

/// Should be extended by the various modules with the URL routes needed
public struct URLConstructor {
    private let baseAPIString: String = "https://api.omg.lol"
    
    public var baseURL: URL { URL(string: baseAPIString)! }
    
    public func replacingEmail(_ address: String, in path: String) -> String {
        path.replacingOccurrences(of: "{email}", with: address)
    }
    public func replacingAddress(_ address: String, in path: String) -> String {
        path.replacingOccurrences(of: "{address}", with: address)
    }
    public func replacingPurl(_ purl: String, in path: String) -> String {
        path.replacingOccurrences(of: "{purl}", with: purl)
    }
    public func replacingPaste(_ paste: String, in path: String) -> String {
        path.replacingOccurrences(of: "{paste}", with: paste)
    }
}
