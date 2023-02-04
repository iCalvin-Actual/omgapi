//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

struct GetPURLsResponseModel: CommonAPIResponse {
    let message: String?
    let purls: [AccountPURL]
}

struct GetPURLResponseModel: CommonAPIResponse {
    let message: String?
    let purl: AccountPURL
}

struct UpdatePURLResponseModel: CommonAPIResponse {
    let message: String?
    let name: String
    let url: String
}
