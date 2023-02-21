//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

struct AddressNowResponseModel: CommonAPIResponse {
    struct Now: Response {
        let content: String
        let updated: Int
        let listed: Int
        
        var updatedAt: Date {
            let double = Double(updated)
            return Date(timeIntervalSince1970: double)
        }
    }
    let message: String?
    let now: Now
}
