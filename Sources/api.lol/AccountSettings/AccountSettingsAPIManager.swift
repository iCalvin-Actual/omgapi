//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Combine
import Foundation

extension APIManager {
    
/*
 GET
 Auth: YES
 Body: None
 Response: [
     message: String?
     email: String
     created: TimeStamp
     settings: AccountSettings
]
*/
    func getAccountInfo() -> APIResultPublisher<AccountInfoResponseModel> {
        
        guard let request = requestConstructor.currentAccountInfoRequest() else {
            return Just(.failure(.unauthenticated))
                .eraseToAnyPublisher()
        }
        
        return requestPublisher(request)
    }
    
    
/*
 GET
 Auth: YES
 Body: None
 Response: AccountOwner
*/
    func getAccountName() -> APIResultPublisher<AccountOwner> {
        guard let request = requestConstructor.currentAccountNameRequest() else {
            return Just(.failure(.unauthenticated))
                .eraseToAnyPublisher()
        }
        return requestPublisher(request)
    }
    
/*
 POST
 Auth: YES
 Body: [
   name: String
 ]
 Response: AccountOwner
*/
    func setAccountName(_ newValue: String?) -> APIResultPublisher<AccountOwner> {
        guard let request = requestConstructor.updateAccountNameRequest(newName: newValue) else {
            return Just(.failure(.unauthenticated))
                .eraseToAnyPublisher()
        }
        return requestPublisher(request)
    }
    
    func getAccountSettings() -> APIResultPublisher<AccountSettingsResponseModel> {
        guard let request = requestConstructor.currentAccountSettingsRequest() else {
            return Just(.failure(.unauthenticated))
                .eraseToAnyPublisher()
        }
        return requestPublisher(request)
    }
    
    func setAccountSettings(_ newValue: AccountSettings) -> APIResultPublisher<BasicResponse> {
        guard let request = requestConstructor.updateAccountSettingsRequest(newSettings: newValue) else {
            return Just(.failure(.unauthenticated))
                .eraseToAnyPublisher()
        }
        return requestPublisher(request)
    }
}
