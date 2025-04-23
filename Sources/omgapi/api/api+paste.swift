//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Retrieves the full pastebin listing for a specific omg.lol address.
    /// - Parameters:
    ///   - address: The omg.lol address to query.
    ///   - credential: Optional API credential for private pastes.
    /// - Returns: A `PasteBin` array.
    func pasteBin(for address: AddressName, credential: APICredential? = nil) async throws -> PasteBin {
        let request = GETAddressPasteBin(address, authorization: credential)
        let response = try await apiResponse(for: request)
        return response.pastebin.map { paste in
            Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.isPublic
            )
        }
    }
    
    /// Retrieves a single paste by title from an address's pastebin.
    /// - Parameters:
    ///   - title: The title of the paste.
    ///   - address: The omg.lol address to fetch from.
    ///   - credential: Optional API credential for private access.
    /// - Returns: A `Paste` if found, or `nil`.
    func paste(_ title: String, from address: AddressName, credential: APICredential?) async throws -> Paste? {
        let request = GETAddressPaste(title, from: address)
        do {
            let response = try await apiResponse(for: request)
            let paste = response.paste
            return Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.isPublic
            )
        } catch let error as APIError {
            switch error {
            case .notFound:
                return nil
            default:
                throw error
            }
        }
    }
    
    /// Deletes a paste from the given address.
    /// - Parameters:
    ///   - name: The paste name or title.
    ///   - address: The omg.lol address to remove from.
    ///   - credential: The API credential with write permissions.
    func deletePaste(_ name: String, for address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressPasteContent(paste: name, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Saves a new or updated paste for an address.
    /// - Parameters:
    ///   - draft: The draft content and metadata.
    ///   - address: The omg.lol address to save to.
    ///   - credential: The API credential for write access.
    /// - Returns: The updated or newly saved `Paste`, if successful.
    func savePaste(_ draft: Paste.Draft, to address: AddressName, credential: APICredential) async throws -> Paste? {
        let request = SETAddressPaste(draft, to: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return try await paste(response.title, from: address, credential: credential)
    }
}
