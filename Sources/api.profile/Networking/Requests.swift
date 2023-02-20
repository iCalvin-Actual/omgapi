//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

class GETAddressProfile: APIRequest<None, String> {
    init(_ address: AddressName, with authorization: String? = nil) {
        super.init(
            authorization: authorization,
            path: ProfilePath.profile(address)
        )
    }
}

class SETAddressProfile: APIRequest<PublicProfile.Draft, BasicResponse> {
    init(_ newContent: PublicProfile.Draft, for address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: ProfilePath.profile(address),
            body: newContent
        )
    }
}

class GETAddressPhoto: APIRequest<ProfilePhoto, BasicResponse> {
    init(_ address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            path: ProfilePath.photo(address)
        )
    }
}

class SETAddressPhoto: APIRequest<ProfilePhoto, BasicResponse> {
    init(_ photo: ProfilePhoto, for address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: ProfilePath.profile(address),
            body: photo
        )
    }
}
