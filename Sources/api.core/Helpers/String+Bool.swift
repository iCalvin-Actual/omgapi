//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import Foundation

public extension Optional<String> {
    var boolValue: Bool {
        guard let self = self else {
            return false
        }
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
