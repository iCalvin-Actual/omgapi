//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core
import Foundation

struct Address {
    let name: AddressName
    let registered: TimeStamp
    let expired: Bool
    let verified: Bool
}
