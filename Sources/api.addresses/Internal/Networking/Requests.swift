//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class GETAddressDirectoryRequest: APIRequest<None, AddressDirectoryResponse> {
    init() {
        super.init(path: AddressPath.directory)
    }
}

class GETAddressAvailabilityRequest: APIRequest<None, AddressAvailabilityResponse> {
    init(for address: String) {
        super.init(path: AddressPath.availability(address))
    }
}

class GETAddressInfoRequest: APIRequest<None, AddressInfoResponse> {
    init(for address: String, authorization: String? = nil) {
        super.init(
            authorization: authorization,
            path: AddressPath.info(address)
        )
    }
}

class GETAddressExpirationRequest: APIRequest<None, AddressInfoResponse.Expiration> {
    init(for address: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AddressPath.expiration(address)
        )
    }
}
