//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation

public struct PublicLog {
    public let statuses: [Status]
}

public struct StatusLog {
    public struct Bio {
        public struct Draft: RequestBody {
            let content: String
            
            public init(content: String) {
                self.content = content
            }
        }
        public let content: String
    }
    public let address: AddressName
    public let bio: Bio
    public let statuses: [Status]
}
