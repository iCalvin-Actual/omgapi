//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import Foundation

public extension String {
    func replacingEmail(_ address: String) -> String {
        replacingOccurrences(of: "{email}", with: address)
    }
    func replacingAddress(_ address: String) -> String {
        replacingOccurrences(of: "{address}", with: address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? address)
    }
}

public extension Optional<String> {
    var boolValue: Bool {
        self?.boolValue ?? false
    }
}
public extension String {
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
