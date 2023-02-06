//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

class GETAddressPasteBin: APIRequest<None, PasteBinResponseModel> {
    init(_ address: AddressName, authorization: String? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.pastes(address)
        )
    }
}

class GETAddressPaste: APIRequest<None, PasteResponseModel> {
    init(_ title: String, from address: AddressName, authorization: String? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.paste(title, address: address)
        )
    }
}

class SETAddressPaste: APIRequest<Paste.Draft, NewPasteResponseModel> {
    init(_ title: String? = nil, draft: Paste.Draft, from address: AddressName, authorization: String) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: PasteBinPath.paste(title ?? draft.title, address: address),
            body: draft
        )
    }
}

class DELETEAddressPaste: APIRequest<None, BasicResponse> {
    init(_ title: String, from address: AddressName, authorization: String) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: PasteBinPath.paste(title, address: address)
        )
    }
}
