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
        let name: String
        let url: String
    }
    
    func getPurls(for address: String) -> URLRequest {
        request(with: urlConstructor.addressPurls(address))
    }
    
    func createPurl(name: String, url: String, for account: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.createPurls(account), bodyParameters: Parameters(name: name, url: url))
    }
    
    func getPurl(purl: String, from account: String) -> URLRequest {
        request(with: urlConstructor.managePurl(for: account, purl: purl))
    }
    
    func updatePurl(purl: String, name: String, url: String, from account: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.managePurl(for: account, purl: purl), bodyParameters: Parameters(name: name, url: url))
    }
    
    func deletePurl(purl: String, from account: String) -> URLRequest {
        request(method: .DELETE, with: urlConstructor.managePurl(for: purl, purl: account))
    }
}
