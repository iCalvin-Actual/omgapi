//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension URLConstructor {
    private let address: String { "path/" }
    
    var address: URL {
        URL(string: address, relativeTo: baseURL)
    }
}
