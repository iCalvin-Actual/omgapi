//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `NowGardenResponse`.
struct NowGardenResponseModel: CommonAPIResponse {
/// Response model for `Now`.
    struct NowResponseModel: Response {
    /// The omg.lol address this relates to.
        let address: String
    /// Associated URL.
        let url: String
    /// Property `updated` of type `TimeStamp`.
        let updated: TimeStamp
    }
    /// Optional response message string.
    let message: String?
    /// Collection of Now entries.
    let garden: [NowResponseModel]
}

/// Response model for `AddressNowResponseModel`.
struct AddressNowResponseModel: CommonAPIResponse {
/// Response model for `Now`.
    struct NowResponseModel: Response {
    /// Raw text or HTML content.
        let content: String
    /// Property `updated` of type `Int`.
        let updated: Int
    /// Visibility flag or status.
        let listed: Int
        
        var updatedAt: Date {
            let double = Double(updated)
            return Date(timeIntervalSince1970: double)
        }
    }
    /// Optional response message string.
    let message: String?
    /// Property `now` of type `Now`.
    let now: NowResponseModel
}

// MARK: Requests

/// Retrieves Now page or status information.
/// - Parameters:
func GETNowGardenRequest() -> APIRequest<None, NowGardenResponseModel> {
    .init(
        path: NowPath.garden
    )
}

/// Retrieves Now page or status information.
/// - Parameters:
///   - address: Description for `address`.
func GETAddressNowPageRequest(_ address: AddressName) -> APIRequest<None, String> {
    .init(
        path: NowPagePath.nowPage(address: address)
    )
}

/// Retrieves Now page or status information.
/// - Parameters:
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressNowRequest(for address: AddressName, authorization: APICredential?) -> APIRequest<None, AddressNowResponseModel> {
    .init(
        authorization: authorization,
        path: NowPath.now(address: address)
    )
}

/// Creates or updates data for `SETAddressNowRequest`.
/// - Parameters:
///   - address: Description for `address`.
///   - draft: Description for `draft`.
///   - authorization: Description for `authorization`.
func SETAddressNowRequest(for address: AddressName, draft: Now.Draft, authorization: APICredential) -> APIRequest<Now.Draft, BasicResponse> {
    .init(
        authorization: authorization,
        method: .POST,
        path: NowPath.now(address: address),
        body: draft
    )
}
