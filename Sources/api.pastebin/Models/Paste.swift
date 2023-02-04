//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

struct Paste: Response {
    let title: String
    let content: String
    let modifiedOn: String?
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}

struct DraftPaste: Encodable {
    let title: String
    let content: String
}
