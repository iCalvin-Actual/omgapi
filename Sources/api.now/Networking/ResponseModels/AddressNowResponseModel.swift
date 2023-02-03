//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

struct AddressNowResponseModel: CommonAPIResponse {
    let message: String?
    let now: Now
}
