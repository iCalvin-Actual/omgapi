//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

enum NowPath: APIPath {
    private static let addressNow = "address/{address}/now/"
    private static let nowGarden = "now/garden/"
    
    case garden
    case now(address: AddressName)
    
    var string: String {
        switch self {
        case .garden:
            return Self.nowGarden
        case .now(let address):
            return Self.addressNow.replacingAddress(address)
        }
    }
}
