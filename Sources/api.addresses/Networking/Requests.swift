//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

extension APIRequestConstructor {
    func accountAddressesRequest() -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        return request(with: urlConstructor.accountAddresses(emailAddress: emailAddress))
    }
}

extension APIRequestConstructor {
    func addressInfoRequest(_ address: String) -> URLRequest {
        request(with: urlConstructor.addressInfo(address: address))
    }
}

extension APIRequestConstructor {
    func addressAvailabilityRequest(_ address: String) -> URLRequest {
        request(with: urlConstructor.addressAvailability(address: address))
    }
}

extension APIRequestConstructor {
    func addressExpirationRequest(_ address: String) -> URLRequest {
        request(with: urlConstructor.addressExpiration(address: address))
    }
}


