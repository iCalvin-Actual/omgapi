//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

public struct NowGardenEntry {
    public let address: AddressName
    public let url: String
    public let updated: TimeStamp
}

public typealias NowGarden = [NowGardenEntry]
