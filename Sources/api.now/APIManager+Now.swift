//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

// let response = try await apiResponse(for: request)

public extension omg_api {
    func nowGarden() async throws -> NowGarden {
        let request = GETNowGardenRequest()
        let response = try await apiResponse(for: request)
        return response.garden
            .map { NowGardenEntry(
                address: $0.address,
                url: $0.url,
                updated: $0.updated
            )}
    }
    
    func now(for address: AddressName, credential: APICredentials? = nil) async throws -> Now {
        let request = GETAddressNowRequest(for: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return Now(
            address: address,
            content: response.now.content,
            listed: response.now.listed.boolValue,
            updated: response.now.updatedAt
        )
    }
    
    func save(draft: Now.Draft, to address: AddressName, with credentials: APICredentials) async throws-> Now {
        let request = SETAddressNowRequest(draft, for: address, authorization: credentials)
        let _ = try await apiResponse(for: request)
        return try await now(for: address)
    }
}
