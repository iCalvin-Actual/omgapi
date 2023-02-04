//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class GETAccountInfoAPIRequest: APIRequest<EmptyRequeset, AccountInfo> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.info(emailAddress)
        )
    }
}

class GETAccountNameAPIRequest: APIRequest<EmptyRequeset, AccountOwner> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.name(emailAddress)
        )
    }
}

class SETAccountNameAPIRequest: APIRequest<SETAccountNameAPIRequest.Parameters, AccountOwner> {
    struct Parameters: RequestBody {
        let name: String
    }
    init(newValue: String, for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.name(emailAddress),
            body: Parameters(name: newValue)
        )
    }
}

class GETAccountSettingsAPIRequest: APIRequest<EmptyRequeset, AccountSettings> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.settings(emailAddress)
        )
    }
}

class SETAccountSettingsAPIRequest: APIRequest<SETAccountSettingsAPIRequest.Parameters, BasicResponse> {
    struct Parameters: RequestBody {
        let communication: CommunicationPreference
    }
    init(communicationPreference: CommunicationPreference, for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.settings(emailAddress),
            body: Parameters(communication: communicationPreference)
        )
    }
}

class GETAddressesAPIRequest: APIRequest<EmptyRequeset, AddressCollection> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.addresses(emailAddress)
        )
    }
}

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
