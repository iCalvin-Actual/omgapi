//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import api_core

struct AccountSettings {
    let communication: CommunicationPreference?
    
//    Not yet ready, server not accepting values it returns
//    let dateFormat: DateFormat?
}

enum CommunicationPreference: String, Response, Encodable {
    case email_not_ok
    case email_ok
}

extension AccountSettings: Codable { }
