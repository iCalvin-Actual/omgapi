//
//  Now.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Now: Sendable {
    public let address: AddressName
    public let content: String
    public let listed: Bool
    
    public let updated: Date
}

public struct NowPage: Sendable {
    public let address: AddressName
    public let content: String
}
