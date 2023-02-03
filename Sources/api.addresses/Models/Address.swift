//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

struct AccountAddress: Response {
    let message: String?
    let address: String
    let registration: TimeStamp
}

typealias AddressCollection = [AccountAddress]
extension AddressCollection: Response { }

