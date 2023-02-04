//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

struct AddressStatus: Response {
    let id: String
    let address: String
    let created: String
    
    let content: String
    let emoji: String?
    let externalUrl: String?
}

struct DraftStatus: Encodable {
    let content: String
    let emoji: String?
    let externalUrl: String?
}
