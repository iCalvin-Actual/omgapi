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
    func pasteBin(for address: AddressName, credential: APICredentials?) async throws -> PasteBin {
        let request = GETAddressPasteBin(address, authorization: credential)
        let response = try await apiResponse(for: request)
        return response.pastebin.map { paste in
            Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.listed.boolValue
            )
        }
    }
    
    func paste(_ title: String, from address: AddressName, credential: APICredentials?) async throws -> Paste {
        let request = GETAddressPaste(title, from: address)
        let response = try await apiResponse(for: request)
        let paste = response.paste
        return Paste(
            title: paste.title,
            author: address,
            content: paste.content,
            modifiedOn: paste.updated,
            listed: paste.listed.boolValue
        )
    }
    
    func save(_ draft: Paste.Draft, to address: AddressName, credential: APICredentials) async throws -> Paste {
        let request = SETAddressPaste(
            draft: draft,
            from: address,
            authorization: credential
        )
        let _ = try await apiResponse(for: request)
        return try await paste(draft.title, from: address, credential: credential)
    }
    
    func delete(_ title: String, from address: AddressName, credential: APICredentials) async throws {
        let request = DELETEAddressPaste(
            title,
            from: address,
            authorization: credential
        )
        let _ = try await apiResponse(for: request)
    }
}
