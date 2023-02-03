//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

extension AccountAddress {
    struct Availability: CommonAPIResponse {
        let message: String?
        
        let address: String
        let available: Bool
        
        let availability: String
        
        let punyCode: String?
    }
    
    struct Info: CommonAPIResponse {
        let message: String?
        let address: String
        let owner: String?
        let registration: TimeStamp
        let expiration: Expiration
        let verification: Verification
    }
    
    struct Expiration: CommonAPIResponse {
        let message: String?
        let expired: Bool
        let willExpire: Bool?
        let unixEpochTime: String?
        let relativeTime: String?
    }
    
    struct Verification: CommonAPIResponse {
        let message: String?
        let verified: Bool
    }
}
