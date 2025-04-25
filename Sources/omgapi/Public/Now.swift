//
//  Now.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A collection of entries in the Now Garden.
public typealias NowGarden = [Now.Reference]

public struct Now {
    /// The omg.lol address associated with this now entry.
    public let address: AddressName

    /// The content of the now entry (typically plain text or markdown).
    public let content: String

    /// Whether the entry is publicly listed.
    public let listed: Bool

    /// The last updated time of the now entry.
    public let updated: Date
}

extension Now {
    /// Represents the rendered Now page for an omg.lol address.
    public struct Page: Sendable {
        /// The omg.lol address for which this page is rendered.
        public let address: AddressName

        /// The HTML or rendered content of the Now page.
        public let content: String
    }
    
    /// A single entry in the omg.lol Now Garden.
    ///
    /// Represents a public Now page listed in the Now Garden.
    public struct Reference: Sendable {
        /// The omg.lol address associated with this entry.
        public let address: AddressName
        
        /// The public URL of the Now page.
        public let url: String
        
        /// The timestamp indicating when the Now page was last updated.
        public let updated: Date
    }
}

extension Now {
    /// A draft version of a Now entry, used when creating or updating content.
    ///
    /// Includes the content body and a flag indicating whether the entry should be listed publicly.
    public struct Draft: MDDraft {
        public let content: String
        public let listed: Bool
        
        public init(content: String, listed: Bool) {
            self.content = content
            self.listed = listed
        }
    }
}
