//
//  Status.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A series of moments in the `omg.lol` community.
public typealias StatusLog = [Status]

/// A brief biography associated with an omg.lol `AddressName`.
public struct Bio: Sendable {
    /// The textual content of the bio, as a Markdown `String`
    public let content: String
}

/// A public post on the omg.lol micro-blogging service, statuslog.
///
/// A Status post lives on the web as a public post, and in the API in the public statuslog and the Address' personal statuslog. 
public struct Status: Sendable {
    /// A unique identifier for the status entry.
    public let id: String

    /// The omg.lol `AddressName` that created the `Status`.
    public let address: AddressName

    /// The date the `Status` was first posted.
    public let created: Date

    /// The main content of the `Status` as a markdown `String`
    public let content: String

    /// An emoji `String` accompanying a `Status` post.
    ///
    /// Expected to be a single emoji unicode character, but some posts may unexpectedly contain a larger `String` value.
    public let emoji: String?

    /// An external link to the post on a federated service, if the Address has enabled cross-posting.
    public let externalURL: URL?
}

extension Bio {
    /// A draft representation of a statuslog bio.
    ///
    /// Contains only the content string.
    public struct Draft: MDDraft {
        public let content: String
    }
}

extension Status {
    /// A draft representation of a status update.
    ///
    /// Includes optional `id`, message content, emoji, and external URL.
    public struct Draft: MDDraft {
        public let id: String?
        public let content: String
        public let emoji: String?
        public let externalUrl: String?
        
        public init(id: String? = nil, content: String, emoji: String? = nil, externalUrl: String? = nil) {
            self.id = id
            self.content = content
            self.emoji = emoji
            self.externalUrl = externalUrl
        }
    }
}


