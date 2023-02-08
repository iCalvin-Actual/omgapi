//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

public struct Address {
    public let name: AddressName
    public let registered: TimeStamp
    public let expired: Bool
    public let verified: Bool
}
