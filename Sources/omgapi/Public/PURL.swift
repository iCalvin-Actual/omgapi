//
//  PURL.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct PURL: Sendable {    
    public let address: AddressName
    public let name: String
    public let url: String
    
    public let counter: Int
    public let listed: Bool
}
