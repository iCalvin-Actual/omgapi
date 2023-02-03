//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

private let now = "address/{address}/now/"
/*
GET
Auth: No
Body: None
Response: [
message: String?
now: AddressNow
]

POST
Auth: Yes
Body: [
content: String
listed: Bool
]
Response: BasicResponse
*/

private let nowGarden = "now/garden/"
/*
GET
Auth: No
Body: None
Response: [
message: String?
garden: [
 address: String
 url: String
 updated: TimeStamp
]
]
*/

extension URLConstructor {
    private var addressNow: String  { "address/{address}/now/" }
    private var garden: String      { "now/garden/" }
    
    public func addressNow(_ address: String) -> URL {
        URL(string: replacingAddress(address, in: addressNow), relativeTo: baseURL)!
    }
    
    public func nowGarden() -> URL {
        URL(string: garden, relativeTo: baseURL)!
    }
}
