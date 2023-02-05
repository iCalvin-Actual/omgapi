//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

struct Now {
    struct Draft: RequestBody {
        let content: String
        let listed: Bool
    }
    
    let address: AddressName
    let content: String
    let listed: Bool
    
    let updated: Date
}

