//
//  File 2.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension APIRequestConstructor {
    public func fetchNow(for address: String) -> URLRequest {
        request(with: urlConstructor.addressNow(address))
    }
    
    public func updateNow(for address: String, content: String, listed: Bool) -> URLRequest {
        struct Parameters: Encodable {
            let content: String
            let listed: Bool
        }
        return request(method: .POST, with: urlConstructor.addressNow(address), bodyParameters: Parameters(content: content, listed: listed))
    }
}

extension APIRequestConstructor {
    public func getNowGarden() -> URLRequest {
        request(with: urlConstructor.nowGarden())
    }
}
