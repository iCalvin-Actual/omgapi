//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

public extension omg_api {
    func purls(from address: AddressName, credential: APICredentials?) async throws -> [PURL] {
        let request = GETAddressPURLs(address)
        let response = try await apiResponse(for: request)
        return response.purls.map({ purl in
            PURL(
                address: address,
                name: purl.name,
                url: purl.url,
                counter: purl.counter ?? 0,
                listed: purl.isPublic
            )
        })
    }
    
    func purl(_ name: String, for address: AddressName, credential: APICredentials?) async throws -> PURL {
        let request = GETAddressPURL(
            name,
            address: address,
            authorization: credential
        )
        let response = try await apiResponse(for: request)
        return PURL(
            address: address,
            name: response.purl.name,
            url: response.purl.url,
            counter: response.purl.counter ?? 0,
            listed: response.purl.isPublic
        )
    }
    
    func save(_ draft: PURL.Draft, for address: AddressName, credential: APICredentials) async throws -> PURL {
        let request = SETAddressPURL(draft, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await purl(draft.name, for: address, credential: credential)
    }
        
        
    func delete(_ title: String, from address: AddressName, credential: APICredentials) async throws {
        let request = DELETEAddressPURL(title, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
}
