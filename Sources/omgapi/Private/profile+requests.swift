//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `ProfileResponseModel`.
struct ProfileResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    
    /// Raw text or HTML content.
    let content: String?
    /// Rendered HTML version of the content.
    let html: String?
    
    /// Theme or profile type.
    let type: String?
    /// Theme name or identifier.
    let theme: String?
    
    /// Custom stylesheet applied.
    let css: String?
    /// Injected <head> HTML content.
    let head: String?
    
    /// Whether the item is verified.
    let verified: Int?
    
    /// Profile picture URL or identifier.
    let pfp: String?
    
    /// Raw profile metadata as string.
    let metadata: String?
}

// MARK: Requests

/// Fetches data for `GETPublicProfile`.
class GETPublicProfile: APIRequest<None, String> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, with authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PublicPath.profile(address)
        )
    }
}

/// Fetches data for `GETProfile`.
class GETProfile: APIRequest<None, ProfileResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, with authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: ProfilePath.profile(address)
        )
    }
}

/// Creates or updates data for `SETProfile`.
class SETProfile: APIRequest<Profile.Draft, BasicResponse> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - credential: Description for `credential`.
    init(_ draft: Profile.Draft, from address: AddressName, with credential: APICredential) {
        super.init(
            authorization: credential,
            method: .POST,
            path: ProfilePath.profile(address),
            body: draft
        )
    }
}

class GETAvatar: APIRequest<None, Data> {
    init(_ address: AddressName) {
        super.init(path: AddressPath.avatar(address))
    }
}
