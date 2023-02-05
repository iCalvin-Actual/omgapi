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

extension APIRequestConstructor {
    private struct Parameters: Encodable {
        let name: String
        let url: String
    }
    
    func getPurls(for address: String) -> URLRequest {
        request(with: urlConstructor.addressPurls(address))
    }
    
    func createPurl(name: String, url: String, for address: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.createPurls(address), bodyParameters: Parameters(name: name, url: url))
    }
    
    func getPurl(purl: String, from address: String) -> URLRequest {
        request(with: urlConstructor.managePurl(for: address, purl: purl))
    }
    
    func updatePurl(purl: String, name: String, url: String, from address: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.managePurl(for: address, purl: purl), bodyParameters: Parameters(name: name, url: url))
    }
    
    func deletePurl(purl: String, from address: String) -> URLRequest {
        request(method: .DELETE, with: urlConstructor.managePurl(for: address, purl: purl))
    }
}
