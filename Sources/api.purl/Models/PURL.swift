//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

public struct PURL {
    public struct Draft: RequestBody {
        public let name: String
        public let url: String
    }
    
    public let address: AddressName
    public let name: String
    public let url: String
    
    public let counter: Int
    public let listed: Bool
}
