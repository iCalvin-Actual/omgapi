//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Fetches the full public omg.lol address directory.
    /// - Returns: An array of all visible omg.lol addresses.
    func addressDirectory() async throws -> AddressDirectory {
        let request = GETAddressDirectoryRequest()
        let response = try await apiResponse(for: request)
        return response.directory
    }
    
    /// Checks whether a specific omg.lol address is available for registration.
    ///
    /// - Parameter address: The desired omg.lol address.
    /// - Returns: Availability info including punycode, if applicable.
    func availability(_ address: AddressName) async throws -> AddressInfo.Availability {
        let request = GETAddressAvailabilityRequest(for: address)
        let response = try await apiResponse(for: request)
        return AddressInfo.Availability(
            address: response.address,
            available: response.available,
            punyCode: response.punyCode
        )
    }
    
    /// Retrieves detailed metadata about an omg.lol address (verification, expiration, etc.).
    ///
    /// - Parameter address: The omg.lol address to query.
    /// - Returns: An `Address` object with expanded detail.
    func details(_ address: AddressName) async throws -> AddressInfo {
        let request = GETAddressInfoRequest(for: address)
        let response = try await apiResponse(for: request)
        return AddressInfo(
            name: response.address,
            registered: response.registration.date,
            expired: response.expiration.expired,
            verified: response.verification.verified
        )
    }
}
