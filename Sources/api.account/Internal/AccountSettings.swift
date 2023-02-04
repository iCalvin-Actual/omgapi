//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core

internal struct AccountSettings: CommonAPIResponse {
    struct Settings: Response {
        let communication: CommunicationPreference?
        
    //    Not yet ready, server not accepting values it returns
    //    let dateFormat: DatePreference?
    }
    let message: String?
    let settings: Settings
    
    var communication: CommunicationPreference? { settings.communication }
}
