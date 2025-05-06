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
class GETNowGardenRequest: APIRequest<None, NowGardenResponseModel> {
    /// - Parameters:
    init() {
        super.init(
            path: NowPath.garden
        )
    }
}

/// Retrieves Now page or status information.
class GETAddressNowPageRequest: APIRequest<None, String> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(_ address: AddressName) {
        super.init(
            path: NowPagePath.nowPage(address: address)
        )
    }
}

/// Retrieves Now page or status information.
class GETAddressNowRequest: APIRequest<None, AddressNowResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(for address: AddressName, authorization: APICredential?) {
        super.init(
            authorization: authorization,
            path: NowPath.now(address: address)
        )
    }
}

/// Creates or updates data for `SETAddressNowRequest`.
class SETAddressNowRequest: APIRequest<Now.Draft, BasicResponse> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - draft: Description for `draft`.
    ///   - authorization: Description for `authorization`.
    init(for address: AddressName, draft: Now.Draft, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: NowPath.now(address: address),
            body: draft
        )
    }
}
