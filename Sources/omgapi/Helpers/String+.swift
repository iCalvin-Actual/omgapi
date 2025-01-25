//
//  String+.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

extension Optional<String> {
    var boolValue: Bool {
        self?.boolValue ?? false
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

extension String {
    func replacingEmail(_ address: String) -> String {
        replacingOccurrences(of: "{email}", with: address)
    }
    func replacingAddress(_ address: String) -> String {
        replacingOccurrences(of: "{address}", with: address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? address)
    }
    func replacingPaste(_ paste: String) -> String {
        replacingOccurrences(of: "{paste}", with: paste)
    }
    func replacingPURL(_ purl: String) -> String {
        replacingOccurrences(of: "{purl}", with: purl)
    }
    func replacingStatus(_ status: String) -> String {
        replacingOccurrences(of: "{status}", with: status)
    }
    func replacingTarget(_ target: String) -> String {
        replacingOccurrences(of: "{target}", with: target)
    }
    func replacingExtension(_ ext: String) -> String {
        replacingOccurrences(of: "{ext}", with: ext)
    }
}

