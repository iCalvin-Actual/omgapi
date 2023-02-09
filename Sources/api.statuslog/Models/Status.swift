//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation

public struct Status {
    public struct Draft: RequestBody {
        public let id: String?
        public let content: String
        public let emoji: String?
        public let externalUrl: String?
        
        public init(id: String? = nil, content: String, emoji: String? = nil, externalUrl: String? = nil) {
            self.id = id
            self.content = content
            self.emoji = emoji
            self.externalUrl = externalUrl
        }
    }
    
    public let id: String
    public let address: AddressName
    public let created: Date
    
    public let content: String
    public let emoji: String?
    public let externalURL: URL?
}
