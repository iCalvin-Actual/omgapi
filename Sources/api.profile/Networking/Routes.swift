//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation


enum ProfilePath: APIPath {
    private static let addressProfile = "address/{address}/web/"
    private static let addressPhoto = "address/{address}/pfp"
    
    case profile(_ address: AddressName)
    case photo(_ address: AddressName)
    
    var string: String {
        switch self {
        case .profile(let address):
            return Self.addressProfile.replacingAddress(address)
        case .photo(let address):
            return Self.addressPhoto.replacingAddress(address)
        }
    }
}

extension APIURLConstructor {
    private var addressProfile: String { "address/{address}/web/" }
    private var addressPhoto: String { "address/{address}/pfp/" }
    
    public func addressProfile(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressProfile), relativeTo: baseURL)!
    }
    
    public func addressPhoto(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressPhoto), relativeTo: baseURL)!
    }
}
