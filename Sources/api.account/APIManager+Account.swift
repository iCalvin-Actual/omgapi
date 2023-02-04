//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Combine


extension APIManager {
    func getAccount(for credentials: APICredentials) -> ResultPublisher<Account> {
        let ownerRequest = GETAccountNameAPIRequest(
            for: credentials.emailAddress,
            authorization: credentials.authKey
        )
        let infoRequest = GETAccountInfoAPIRequest(
            for: credentials.emailAddress,
            authorization: credentials.authKey
        )
        let settingsRequest = GETAccountSettingsAPIRequest(
            for: credentials.emailAddress,
            authorization: credentials.authKey
        )
        let ownerPublisher = publisher(for: ownerRequest)
        let infoPublisher = publisher(for: infoRequest)
        let settingsPublisher = publisher(for: settingsRequest)
        
        return Publishers.Zip3(ownerPublisher, infoPublisher, settingsPublisher)
            .map({ ownerResult, infoResult, nameResult -> Result<Account, APIManager.APIError> in
                switch (ownerResult, infoResult, nameResult) {
                case (.failure(let error), _, _):
                    // owner failure
                    return .failure(error)
                case (_, .failure(let error), _):
                    // info failure
                    return .failure(error)
                case (_, _, .failure(let error)):
                    // settings failure
                    return .failure(error)
                case (.success(let owner), .success(let info), .success(let settings)):
                    let account = Account(owner: owner, info: info, settings: settings)
                    return .success(account)
                }
            })
            .eraseToAnyPublisher()
    }
    
    func setName(_ newValue: String, with credentials: APICredentials) -> ResultPublisher<Account> {
        let setNameRequest = SETAccountNameAPIRequest(
            newValue: newValue,
            for: credentials.emailAddress,
            authorization: credentials.authKey
        )
        return publisher(for: setNameRequest)
            .flatMap({ _ in self.getAccount(for: credentials) })
            .eraseToAnyPublisher()
    }
    
    func setCommunication(_ newValue: CommunicationPreference, with credentials: APICredentials) -> ResultPublisher<Account> {
        let setPreferenceRequest = SETAccountSettingsAPIRequest(
            communicationPreference: newValue,
            for: credentials.emailAddress,
            authorization: credentials.authKey
        )
        return publisher(for: setPreferenceRequest)
            .flatMap({ _ in self.getAccount(for: credentials) })
            .eraseToAnyPublisher()
    }
}
