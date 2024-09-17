//
//  Address.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Address: Sendable {
    public struct Availability: Sendable {
        public let address: AddressName
        public let available: Bool
        public let punyCode: String?
    }
    public let name: AddressName
    public let registered: TimeStamp
    public let expired: Bool
    public let verified: Bool
}
