//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension APIRequestConstructor {
    private struct Parameters: Encodable {
        let title: String
        let content: String
    }
    func getPastes(from address: String) -> URLRequest {
        request(with: urlConstructor.addressPastes(for: address))
    }
    
    func newPaste(from address: String, title: String, content: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.addressPastes(for: address), bodyParameters: Parameters(title: title, content: content))
    }
    
    func getPaste(title: String, from address: String) -> URLRequest {
        request(with: urlConstructor.addressPaste(paste: title, in: address))
    }
    
    func deletePaste(title: String, from address: String) -> URLRequest {
        request(method: .DELETE, with: urlConstructor.addressPaste(paste: title, in: address))
    }
}
