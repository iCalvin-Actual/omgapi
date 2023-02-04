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
        let addressesRequest = GETAddressesAPIRequest(
            for: credentials.emailAddress,
            authorization: credentials.authKey
        )
        let ownerPublisher = publisher(for: ownerRequest)
        let infoPublisher = publisher(for: infoRequest)
        let settingsPublisher = publisher(for: settingsRequest)
        let addressesPublisher = publisher(for: addressesRequest)
        
        return Publishers.Zip4(ownerPublisher, infoPublisher, settingsPublisher, addressesPublisher)
            .map({ ownerResult, infoResult, nameResult, addressesResult -> Result<Account, APIManager.APIError> in
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
