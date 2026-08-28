//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `OAuthResponse`.
///
/// `accessToken` is required so that decoding fails for error payloads —
/// the priority decode in `oAuthExchange` then falls through to standard
/// envelope handling, which throws a descriptive `api.Error` instead of
/// silently returning a `nil` credential.
struct OAuthResponseModel: Response {
    /// OAuth access token string.
    let accessToken: String
}

/// Response model for `AccountInfo`.
struct AccountInfoResponseModel: CommonAPIResponse, Sendable {
    /// Optional response message string.
    let message: String?
    
    /// User's email address.
    let email: String
    /// Account creation timestamp, absent when the API omits a usable epoch.
    let created: LenientTimeStamp?
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
    /// Timestamp when the address was registered, absent when the API omits a
    /// usable epoch. Optional so one address can't fail the whole list decode.
    let registration: LenientTimeStamp?
}

typealias AddressCollectionResponseModel = [AccountAddressResponseModel]
extension AddressCollectionResponseModel: Response { }

// MARK: Requests

/// Initiates an OAuth authorization exchange.
/// - Parameters:
///   - clientId: Description for `clientId`.
///   - clientSecret: Description for `clientSecret`.
///   - redirect: Description for `redirect`.
///   - accessCode: Description for `accessCode`.
func OAuthRequest(with clientId: String, and clientSecret: String, redirect: String, accessCode: String) -> APIRequest<None, OAuthResponseModel> {
    .init(
        path: AccountPath.oauth(clientId, clientSecret, redirect, accessCode)
    )
}

/// Retrieves accountinfo information.
/// - Parameters:
///   - emailAddress: Description for `emailAddress`.
///   - authorization: Description for `authorization`.
func GETAccountInfoAPIRequest(for emailAddress: String, authorization: APICredential) -> APIRequest<None, AccountInfoResponseModel> {
    .init(
        authorization: authorization,
        path: AccountPath.info(emailAddress)
    )
}

/// Fetches data for `GETAccountNameAPIRequest`.
/// - Parameters:
///   - emailAddress: Description for `emailAddress`.
///   - authorization: Description for `authorization`.
func GETAccountNameAPIRequest(for emailAddress: String, authorization: APICredential) -> APIRequest<None, AccountOwnerResponseModel> {
    .init(
        authorization: authorization,
        path: AccountPath.name(emailAddress)
    )
}

/// Creates or updates data for `SETAccountNameAPIRequest`.
/// Request body for `SETAccountNameAPIRequest`.
struct AccountNameParameters: RequestBody {
    let name: String
}

/// - Parameters:
///   - newValue: Description for `newValue`.
///   - emailAddress: Description for `emailAddress`.
///   - authorization: Description for `authorization`.
func SETAccountNameAPIRequest(newValue: String, for emailAddress: String, authorization: APICredential) -> APIRequest<AccountNameParameters, AccountOwnerResponseModel> {
    .init(
        authorization: authorization,
        method: .POST,
        path: AccountPath.name(emailAddress),
        body: AccountNameParameters(name: newValue)
    )
}

/// Fetches data for `GETAddresses`.
/// - Parameters:
///   - authorization: Description for `authorization`.
func GETAddresses(authorization: APICredential) -> APIRequest<None, AddressCollectionResponseModel> {
    .init(
        authorization: authorization,
        path: AccountPath.addresses
    )
}

/// Fetches data for `GETAddressesForEmailAPIRequest`.
/// - Parameters:
///   - emailAddress: Description for `emailAddress`.
///   - authorization: Description for `authorization`.
func GETAddressesForEmailAPIRequest(for emailAddress: String, authorization: APICredential) -> APIRequest<None, AddressCollectionResponseModel> {
    .init(
        authorization: authorization,
        path: AccountPath.emailAddresses(emailAddress)
    )
}

/// Fetches data for `GETAddressExpirationRequest`.
/// - Parameters:
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressExpirationRequest(for address: String, authorization: APICredential) -> APIRequest<None, AddressInfoResponseModel.ExpirationResponseModel> {
    .init(
        authorization: authorization,
        path: AddressPath.expiration(address)
    )
}
