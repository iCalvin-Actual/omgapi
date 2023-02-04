//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

public protocol APIPath {
    var string: String  { get }
    var url: URL        { get }
}

public extension APIPath {
    var url: URL { URL(string: string, relativeTo: CommonPath.api.url)! }
}

public enum CommonPath: APIPath {
    private static let baseAPIString = "https://api.omg.lol"
    
    case api
    
    public var string: String {
        switch self {
        case .api:
            return Self.baseAPIString
        }
    }
    
    public var url: URL {
        URL(string: string)!
    }
}



/// Should be extended by the various modules with the URL routes needed
public struct APIURLConstructor {
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
    public func replacingEntry(_ entry: String, in path: String) -> String {
        path.replacingOccurrences(of: "{entry}", with: entry)
    }
    public func replacingStatus(_ status: String, in path: String) -> String {
        path.replacingOccurrences(of: "{status}", with: status)
    }
}
