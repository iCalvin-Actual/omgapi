//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

struct AccountPURL: Response {
    let name: String
    let url: String
    let counter: String?
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}

struct DraftPURL: Encodable {
    let name: String
    let url: String
}

typealias AccountPURLs = [AccountPURL]

extension AccountPURLs: Response { }
