//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation

struct Profile {
    let address: String
    
    let content: String
    let theme: String
    
    let head: String?
    let css: String?
}

struct PublicProfile {
    struct Draft: RequestBody {
        let content: String
    }
    
    let address: String
    let content: String?
}

typealias ProfilePhoto = Data
extension ProfilePhoto: RequestBody { }
