//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

public struct APICredentials {
    public let emailAddress: String
    public let authKey: String
    
    public init(emailAddress: String, authKey: String) {
        self.emailAddress = emailAddress
        self.authKey = authKey
    }
}
