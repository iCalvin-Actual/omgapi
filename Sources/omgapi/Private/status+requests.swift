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
    /// Property `externalURL` of type `URL?`.
    let externalURL: URL?
    
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
class GETCompleteStatusLog: APIRequest<None, StatusLogResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: StatusPath.completeLog)
    }
}

/// Fetches data for `GETLatestStatusLogs`.
class GETLatestStatusLogs: APIRequest<None, StatusLogResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: StatusPath.latestLogs)
    }
}

/// Fetches data for `GETAddressStatuses`.
class GETAddressStatuses: APIRequest<None, StatusLogResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressLog(address))
    }
}

/// Fetches data for `GETAddressStatusBio`.
class GETAddressStatusBio: APIRequest<None, StatusLogBioResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressBio(address))
    }
}

/// Retrieves a specific status by ID for the given address.
/// - Parameters:
///   - status: The status ID.
///   - address: The omg.lol address owning the status.
class GETAddressStatus: APIRequest<None, StatusResponseModel> {
    /// - Parameters:
    ///   - status: Description for `status`.
    ///   - address: Description for `address`.
    init(_ status: String, from address: AddressName) {
        super.init(path: StatusPath.addressStatus(status, address))
    }
}

/// Deletes a resource related to `DELETEAddressStatus`.
class DELETEAddressStatus: APIRequest<Status.Draft, BasicResponse> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: Status.Draft, from address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: StatusPath.addressLog(address),
            body: draft
        )
    }
}

/// Creates or updates data for `SETAddressStatus`.
class SETAddressStatus: APIRequest<Status.Draft, NewStatusResponseModel> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: Status.Draft, with address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressLog(address),
            body: draft
        )
    }
}
