//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

struct Now: Decodable {
    let content: String
    let updated: String
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}

