//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `AddressStatusModel`.
struct AddressStatusResponseModel: Response {
    
    /// Property `id` of type `String`.
    let id: String
    /// The omg.lol address this relates to.
    let address: AddressName
    /// Account creation timestamp.
    let created: String
    
    /// Raw text or HTML content.
    let content: String
    /// Property `emoji` of type `String?`.
    let emoji: String?
    /// External link for the status. The API's `external_url` key arrives as
    /// `externalUrl` via the decoder's snake_case conversion, so the property
    /// name must match that capitalization exactly.
    let externalUrl: URL?
    
    var createdDate: Date {
        Date(timeIntervalSince1970: Double(created) ?? 0)
    }
}

/// Response model for `AddressBioResponseModel`.
struct StatusLogBioResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `bio` of type `String?`.
    let bio: String?
    /// Custom stylesheet applied.
    let css: String?
}

/// Response model for `NewStatusResponseModel`.
struct NewStatusResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `id` of type `String`.
    let id: String
    /// Property `status` of type `String`.
    let status: String
    /// Associated URL.
    let url: String
    /// Property `externalUrl` of type `String?`.
    let externalUrl: String?
}

/// Response model for `StatusResponseModel`.
struct StatusResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `status` of type `AddressStatusModel`.
    let status: AddressStatusResponseModel
}

/// Response model for `StatusLogResponseModel`.
struct StatusLogResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `statuses` of type `[AddressStatusModel]?`.
    let statuses: [AddressStatusResponseModel]?
}

// MARK: Requests

/// Fetches data for `GETCompleteStatusLog`.
/// - Parameters:
func GETCompleteStatusLog() -> APIRequest<None, StatusLogResponseModel> {
    .init(path: StatusPath.completeLog)
}

/// Fetches data for `GETLatestStatusLogs`.
/// - Parameters:
func GETLatestStatusLogs() -> APIRequest<None, StatusLogResponseModel> {
    .init(path: StatusPath.latestLogs)
}

/// Fetches data for `GETAddressStatuses`.
/// - Parameters:
///   - address: Description for `address`.
func GETAddressStatuses(_ address: AddressName) -> APIRequest<None, StatusLogResponseModel> {
    .init(path: StatusPath.addressLog(address))
}

/// Fetches data for `GETAddressStatusBio`.
/// - Parameters:
///   - address: Description for `address`.
func GETAddressStatusBio(_ address: AddressName) -> APIRequest<None, StatusLogBioResponseModel> {
    .init(path: StatusPath.addressBio(address))
}

/// Updates the biography for the given address based on the draft content.
/// - Parameters:
///   - draft: The model that contains the updated markdown text.
///   - address: The `AddressName` to apply the update to
///   - authorization: An appropriate APICredential for the given `AddressName`
func SETAddressStatusBio(_ draft: Bio.Draft, for address: AddressName, authorization: APICredential) -> APIRequest<Bio.Draft, BasicResponse> {
    .init(
        authorization: authorization,
        method: .POST,
        path: StatusPath.addressBio(address),
        body: draft
    )
}

/// Retrieves a specific status by ID for the given address.
/// - Parameters:
///   - status: The status ID.
///   - address: The omg.lol address owning the status.
/// - Parameters:
///   - status: Description for `status`.
///   - address: Description for `address`.
func GETAddressStatus(_ status: String, from address: AddressName) -> APIRequest<None, StatusResponseModel> {
    .init(path: StatusPath.addressStatus(status, address))
}

/// Deletes a specific status from an address' statuslog.
/// - Parameters:
///   - statusId: The id of the status to delete.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func DELETEAddressStatus(_ statusId: String, from address: AddressName, authorization: APICredential) -> APIRequest<None, BasicResponse> {
    .init(
        authorization: authorization,
        method: .DELETE,
        path: StatusPath.addressStatus(statusId, address)
    )
}

/// Creates or updates data for `SETAddressStatus`.
/// - Parameters:
///   - draft: Description for `draft`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func SETAddressStatus(_ draft: Status.Draft, with address: AddressName, authorization: APICredential) -> APIRequest<Status.Draft, NewStatusResponseModel> {
    .init(
        authorization: authorization,
        method: .POST,
        path: StatusPath.addressLog(address),
        body: draft
    )
}
