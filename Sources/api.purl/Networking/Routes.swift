//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

enum PURLPath: APIPath {
    private static let addressPURLs = "address/{address}/purls/"
    private static let createPURL = "address/{address}/purl"
    private static let managePURL = "address/{address}/purl/{purl}"
    
    case purls(_ address: AddressName)
    case createPurl(_ address: AddressName)
    case managePurl(_ purl: String, address: AddressName)
    
    var string: String {
        switch self {
        case .purls(let address):
            return Self.addressPURLs.replacingAddress(address)
        case .createPurl(let address):
            return Self.createPURL.replacingAddress(address)
        case .managePurl(let purl, address: let address):
            return Self.managePURL.replacingPURL(purl).replacingAddress(address)
        }
    }
}

extension APIURLConstructor {
    private var addressPURLs: String    { "address/{address}/purls" }
    private var createPURL: String      { "address/{address}/purl" }
    private var managePURL: String      { "address/{address}/purl/{purl}" }
    
    func addressPurls(_ address: String) -> URL {
        URL(string: replacingAddress(address, in: addressPURLs), relativeTo: baseURL)!
    }
    
    func createPurls(_ address: String) -> URL {
        URL(string: replacingAddress(address, in: createPURL), relativeTo: baseURL)!
    }
    
    func managePurl(for address: String, purl: String) -> URL {
        URL(string: replacingPurl(purl, in: replacingAddress(address, in: managePURL)), relativeTo: baseURL)!
    }
}
