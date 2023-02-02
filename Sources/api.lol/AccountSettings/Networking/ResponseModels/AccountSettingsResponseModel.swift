//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

struct AccountSettingsResponseModel: CommonAPIResponse {
    let message: String?
    
    let settings: AccountSettings
}
