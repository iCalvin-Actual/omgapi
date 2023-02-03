//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

struct AddressProfileResponseModel: CommonAPIResponse {
    let message: String?
    
    let content: String?
    let html: String?
    
    let type: String?
    let theme: String?
    
    let css: String?
    let head: String?
    
    let verified: Bool?
    
    let pfp: String?
    
    let metadata: String?
}
