//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

struct StatusLogBioResponseModel: CommonAPIResponse {
    let message: String?
    let bio: String?
    let css: String?
}

struct NewStatusResponseModel: CommonAPIResponse {
    let message: String?
    let id: String
    let status: String
    let url: String
    let externalUrl: String?
}

struct StatusResponseModel: CommonAPIResponse {
    let message: String?
    let status: AddressStatus
}

struct StatusLogResponseModel: CommonAPIResponse {
    let message: String?
    let statuses: [AddressStatus]
}
