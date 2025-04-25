//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `OAuthResponse`.
struct OAuthResponseModel: Response {
    /// OAuth access token string.
    let accessToken: String?
}

/// Response model for `AccountInfo`.
struct AccountInfoResponseModel: CommonAPIResponse, Sendable {
    /// Optional response message string.
    let message: String?
    
    /// User's email address.
    let email: String
    /// Account creation timestamp.
    let created: TimeStamp
    /// Display name or username.
    let name: String
}

/// Response model for `AccountOwner`.
struct AccountOwnerResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Display name or username.
    let name: String?
}

/// Response model for `AccountAddressResponse`.
struct AccountAddressResponseModel: Response {
    /// Optional response message string.
    let message: String?
    /// The omg.lol address this relates to.
    let address: String
    /// Timestamp when the address was registered.
    let registration: TimeStamp
}

typealias AddressCollectionResponseModel = [AccountAddressResponseModel]
extension AddressCollectionResponseModel: Response { }

// MARK: Requests

/// Initiates an OAuth authorization exchange.
class OAuthRequest: APIRequest<None, OAuthResponseModel> {
    /// - Parameters:
    ///   - clientId: Description for `clientId`.
    ///   - clientSecret: Description for `clientSecret`.
    ///   - redirect: Description for `redirect`.
    ///   - accessCode: Description for `accessCode`.
    init(with clientId: String, and clientSecret: String, redirect: String, accessCode: String) {
        super.init(
            path: AccountPath.oauth(clientId, clientSecret, redirect, accessCode)
        )
    }
}

/// Retrieves accountinfo information.
class GETAccountInfoAPIRequest: APIRequest<None, AccountInfoResponseModel> {
    /// - Parameters:
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.info(emailAddress)
        )
    }
}

/// Fetches data for `GETAccountNameAPIRequest`.
class GETAccountNameAPIRequest: APIRequest<None, AccountOwnerResponseModel> {
    /// - Parameters:
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.name(emailAddress)
        )
    }
}

/// Creates or updates data for `SETAccountNameAPIRequest`.
class SETAccountNameAPIRequest: APIRequest<SETAccountNameAPIRequest.Parameters, AccountOwnerResponseModel> {
    struct Parameters: RequestBody {
        let name: String
    }
    /// - Parameters:
    ///   - newValue: Description for `newValue`.
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(newValue: String, for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.name(emailAddress),
            body: Parameters(name: newValue)
        )
    }
}

/// Fetches data for `GETAddresses`.
class GETAddresses: APIRequest<None, AddressCollectionResponseModel> {
    /// - Parameters:
    ///   - authorization: Description for `authorization`.
    init(authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.addresses
        )
    }
}

/// Fetches data for `GETAddressesForEmailAPIRequest`.
class GETAddressesForEmailAPIRequest: APIRequest<None, AddressCollectionResponseModel> {
    /// - Parameters:
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.emailAddresses(emailAddress)
        )
    }
}

/// Fetches data for `GETAddressExpirationRequest`.
class GETAddressExpirationRequest: APIRequest<None, AddressInfoResponseModel.ExpirationResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(for address: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AddressPath.expiration(address)
        )
    }
}
