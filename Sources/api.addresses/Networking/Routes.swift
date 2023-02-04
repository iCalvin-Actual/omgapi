//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

extension APIURLConstructor {
    private var addresses: String           { "account/{email}/addresses/" }
    private var addressAvailability: String { "address/{address}/availability/" }
    private var addressExpiration: String   { "address/{address}/expiration/" }
    private var addressInfo: String         { "address/{address}/info/"}
    
    public func accountAddresses(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: addresses), relativeTo: baseURL)!
    }
    
    public func addressAvailability(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressAvailability), relativeTo: baseURL)!
    }
    
    public func addressExpiration(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressExpiration), relativeTo: baseURL)!
    }
    
    public func addressInfo(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressInfo), relativeTo: baseURL)!
    }
}
