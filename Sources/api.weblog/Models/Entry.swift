//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

public struct WeblogEntry: Response {
    public struct Draft: RequestBody {
        public let entryName: String
        public let content: String
        
        public init(entryName: String = UUID().uuidString, content: String) {
            self.entryName = entryName
            self.content = content
        }
    }
    public let address: String
    public let location: String
    
    public let title: String
    public let date: String
    public let type: String
    public let status: String
    public let source: String
    
    public let body: String
    public let output:String
    
    public let metadata: String
    public let entry: String
}
