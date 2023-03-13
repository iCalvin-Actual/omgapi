//
//  Profile.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Profile {
    public let address: String
    
    public let content: String
    public let theme: String
    
    public let head: String?
    public let css: String?
}

public struct PublicProfile {
    public let address: String
    public let content: String?
}
