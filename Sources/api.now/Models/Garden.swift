//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

struct NowGarden: CommonAPIResponse {
    struct Now: Response {
        let address: String
        let url: String
        let updated: TimeStamp
    }
    let message: String?
    let garden: [Now]
}
