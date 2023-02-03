//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

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
extension APIRequestConstructor {
    func currentAccountInfoRequest() -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        return accountInfoRequest(emailAddress: emailAddress)
    }
    
    func accountInfoRequest(emailAddress: String) -> URLRequest {
        request(with: urlConstructor.accountInfo(emailAddress: emailAddress))
    }
}

/*
GET
Auth: YES
Body: None
Response: AccountOwner

POST
Auth: YES
Body: [
name: String
]
Response: AccountOwner
*/
extension APIRequestConstructor {
    func currentAccountNameRequest() -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        return accountNameRequest(emailAddress: emailAddress)
    }
    
    func accountNameRequest(emailAddress: String) -> URLRequest {
        request(with: urlConstructor.accountName(emailAddress: emailAddress))
    }
    
    func updateAccountNameRequest(newName: String?) -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        
        struct Body: Encodable {
            let name: String?
        }
        
        return request(
            method: .POST,
            with: urlConstructor.accountName(emailAddress: emailAddress),
            bodyParameters: Body(name: newName)
        )
    }
}

/*
GET
Auth: Yes
Body: None
Response: [
message: String?
settings: AccountSettings

POST
Auth: Yes
Body: AccountSettings
Response: BasicResponse
*/
extension APIRequestConstructor {
    func currentAccountSettingsRequest() -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        return request(with: urlConstructor.accountSettings(emailAddress: emailAddress))
    }
    
    func updateAccountSettingsRequest(newSettings: AccountSettings) -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        
        return request(
            method: .POST,
            with: urlConstructor.accountSettings(emailAddress: emailAddress),
            bodyParameters: newSettings
        )
    }
}

/*
GET
Auth: YES
Body: None
Response: [
 AccountAddress, AccountAddress, ...
]
*/
extension APIRequestConstructor {
    func currentAccountAddressesRequest() -> URLRequest? {
        guard let emailAddress = emailAddress else {
            return nil
        }
        return accountAddressesRequest(emailAddress: emailAddress)
    }
    
    func accountAddressesRequest(emailAddress: String) -> URLRequest {
        request(with: urlConstructor.accountAddresses(emailAddress: emailAddress))
    }
}
