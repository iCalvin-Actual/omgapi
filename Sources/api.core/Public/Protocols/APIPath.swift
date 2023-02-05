//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

public protocol APIPath {
    var string: String  { get }
    var url: URL        { get }
}

public extension APIPath {
    var url: URL { URL(string: string, relativeTo: CommonPath.api.url)! }
}
