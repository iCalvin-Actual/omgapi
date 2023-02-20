//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation


enum ProfilePath: WebPath {
    private static let addressProfile = "https://{address}.omg.lol"
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
