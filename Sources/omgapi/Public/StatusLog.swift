//
//  StatusLog.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct PublicLog {
    public let statuses: [Status]
}

public struct StatusLog {
    public struct Bio {
        public let content: String
    }
    
    public let address: AddressName
    public let bio: Bio
    public let statuses: [Status]
}
