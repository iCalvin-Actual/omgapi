//
//  Status.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public typealias StatusLog = [Status]

/// A short bio associated with the omg.lol address.
public struct AddressBio: Sendable {
    public struct Bio: Sendable {
    }
    /// The textual content of the bio.
    public let content: String
}

/// Represents a status post from the omg.lol statuslog.
public struct Status: Sendable {
    /// A unique identifier for the status entry.
    public let id: String

    /// The omg.lol address that created the status.
    public let address: AddressName

    /// The date and time the status was posted.
    public let created: Date

    /// The main textual content of the status.
    public let content: String

    /// An optional emoji representing the status.
    public let emoji: String?

    /// An optional external URL associated with the status.
    public let externalURL: URL?
}

extension AddressBio {
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


