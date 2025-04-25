//
//  Paste.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A collection of pastebin entries.
public typealias PasteBin = [Paste]

/// Represents a single pastebin entry associated with an omg.lol address.
public struct Paste: Sendable {
    /// The title or identifier of the paste.
    public let title: String

    /// The author or owner of the paste.
    public let author: String

    /// The raw content of the paste.
    public let content: String

    /// The date the paste was last modified.
    public let modifiedOn: Date

    /// Whether the paste is publicly listed.
    public let listed: Bool
}

extension Paste {
    /// A draft representation of a Pastebin entry.
    ///
    /// Includes the title, content body, and listing visibility.
    public struct Draft: MDDraft {
        public let title: String
        public let content: String
        public let listed: Bool
        
        public init(title: String, content: String, listed: Bool) {
            self.title = title
            self.content = content
            self.listed = listed
        }
    }
}
