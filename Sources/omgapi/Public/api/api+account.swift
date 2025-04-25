//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Constructs the authorization URL for beginning an OAuth flow.
    ///
    /// - Parameters:
    ///   - clientId: The OAuth client ID registered with omg.lol.
    ///   - redirect: The redirect URI that will receive the authorization code.
    /// - Returns: The full authorization URL.
    nonisolated
    func authURL(with clientId: String, redirect: String) -> URL? {
        URL(string: "https://home.omg.lol/oauth/authorize?client_id=\(clientId)&scope=everything&redirect_uri=\(redirect)&response_type=code")
    }
    
    /// Exchanges an OAuth authorization code for an API credential.
    ///
    /// - Parameters:
    ///   - clientId: The OAuth client ID.
    ///   - clientSecret: The OAuth client secret.
    ///   - redirect: The redirect URI that was used during auth.
    ///   - code: The authorization code received after login.
    /// - Returns: The API credential (bearer token) if successful.
    func oAuthExchange(with clientId: String, and clientSecret: String, redirect: String, code: String) async throws -> APICredential? {
        let oAuthRequest = OAuthRequest(with: clientId, and: clientSecret, redirect: redirect, accessCode: code)
        
        let response = try await self.apiResponse(for: oAuthRequest, priorityDecoding: { data in
            try? api.decoder.decode(OAuthResponseModel.self, from: data)
        })
        
        return response.accessToken
    }
    
    /// Retrieves a list of omg.lol addresses associated with the authenticated account.
    ///
    /// - Parameter credentials: The API credential used to authenticate.
    /// - Returns: An array of `AddressName`.
    func addresses(with credentials: APICredential) async throws -> AddressDirectory {
        let request = GETAddresses(authorization: credentials)
        
        let response = try await self.apiResponse(for: request)
        
        return response.map({ $0.address })
    }
    
    /// Fetches the current account metadata for a specific email address.
    ///
    /// - Parameters:
    ///   - emailAddress: The email address to fetch.
    ///   - credentials: API credential with access to the account.
    /// - Returns: The parsed `Account` object.
    func account(for emailAddress: String, with credentials: APICredential) async throws -> Account {
        let infoRequest = GETAccountInfoAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let info = try await self.apiResponse(for: infoRequest)
        
        return Account(
            info: info
        )
    }
    
    /// Returns the expiration date of a specific address.
    ///
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - credentials: API credential with permission to access expiration info.
    /// - Returns: A `Date` object representing expiration.
    func expirationDate(_ address: AddressName, credentials: APICredential) async throws -> Date {
        let request = GETAddressInfoRequest(for: address, authorization: credentials)
        let response = try await apiResponse(for: request)
        let date = Date(timeIntervalSince1970: Double(response.expiration.unixEpochTime ?? "") ?? 0)
        return date
    }
}
