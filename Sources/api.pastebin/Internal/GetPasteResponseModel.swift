//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation


struct PasteResponseModel: CommonAPIResponse {
    struct Paste: Response {
        let title: String
        let content: String
        let modifiedOn: Int?
        let listed: String?
        
        var isPublic: Bool {
            listed.boolValue
        }
        
        var updated: Date {
            let double = Double(modifiedOn ?? 0)
            return Date(timeIntervalSince1970: double)
        }
    }
    let message: String?
    let paste: Paste
}

struct NewPasteResponseModel: CommonAPIResponse {
    let message: String?
    let title: String
}
