//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension URLConstructor {
    private var addressPURLs: String    { "address/{address}/purls" }
    private var createPURL: String      { "address/{address}/purl" }
    private var managePURL: String      { "address/{address}/purl/{purl}" }
    
    func addressPurls(_ address: String) -> URL {
        URL(string: replacingAddress(address, in: addressPURLs), relativeTo: baseURL)!
    }
    
    func createPurls(_ address: String) -> URL {
        URL(string: replacingAddress(address, in: createPURL), relativeTo: baseURL)!
    }
    
    func managePurl(for address: String, purl: String) -> URL {
        URL(string: replacingPurl(purl, in: replacingAddress(address, in: managePURL)), relativeTo: baseURL)!
    }
}
