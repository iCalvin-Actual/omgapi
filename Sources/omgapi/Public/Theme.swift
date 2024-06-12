//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 6/7/23.
//

import Foundation

public struct Theme: Sendable {
    public let id: String
    public let name: String
    
    public let created: String
    public let updated: String
    
    public let author: String
    public let authorUrl: String
    public let version: String
    public let license: String
    
    public let description: String
    
    public let previewCss: String

}
