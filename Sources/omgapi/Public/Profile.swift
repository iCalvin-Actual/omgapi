//
//  Profile.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents an Address' complete profile
public struct Profile: Sendable {
    /// Structure contains the public webpage content for a given `AddressName`
    public struct Page: Sendable {
        /// The omg.lol address the profile belongs to.
        public let address: String

        /// The raw HTML response of the Address' profile page
        public let content: String?
    }
    
    /// The omg.lol address the profile belongs to.
    public let address: String

    /// The raw markdown of the profile page.
    public let content: String

    /// The slug of the selected `Theme` for displaying the profile.
    public let theme: String

    /// Optional HTML to be injected into the `<head>` section of the rendered page.
    public let head: String?

    /// Optional custom CSS to apply to the profile.
    public let css: String?
}

extension Profile {
    /// A draft profile used for updating omg.lol profile content.
    public struct Draft: MDDraft {
        /// New markdown content to apply to the profile page.
        public let content: String
        /// Indicates whether to publish immediately or save as an external draft.
        public let publish: Bool
    }
}
