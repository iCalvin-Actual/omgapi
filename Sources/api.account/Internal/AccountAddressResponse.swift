//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

public struct AccountAddressResponse: Response {
    public let message: String?
    public let address: String
    public let registration: TimeStamp
}

public typealias AddressCollection = [AccountAddressResponse]
extension AddressCollection: Response { }

