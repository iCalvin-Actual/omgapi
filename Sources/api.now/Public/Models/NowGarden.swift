//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

struct NowGardenEntry {
    let address: AddressName
    let url: String
    let updated: TimeStamp
}

typealias NowGarden = [NowGardenEntry]