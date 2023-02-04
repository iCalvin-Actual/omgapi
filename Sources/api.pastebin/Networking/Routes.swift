//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

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
