//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

public protocol Path {
    var string: String  { get }
    var baseUrl: URL?   { get }
    var url: URL        { get }
}

public protocol WebPath: Path {
}

extension WebPath {
    public var baseUrl: URL? {
        nil
    }
}

public protocol APIPath: Path {
}

extension APIPath {
    public var baseUrl: URL? {
        CommonPath.api.url
    }
}

public extension Path {
    var url: URL { URL(string: string, relativeTo: baseUrl)! }
}
