//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation

struct Status {
    struct Draft: RequestBody {
        let id: String?
        let content: String
        let emoji: String?
        let externalUrl: String?
        
        init(id: String? = nil, content: String, emoji: String? = nil, externalUrl: String? = nil) {
            self.id = id
            self.content = content
            self.emoji = emoji
            self.externalUrl = externalUrl
        }
    }
    
    let id: String
    let address: AddressName
    let created: Date
    
    let content: String
    let emoji: String?
    let externalURL: URL?
}
