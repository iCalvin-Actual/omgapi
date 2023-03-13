//
//  NowGarden.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct NowGardenEntry {
    public let address: AddressName
    public let url: String
    public let updated: TimeStamp
}

public typealias NowGarden = [NowGardenEntry]
