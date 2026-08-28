//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `AddressDirectoryResponse`.
struct DirectoryResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Associated URL.
    let url: String
    /// List of known addresses.
    let directory: [String]
}

/// Response model for `AddressInfoResponse`.
struct AddressInfoResponseModel: CommonAPIResponse {
/// Response model for `Expiration`.
    struct ExpirationResponseModel: CommonAPIResponse {
    /// Optional response message string.
        let message: String?
    /// Property `expired` of type `Bool`.
        let expired: Bool
    /// Property `willExpire` of type `Bool?`.
        let willExpire: Bool?
    /// Property `unixEpochTime` of type `String?`.
        let unixEpochTime: String?
    /// Property `relativeTime` of type `String?`.
        let relativeTime: String?
    }
    
/// Response model for `Verification`.
    struct VerificationResponseModel: CommonAPIResponse {
    /// Optional response message string.
        let message: String?
    /// Whether the item is verified.
        let verified: Bool
    }
    /// Optional response message string.
    let message: String?
    /// The omg.lol address this relates to.
    let address: String
    /// Property `owner` of type `String?`.
    let owner: String?
    /// Timestamp when the address was registered, absent when the API omits a
    /// usable epoch.
    let registration: LenientTimeStamp?
    /// Expiration info for the address.
    let expiration: ExpirationResponseModel
    /// Verification state for the address.
    let verification: VerificationResponseModel
}

/// Response model for `AddressAvailabilityResponse`.
struct AddressAvailabilityResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    
    /// The omg.lol address this relates to.
    let address: String
    /// Whether the address is available.
    let available: Bool
    
    /// Availability status string.
    let availability: String
    
    /// Punycode-encoded version of the address.
    let punyCode: String?
}

// MARK: Requests

/// Fetches a directory listing.
/// - Parameters:
func GETAddressDirectoryRequest() -> APIRequest<None, DirectoryResponseModel> {
    .init(path: AddressPath.directory)
}

/// Checks for availability.
/// - Parameters:
///   - address: Description for `address`.
func GETAddressAvailabilityRequest(for address: String) -> APIRequest<None, AddressAvailabilityResponseModel> {
    .init(path: AddressPath.availability(address))
}

/// Retrieves addressinforequest information.
/// - Parameters:
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressInfoRequest(for address: String, authorization: APICredential? = nil) -> APIRequest<None, AddressInfoResponseModel> {
    .init(
        authorization: authorization,
        path: AddressPath.info(address)
    )
}
