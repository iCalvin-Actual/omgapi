//
//  String+.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Useful extensions to `String`
extension String {
    /// Replaces the `{email}` token with the provided email address.
    ///
    /// - Parameter address: The email address to substitute.
    /// - Returns: A new string with `{email}` replaced.
    func replacingEmail(_ address: String) -> String {
        replacingOccurrences(of: "{email}", with: address)
    }

    /// Replaces the `{address}` token with a percent-encoded version of the provided address.
    ///
    /// - Parameter address: The omg.lol address to encode and substitute.
    /// - Returns: A new string with `{address}` replaced.
    func replacingAddress(_ address: String) -> String {
        replacingOccurrences(of: "{address}", with: address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? address)
    }

    /// Replaces the `{paste}` token with the provided paste title.
    ///
    /// - Parameter paste: The paste identifier or title to substitute.
    /// - Returns: A new string with `{paste}` replaced.
    func replacingPaste(_ paste: String) -> String {
        replacingOccurrences(of: "{paste}", with: paste)
    }

    /// Replaces the `{purl}` token with the provided PURL name.
    ///
    /// - Parameter purl: The PURL to substitute.
    /// - Returns: A new string with `{purl}` replaced.
    func replacingPURL(_ purl: String) -> String {
        replacingOccurrences(of: "{purl}", with: purl)
    }

    /// Replaces the `{status}` token with the provided status ID.
    ///
    /// - Parameter status: The status identifier to substitute.
    /// - Returns: A new string with `{status}` replaced.
    func replacingStatus(_ status: String) -> String {
        replacingOccurrences(of: "{status}", with: status)
    }
    /// Replaces the `{target}` token with the provided target string.
    ///
    /// - Parameter target: The target value to substitute.
    /// - Returns: A new string with `{target}` replaced.
    func replacingTarget(_ target: String) -> String {
        replacingOccurrences(of: "{target}", with: target)
    }
    /// Replaces the `{ext}` token with the provided file extension.
    ///
    /// - Parameter ext: The file extension to substitute.
    /// - Returns: A new string with `{ext}` replaced.
    func replacingExtension(_ ext: String) -> String {
        replacingOccurrences(of: "{ext}", with: ext)
    }

    /// Attempts to interpret the string as a boolean value.
    ///
    /// Accepts common forms like "true", "t", "yes", "1" as `true`, and "false", "f", "no", "0" as `false`.
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

/// Useful extensions to optional `String` values
extension Optional<String> {
    /// Attempts to unwrap and convert the optional string to a boolean value.
    ///
    /// Returns `false` if the optional is `nil` or cannot be interpreted as `true`.
    var boolValue: Bool {
        self?.boolValue ?? false
    }
}
