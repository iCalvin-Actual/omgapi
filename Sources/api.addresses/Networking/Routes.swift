//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

enum AddressPath: APIPath {
    private static let addressDirectory = "directory/"
    private static let addressAvailability = "address/{address}/availability/"
    private static let addressExpiration = "address/{address}/expiration/"
    private static let addressInfo = "address/{address}/info/"
    
    case directory
    case availability   (_ address: String)
    case expiration     (_ address: String)
    case info           (_ address: String)
    
    var string: String {
        switch self {
        case .directory:
            return Self.addressDirectory
        case .availability(let address):
            return Self.addressAvailability.replacingAddress(address)
        case .expiration(let address):
            return Self.addressExpiration.replacingAddress(address)
        case .info(let address):
            return Self.addressInfo.replacingAddress(address)
        }
    }
}
