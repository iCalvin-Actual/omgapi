//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core

struct AccountInfoResponseModel: CommonAPIResponse {
    let message: String?
    
    let email: String
    let created: TimeStamp
    let settings: AccountSettings
}
