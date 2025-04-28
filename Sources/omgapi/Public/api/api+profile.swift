//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Retrieves the public profile HTML content for a specific ``AddressName``.
    ///
    /// - Parameter address: The omg.lol address to fetch.
    /// - Returns: A `Profile.Page` object containing the page html content
    func publicProfile(_ address: AddressName) async throws -> Profile.Page {
        let request = GETPublicProfile(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            String(data: data, encoding: .utf8)
        })
        return Profile.Page(
            address: address,
            content: response
        )
    }
    
    /// Retrieves the profile content and metadata for a given ``AddressName``.
    /// 
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - credential: API credential with read access.
    /// - Returns: A `Profile` object.
    func profile(_ address: AddressName, with credential: APICredential) async throws -> Profile {
        let request = GETProfile(address, with: credential)
        let response = try await apiResponse(for: request)
        return Profile(
            address: address,
            content: response.content ?? "",
            theme: response.theme ?? "",
            head: response.head,
            css: response.css
        )
    }
    
    /// Saves or updates the profile content for an ``AddressName``.
    ///
    /// - Parameters:
    ///   - content: The new profile content (usually markdown).
    ///   - address: The omg.lol address to update.
    ///   - credential: API credential with write access.
    /// - Returns: The updated `Profile` object.
    func saveProfile(_ content: String, for address: AddressName, with credential: APICredential) async throws -> Profile {
        let request = SETProfile(.init(content: content, publish: true), from: address, with: credential)
        let _ = try await apiResponse(for: request)
        return try await profile(address, with: credential)
    }
    
    /// Retrieves detailed metadata about an omg.lol ``AddressName``, includingverification and expiration.
    ///
    /// - Parameter address: The omg.lol ``AddressName`` to query.
    /// - Returns: An ``AddressInfo`` object with expanded detail.
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
