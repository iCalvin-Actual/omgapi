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
        let title: String
        let content: String
    }
    
    let title: String
    let author: String
    let content: String
    let modifiedOn: Date
    let listed: Bool
    
}

public typealias PasteBin = [Paste]
