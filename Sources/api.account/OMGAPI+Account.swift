//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation
import api_core
import Combine


public extension omg_api {
    
    func oAuthRequest(with clientId: String, and clientSecret: String) async throws -> URLRequest? {
        let oAuthRequest = OAuthRequest(with: clientId, and: clientSecret)
        
        return APIRequestConstructor.urlRequest(from: oAuthRequest)
    }
    
    func account(for emailAddress: String, with credentials: APICredentials) async throws -> Account {
        let ownerRequest = GETAccountNameAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let infoRequest = GETAccountInfoAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let settingsRequest = GETAccountSettingsAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let addressesRequest = GETAddressesForEmailAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        async let owner = try self.apiResponse(for: ownerRequest)
        async let info = try self.apiResponse(for: infoRequest)
        async let settings = try self.apiResponse(for: settingsRequest)
        async let addresses = try self.apiResponse(for: addressesRequest)
        
        return await Account(
            owner: try owner,
            info: try info,
            settings: try settings,
            addresses: try addresses.map({ .init(name: $0.address, registered: $0.registration) })
        )
    }
    
    func setName(_ newValue: String, for emailAddress: String, with credentials: APICredentials) async throws -> Account {
        let setNameRequest = SETAccountNameAPIRequest(
            newValue: newValue,
            for: emailAddress,
            authorization: credentials
        )
        let _ = try await apiResponse(for: setNameRequest)
        return try await account(for: emailAddress, with: credentials)
    }
    
    func setCommunication(_ preference: CommunicationPreference, for emailAddress: String, with credentials: APICredentials) async throws -> Account {
        let request = SETAccountSettingsAPIRequest(
            communicationPreference: preference,
            for: emailAddress,
            authorization: credentials
        )
        let _ = try await apiResponse(for: request)
        return try await account(for: emailAddress, with: credentials)
    }
    
    func getAccount(for emailAddress: String, with credentials: APICredentials) -> ResultPublisher<Account> {
        let ownerRequest = GETAccountNameAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let infoRequest = GETAccountInfoAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let settingsRequest = GETAccountSettingsAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let addressesRequest = GETAddressesForEmailAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let ownerPublisher = publisher(for: ownerRequest)
        let infoPublisher = publisher(for: infoRequest)
        let settingsPublisher = publisher(for: settingsRequest)
        let addressesPublisher = publisher(for: addressesRequest)
        
        return Publishers.Zip4(ownerPublisher, infoPublisher, settingsPublisher, addressesPublisher)
            .map({ ownerResult, infoResult, nameResult, addressesResult -> Result<Account, omg_api.APIError> in
                switch (ownerResult, infoResult, nameResult, addressesResult) {
                case (.failure(let error), _, _, _):
                    // owner failure
                    return .failure(error)
                case (_, .failure(let error), _, _):
                    // info failure
                    return .failure(error)
                case (_, _, .failure(let error), _):
                    // settings failure
                    return .failure(error)
                case (_, _, _, .failure(let error)):
                    // settings failure
                    return .failure(error)
                case (.success(let owner), .success(let info), .success(let settings), .success(let addresses)):
                    let account = Account(
                        owner: owner,
                        info: info,
                        settings: settings,
                        addresses: addresses.map({ .init(name: $0.address, registered: $0.registration) })
                    )
                    return .success(account)
                }
            })
            .eraseToAnyPublisher()
    }
    
    func setName(_ newValue: String, for emailAddress: String, with credentials: APICredentials) -> ResultPublisher<Account> {
        let setNameRequest = SETAccountNameAPIRequest(
            newValue: newValue,
            for: emailAddress,
            authorization: credentials
        )
        return publisher(for: setNameRequest)
            .flatMap({ _ in self.getAccount(for: emailAddress, with: credentials) })
            .eraseToAnyPublisher()
    }
    
    func setCommunication(_ newValue: CommunicationPreference, for emailAddress: String, with credentials: APICredentials) -> ResultPublisher<Account> {
        let setPreferenceRequest = SETAccountSettingsAPIRequest(
            communicationPreference: newValue,
            for: emailAddress,
            authorization: credentials
        )
        return publisher(for: setPreferenceRequest)
            .flatMap({ _ in self.getAccount(for: emailAddress, with: credentials) })
            .eraseToAnyPublisher()
    }
}
