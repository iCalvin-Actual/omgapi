//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

struct PURL {
    struct Draft: RequestBody {
        let name: String
        let url: String
    }
    
    let address: AddressName
    let name: String
    let url: String
    
    let counter: Int
    let listed: Bool
}
