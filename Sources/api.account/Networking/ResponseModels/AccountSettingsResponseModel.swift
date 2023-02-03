//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core

struct AccountSettingsResponseModel: CommonAPIResponse {
    let message: String?
    
    let settings: AccountSettings
}
