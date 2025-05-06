//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Retrieves the public Now Garden, a directory of all listed Now pages.
    /// - Returns: An array of `NowGardenEntry` values.
    func nowGarden() async throws -> NowGarden {
        let request = GETNowGardenRequest()
        let response = try await apiResponse(for: request)
        return response.garden
            .map { Now.Reference(
                address: $0.address,
                url: $0.url,
                updated: $0.updated.date
            )}
    }
    
    /// Retrieves the raw HTML content of a ``Now`` page for a specific address.
    /// - Parameter address: The omg.lol ``AddressName`` to retrieve.
    /// - Returns: A ``Now/Page`` object containing HTML content.
    func nowWebpage(for address: AddressName) async throws -> Now.Page {
        let request = GETAddressNowPageRequest(address)
        let response = try await apiResponse(for: request) { data in
            String(data: data, encoding: .utf8)
        }
        return Now.Page(
            address: address,
            content: response
        )
    }
    
    /// Fetches the ``Now`` entry content for an address.
    /// - Parameters:
    ///   - address: The omg.lol address to query.
    ///   - credential: Optional API credential for authenticated access.
    /// - Returns: A `Now` model with metadata.
    func now(for address: AddressName, credential: APICredential? = nil) async throws -> Now {
        let request = GETAddressNowRequest(for: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return Now(
            address: address,
            content: response.now.content,
            listed: response.now.listed.boolValue,
            updated: response.now.updatedAt
        )
    }
    
    /// Saves or updates a ``Now`` entry for the given address.
    /// 
    /// - Parameters:
    ///   - draft: The drafted /now content to post
    ///   - address: The omg.lol address to update.
    ///   - credential: API credential with write access.
    /// - Returns: The updated `Now` entry.
    func saveNow(_ draft: Now.Draft, for address: AddressName, credential: APICredential) async throws -> Now? {
        let request = SETAddressNowRequest(for: address, draft: draft, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await now(for: address, credential: credential)
    }
}
