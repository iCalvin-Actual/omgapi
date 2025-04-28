//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Returns the complete set of omg.lol Addresses. For more info about working with these Addresses  see ``AddressName``.
    ///
    /// - Returns: An array of all visible omg.lol addresses.
    func directory() async throws -> Directory {
        let request = GETAddressDirectoryRequest()
        let response = try await apiResponse(for: request)
        return response.directory
    }
    
    /// Checks whether a specific omg.lol ``AddressName`` is available for registration.
    ///
    /// - Parameter address: The desired omg.lol address.
    /// - Returns: Availability info including punycode, if applicable.
    func availability(_ address: AddressName) async throws -> AddressAvailability {
        let request = GETAddressAvailabilityRequest(for: address)
        let response = try await apiResponse(for: request)
        return AddressAvailability(
            address: response.address,
            available: response.available,
            punyCode: response.punyCode
        )
    }
    
    /// Fetches avatar image data for a given ``AddressName``
    ///
    /// Assumes a valid AddressName on the omg.lol platform.
    /// - Parameter address: The desired omg.lol address
    /// - Returns: Image data for the Address' chosen avatar
    func avatar(_ address: AddressName) async throws -> Data {
        let request = GETAvatar(address)
        return try await apiResponse(for: request)
    }
}
