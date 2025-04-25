//
//  Profile.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents a public view of an omg.lol Address profile
public struct PublicProfile: Sendable {
    /// The omg.lol address the profile belongs to.
    public let address: String

    /// The published content of the profile, if available.
    public let content: String?
}

/// Represents an Address' complete profile
public struct Profile: Sendable {
    /// The omg.lol address the profile belongs to.
    public let address: String

    /// The raw content of the profile (typically markdown).
    public let content: String

    /// The selected theme for displaying the profile.
    public let theme: String

    /// Optional HTML to be injected into the `<head>` section.
    public let head: String?

    /// Optional custom CSS to apply to the profile.
    public let css: String?
}

extension Profile {
    /// A draft profile used for updating omg.lol profile content.
    ///
    /// Includes the content body and a flag indicating whether it should be published.
    public struct Draft: MDDraft {
        public let content: String
        public let publish: Bool
    }
}
