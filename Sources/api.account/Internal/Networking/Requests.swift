//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class GETAccountInfoAPIRequest: APIRequest<Empty, AccountInfo> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.info(emailAddress)
        )
    }
}

class GETAccountNameAPIRequest: APIRequest<Empty, AccountOwner> {
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

class GETAccountSettingsAPIRequest: APIRequest<Empty, AccountSettings> {
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

class GETAddressesAPIRequest: APIRequest<Empty, AddressCollection> {
    init(for emailAddress: String, authorization: String) {
        super.init(
            authorization: authorization,
            path: AccountPath.addresses(emailAddress)
        )
    }
}
