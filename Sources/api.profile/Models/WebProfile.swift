//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation

public struct Profile {
    let address: String
    
    let content: String
    let theme: String
    
    let head: String?
    let css: String?
}

public struct PublicProfile {
    public struct Draft: RequestBody {
        let content: String
    }
    
    let address: String
    let content: String?
}

public typealias ProfilePhoto = Data

extension ProfilePhoto: RequestBody { }
