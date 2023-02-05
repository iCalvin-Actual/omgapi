//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

class GETCompleteStatusLog: APIRequest<None, StatusLogResponseModel> {
    init() {
        super.init(path: StatusPath.completeLog)
    }
}

class GETLatestStatusLogs: APIRequest<None, StatusLogResponseModel> {
    init() {
        super.init(path: StatusPath.latestLogs)
    }
}

class GETAddressStatuses: APIRequest<None, StatusLogResponseModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressLog(address))
    }
}

class GETAddressStatus: APIRequest<None, StatusResponseModel> {
    init(_ status: String, from address: AddressName) {
        super.init(path: StatusPath.addressStatus(status, address))
    }
}

class SETAddressStatus: APIRequest<Status.Draft, NewStatusResponseModel> {
    init(_ draft: Status.Draft, from address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressLog(address),
            body: draft
        )
    }
}

class DELETEAddressStatus: APIRequest<None, BasicResponse> {
    init(_ status: String, from address: AddressName, with authorization: String) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: StatusPath.addressStatus(status, address)
        )
    }
}

class GETAddressStatusBio: APIRequest<None, StatusLogBioResponseModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressBio(address))
    }
}

class SETAddressStatusBio: APIRequest<StatusLog.Bio.Draft, BasicResponse> {
    init(_ draft: StatusLog.Bio.Draft, for address: AddressName, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressBio(address),
            body: draft
        )
    }
}
