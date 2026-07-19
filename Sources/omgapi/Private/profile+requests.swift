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
///
/// Never attaches a credential: profile pages live on the public web host and
/// can be configured to redirect off-site, and `URLSession` re-sends headers on
/// redirect, so an `Authorization` header here could leak the bearer token.
/// - Parameter address: Description for `address`.
func GETPublicProfile(_ address: AddressName) -> APIRequest<None, String> {
    .init(
        path: PublicPath.profile(address)
    )
}

/// Fetches data for `GETProfile`.
/// - Parameters:
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETProfile(_ address: AddressName, with authorization: APICredential) -> APIRequest<None, ProfileResponseModel> {
    .init(
        authorization: authorization,
        path: ProfilePath.profile(address)
    )
}

/// Creates or updates data for `SETProfile`.
/// - Parameters:
///   - draft: Description for `draft`.
///   - address: Description for `address`.
///   - credential: Description for `credential`.
func SETProfile(_ draft: Profile.Draft, from address: AddressName, with credential: APICredential) -> APIRequest<Profile.Draft, BasicResponse> {
    .init(
        authorization: credential,
        method: .POST,
        path: ProfilePath.profile(address),
        body: draft
    )
}

func GETAvatar(_ address: AddressName) -> APIRequest<None, Data> {
    .init(path: AddressPath.avatar(address))
}
