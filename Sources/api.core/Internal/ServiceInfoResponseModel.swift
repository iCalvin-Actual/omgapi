//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

struct ServiceInfoResponse: CommonAPIResponse {
    let message: String?
    let members: String
    let addresses: String
    let profiles: String
}
