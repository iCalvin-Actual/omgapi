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
