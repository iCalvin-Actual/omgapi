//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

struct AddressInfoResponse: CommonAPIResponse {
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
    let message: String?
    let address: String
    let owner: String?
    let registration: TimeStamp
    let expiration: Expiration
    let verification: Verification
}
