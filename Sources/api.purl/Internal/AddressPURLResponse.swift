//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import api_core
import Foundation


struct AddressPURLResponse: Response {
    let name: String
    let url: String
    let counter: Int?
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}


typealias AddressPURLsResponse = [AddressPURLResponse]

extension AddressPURLsResponse: Response { }
