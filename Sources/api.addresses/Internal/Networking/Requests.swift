//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class GETAddressDirectoryRequest: APIRequest<Empty, AddressDirectoryResponse> {
    init() {
        super.init(path: AddressPath.directory)
    }
}

class GETAddressAvailabilityRequest: APIRequest<Empty, AddressAvailabilityResponse> {
    init(for address: String) {
        super.init(path: AddressPath.availability(address))
    }
}

class GETAddressInfoRequest: APIRequest<Empty, AddressInfoResponse> {
    init(for address: String, authorization: String? = nil) {
        super.init(
            authorization: authorization,
            path: AddressPath.info(address)
        )
    }
}

class GETAddressExpirationRequest: APIRequest<Empty, AddressInfoResponse.Expiration> {
    init(for address: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AddressPath.expiration(address)
        )
    }
}
