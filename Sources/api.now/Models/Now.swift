//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

struct Now: Decodable {
    let content: String
    let updated: String
    let listed: String
    
    var isPublic: Bool {
        listed.boolValue
    }
}

extension String {
    var boolValue: Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y":
            return true
        case "false", "f", "no", "n", "":
            return false
        default:
            if let int = Int(self) {
                return int != 0
            }
            return false
        }
    }
}

