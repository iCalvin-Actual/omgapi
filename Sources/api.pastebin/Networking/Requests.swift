//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

class GETAddressPasteBin: APIRequest<None, PasteBinResponseModel> {
    init(_ address: AddressName) {
        super.init(path: PasteBinPath.pastes(address))
    }
}

class GETAddressPaste: APIRequest<None, PasteResponseModel> {
    init(_ title: String, from address: AddressName) {
        super.init(path: PasteBinPath.paste(title, address: address))
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

extension APIRequestConstructor {
    private struct Parameters: Encodable {
        let title: String
        let content: String
    }
    func getPastes(from address: String) -> URLRequest {
        request(with: urlConstructor.addressPastes(for: address))
    }
    
    func newPaste(from address: String, title: String, content: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.addressPastes(for: address), bodyParameters: Parameters(title: title, content: content))
    }
    
    func getPaste(title: String, from address: String) -> URLRequest {
        request(with: urlConstructor.addressPaste(paste: title, in: address))
    }
    
    func deletePaste(title: String, from address: String) -> URLRequest {
        request(method: .DELETE, with: urlConstructor.addressPaste(paste: title, in: address))
    }
}
