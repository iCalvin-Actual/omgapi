//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

public struct BlogConfigurationResponse: CommonAPIResponse {
    private struct Config: Response {
        let raw: String
    }
    public let message: String?
    private let configuration: Config
    
    
    public var rawConfiguration: String { configuration.raw }
}

public struct BlogTemplateResponse: CommonAPIResponse {
    public let message: String?
    public let template: String?
}

public struct BlogEntriesResponse: CommonAPIResponse {
    public let message: String?
    public let entries: [WeblogEntry]
}

public struct BlogEntryResponse: CommonAPIResponse {
    public let message: String?
    public let post: WeblogEntry?
}
