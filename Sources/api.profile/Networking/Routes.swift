//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

extension URLConstructor {
    private var addressProfile: String { "address/{address}/web/" }
    private var addressPhoto: String { "address/{address}/pfp/" }
    
    public func addressProfile(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressProfile), relativeTo: baseURL)!
    }
    
    public func addressPhoto(address: String) -> URL {
        URL(string: replacingAddress(address, in: addressPhoto), relativeTo: baseURL)!
    }
}
