//
//  File 2.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

class GETNowGardenRequest: APIRequest<Empty, NowGardenResponse> {
    init() {
        super.init(
            path: NowPath.garden
        )
    }
}

class GETAddressNowRequest: APIRequest<Empty, AddressNowResponseModel> {
    init(for address: AddressName) {
        super.init(
            path: NowPath.now(address: address)
        )
    }
}

class SETAddressNowRequest: APIRequest<Now.Draft, BasicResponse> {
    init(_ draft: Now.Draft, for address: AddressName, authorization: String){
        super.init(
            authorization: authorization,
            method: .POST,
            path: NowPath.now(address: address),
            body: draft
        )
    }
}
