//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

public struct Now {
    public struct Draft: RequestBody {
        public let content: String
        public let listed: Bool
        
        init(content: String, listed: Bool) {
            self.content = content
            self.listed = listed
        }
    }
    
    public let address: AddressName
    public let content: String
    public let listed: Bool
    
    public let updated: Date
}

