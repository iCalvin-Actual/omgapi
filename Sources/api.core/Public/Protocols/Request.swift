//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

public protocol RequestBody: Encodable {
}

public struct None: RequestBody, Response {
    public static let instance: None = { None() }()
    
    private init() { }
}
