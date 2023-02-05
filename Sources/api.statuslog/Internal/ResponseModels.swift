//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

struct AddressStatusModel: Response {
    
    let id: String
    let address: AddressName
    let created: String
    
    let content: String
    let emoji: String?
    let externalURL: URL?
    
    var createdDate: Date {
        Date(timeIntervalSince1970: Double(created) ?? 0)
    }
}

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
    let status: AddressStatusModel
}

struct StatusLogResponseModel: CommonAPIResponse {
    let message: String?
    let statuses: [AddressStatusModel]
}
