//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import Foundation

extension AccountAddress {
    struct Info {
        let message: String?
        let address: String
        let owner: String?
        let registration: TimeStamp
        let expiration: Expiration
        let verification: Verification
    }
    
    struct Expiration {
        let message: String?
        let expired: Bool
        let willExpire: Bool?
        let unixEpochTime: Int?
        let relativeTime: String?
    }
    
    struct Verification {
        let message: String?
        let verified: Bool
    }
}
