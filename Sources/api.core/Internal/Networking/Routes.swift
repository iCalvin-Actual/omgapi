//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

public enum CommonPath: APIPath {
    private static let baseAPIString = "https://api.omg.lol"
    private static let serviceInfo = "service/info/"
    
    case api
    case service
    
    public var string: String {
        switch self {
        case .api:
            return Self.baseAPIString
        case .service:
            return Self.serviceInfo
        }
    }
    
    public var url: URL {
        switch self {
        case .api:
            return URL(string: string)!
        default:
            return URL(string: string, relativeTo: Self.api.url)!
        }
    }
}
