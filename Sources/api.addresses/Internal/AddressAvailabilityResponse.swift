//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

struct AddressAvailabilityResponse: CommonAPIResponse {
    let message: String?
    
    let address: String
    let available: Bool
    
    let availability: String
    
    let punyCode: String?
}

