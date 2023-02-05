//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation


enum PasteBinPath: APIPath {
    private static let addressPastes = "address/{address}/pastebin/"
    private static let addressPaste = "address/{address}/pastebin/{paste}/"
    
    case paste(_ title: String, address: AddressName)
    case pastes(_ address: AddressName)
    
    var string: String {
        switch self {
        case .paste(let title, address: let address):
            return Self.addressPaste.replacingPaste(title).replacingAddress(address)
        case .pastes(let address):
            return Self.addressPastes.replacingAddress(address)
            
        }
    }
}

extension APIURLConstructor {
    private var addressPastes: String   { "address/{address}/pastebin/" }
    private var addressPaste: String    { "address/{address}/pastebin/{paste}" }
    
    func addressPastes(for address: String) -> URL {
        URL(string: replacingAddress(address, in: addressPastes), relativeTo: baseURL)!
    }
    
    func addressPaste(paste: String, in address: String) -> URL {
        URL(string: replacingAddress(address, in: replacingPaste(paste, in: addressPaste)), relativeTo: baseURL)!
    }
}
