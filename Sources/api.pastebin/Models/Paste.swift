//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation


public struct Paste {
    public struct Draft: RequestBody {
        public let title: String
        public let content: String
    }
    
    public let title: String
    public let author: String
    public let content: String
    public let modifiedOn: Date
    public let listed: Bool
    
}

public typealias PasteBin = [Paste]
