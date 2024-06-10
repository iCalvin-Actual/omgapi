//
//  Status.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Status: Sendable {
    public let id: String
    public let address: AddressName
    public let created: Date
    
    public let content: String
    public let emoji: String?
    public let externalURL: URL?
}
