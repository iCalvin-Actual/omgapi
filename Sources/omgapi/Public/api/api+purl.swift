//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Retrieves all PURLs associated with the given address.
    /// - Parameters:
    ///   - address: The omg.lol address to query.
    ///   - credential: Optional API credential for authentication.
    /// - Returns: An array of `PURL` objects.
    func purls(from address: AddressName, credential: APICredential? = nil) async throws -> PURLs {
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
    
    /// Retrieves a specific PURL by name.
    /// - Parameters:
    ///   - name: The name of the PURL.
    ///   - address: The omg.lol address that owns the PURL.
    ///   - credential: Optional API credential for authentication.
    /// - Returns: The `PURL` object.
    func purl(_ name: String, for address: AddressName, credential: APICredential?) async throws -> PURL {
        let request = GETAddressPURL(
            name,
            address: address,
            authorization: credential
        )
        do {
            let response = try await apiResponse(for: request)
            return PURL(
                address: address,
                name: response.purl.name,
                url: response.purl.url,
                counter: response.purl.counter ?? 0,
                listed: true
            )
        } catch {
            throw error
        }
    }
    
    /// Retrieves the raw content associated with a PURL.
    /// - Parameters:
    ///   - name: The name of the PURL.
    ///   - address: The omg.lol address that owns the PURL.
    ///   - credential: Optional API credential.
    /// - Returns: A `String` containing the content, or `nil` if decoding fails.
    func purlContent(_ name: String, for address: AddressName, credential: APICredential?) async throws -> String? {
        let request = GETAddressPURLContent(purl: name, address: address, authorization: credential)
        do {
            let response = try await apiResponse(for: request, priorityDecoding: { String(data: $0, encoding: .utf8) })
            return response
        } catch {
            throw error
        }
    }
    
    /// Deletes a PURL from the specified address.
    /// - Parameters:
    ///   - name: The PURL name.
    ///   - address: The omg.lol address to delete from.
    ///   - credential: API credential with deletion rights.
    func deletePURL(_ name: String, for address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressPURLContent(purl: name, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Creates or updates a PURL for the given address.
    /// - Parameters:
    ///   - draft: The draft data including name and URL.
    ///   - address: The omg.lol address to associate with the PURL.
    ///   - credential: API credential for write access.
    /// - Returns: The created or updated `PURL`, if successful.
    func savePURL(_ draft: PURL.Draft, to address: AddressName, credential: APICredential) async throws -> PURL? {
        let request = SETAddressPURL(draft, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await purl(draft.name, for: address, credential: credential)
    }
}
