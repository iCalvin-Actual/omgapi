//
//  File.swift
//
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

struct AddressDirectoryResponse: CommonAPIResponse {
    let message: String?
    let url: String
    let directory: [AddressName]
}
