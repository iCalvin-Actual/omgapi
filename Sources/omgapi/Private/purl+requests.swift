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
class GETAddressPURLs: APIRequest<None, PURLsResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PURLPath.purls(address)
        )
    }
}

/// Retrieves PURL data.
class GETAddressPURL: APIRequest<None, PURLResponseModel> {
    /// - Parameters:
    ///   - purl: Description for `purl`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ purl: String, address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

/// Retrieves PURL data.
///
/// Never attaches a credential: this endpoint redirects to an arbitrary
/// user-chosen URL, and `URLSession` re-sends headers on redirect, so an
/// `Authorization` header here would leak the bearer token to third-party hosts.
class GETAddressPURLContent: APIRequest<None, String> {
    /// - Parameters:
    ///   - purl: Description for `purl`.
    ///   - address: Description for `address`.
    init(purl: String, address: AddressName) {
        super.init(
            path: PublicPath.purl(address, purl: purl)
        )
    }
}

/// Deletes a resource related to `DELETEAddressPURLContent`.
class DELETEAddressPURLContent: APIRequest<None, BasicResponse> {
    /// - Parameters:
    ///   - purl: Description for `purl`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(purl: String, address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

/// Creates or updates data for `SETAddressPURL`.
class SETAddressPURL: APIRequest<PURL.Draft, BasicResponse> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: PURL.Draft, address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: PURLPath.createPurl(address),
            body: draft
        )
    }
}
