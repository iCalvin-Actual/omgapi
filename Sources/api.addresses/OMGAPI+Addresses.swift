//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Combine
import Foundation

public extension omg_api {
    func addressDirectory() async throws -> [AddressName] {
        let request = GETAddressDirectoryRequest()
        let response = try await apiResponse(for: request)
        return response.directory
    }
    
    func availability(_ address: AddressName) async throws -> Availability {
        let request = GETAddressAvailabilityRequest(for: address)
        let response = try await apiResponse(for: request)
        return Availability(
            address: response.address,
            available: response.available,
            punyCode: response.punyCode
        )
    }
    
    func details(_ address: AddressName) async throws -> Address {
        let request = GETAddressInfoRequest(for: address)
        let response = try await apiResponse(for: request)
        return Address(
            name: response.address,
            registered: response.registration,
            expired: response.expiration.expired,
            verified: response.verification.verified
        )
    }
    
    func expirationDate(_ address: AddressName, credentials: APICredentials) async throws -> Date {
        let request = GETAddressInfoRequest(for: address, authorization: credentials.authKey)
        let response = try await apiResponse(for: request)
        let date = Date(timeIntervalSince1970: Double(response.expiration.unixEpochTime ?? "") ?? 0)
        return date
    }
}
