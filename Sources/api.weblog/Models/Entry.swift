//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

public struct WeblogEntry: Response {
    let address: String
    let location: String
    
    let title: String
    let date: String
    let type: String
    let status: String
    let source: String
    
    let body: String
    let output:String
    
    let metadata: String
    let entry: String
}

public struct DraftBlogEntry: Encodable {
    let entryName: String
    let content: String
    
    init(entryName: String = UUID().uuidString, content: String) {
        self.entryName = entryName
        self.content = content
    }
}
