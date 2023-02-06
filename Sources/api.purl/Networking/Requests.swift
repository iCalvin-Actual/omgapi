//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

class GETAddressPURLs: APIRequest<None, GetPURLsResponseModel> {
    init(_ address: AddressName) {
        super.init(path: PURLPath.purls(address))
    }
}

class GETAddressPURL: APIRequest<None, GetPURLResponseModel> {
    init(_ purl: String, address: AddressName, authorization: String) {
        super.init(
            authorization: authorization,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

class DELETEAddressPURL: APIRequest<None, BasicResponse> {
    init(_ purl: String, address: AddressName, authorization: String) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

class SETAddressPURL: APIRequest<PURL.Draft, UpdatePURLResponseModel> {
    init(_ draft: PURL.Draft, address: AddressName, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: PURLPath.createPurl(address),
            body: draft
        )
    }
}
