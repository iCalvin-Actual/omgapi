//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation

public struct Profile {
    public let address: String
    
    public let content: String
    public let theme: String
    
    public let head: String?
    public let css: String?
}

public struct PublicProfile {
    public struct Draft: RequestBody {
        let content: String
    }
    
    public let address: String
    public let content: String?
}

public typealias ProfilePhoto = Data

extension ProfilePhoto: RequestBody { }
