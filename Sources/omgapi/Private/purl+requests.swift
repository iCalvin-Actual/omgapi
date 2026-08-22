//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `AddressPURLResponse`.
struct AddressPURLResponseModel: Response {
    /// Display name or username.
    let name: String
    /// Associated URL.
    let url: String
    /// Access or hit count.
    let counter: Int?
    /// Visibility flag or status.
    let listed: String?

    var isPublic: Bool {
        listed.boolValue
    }
}

/// Response model for `AddressPURLItemResponse`.
struct AddressPURLItemResponseModel: Response {
    /// Display name or username.
    let name: String
    /// Associated URL.
    let url: String
    /// Access or hit count.
    let counter: Int?
    /// Visibility flag or status.
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}

typealias AddressPURLsResponseModel = [AddressPURLItemResponseModel]

/// Response model for `GETPURLsResponseModel`.
struct PURLsResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of PURL records.
    let purls: AddressPURLsResponseModel
}

/// Response model for `GETPURLResponseModel`.
struct PURLResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Single PURL record.
    let purl: AddressPURLResponseModel
}

// MARK: Requests

/// Retrieves PURL data.
/// - Parameters:
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressPURLs(_ address: AddressName, authorization: APICredential? = nil) -> APIRequest<None, PURLsResponseModel> {
    .init(
        authorization: authorization,
        path: PURLPath.purls(address)
    )
}

/// Retrieves PURL data.
/// - Parameters:
///   - purl: Description for `purl`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressPURL(_ purl: String, address: AddressName, authorization: APICredential? = nil) -> APIRequest<None, PURLResponseModel> {
    .init(
        authorization: authorization,
        path: PURLPath.managePurl(purl, address: address)
    )
}

/// Retrieves PURL data.
///
/// Never attaches a credential: this endpoint redirects to an arbitrary
/// user-chosen URL, and `URLSession` re-sends headers on redirect, so an
/// `Authorization` header here would leak the bearer token to third-party hosts.
/// - Parameters:
///   - purl: Description for `purl`.
///   - address: Description for `address`.
func GETAddressPURLContent(purl: String, address: AddressName) -> APIRequest<None, String> {
    .init(
        path: PublicPath.purl(address, purl: purl)
    )
}

/// Deletes a resource related to `DELETEAddressPURLContent`.
/// - Parameters:
///   - purl: Description for `purl`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func DELETEAddressPURLContent(purl: String, address: AddressName, authorization: APICredential) -> APIRequest<None, BasicResponse> {
    .init(
        authorization: authorization,
        method: .DELETE,
        path: PURLPath.managePurl(purl, address: address)
    )
}

/// Creates or updates data for `SETAddressPURL`.
/// - Parameters:
///   - draft: Description for `draft`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func SETAddressPURL(_ draft: PURL.Draft, address: AddressName, authorization: APICredential) -> APIRequest<PURL.Draft, BasicResponse> {
    .init(
        authorization: authorization,
        method: .POST,
        path: PURLPath.createPurl(address),
        body: draft
    )
}
