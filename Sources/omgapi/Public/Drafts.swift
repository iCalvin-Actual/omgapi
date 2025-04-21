//
//  Drafts.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A base protocol for all data types that can be submitted to the omg.lol API as a draft.
///
/// Types conforming to `Draft` are encodable and safe for concurrent use.
protocol Draft: RequestBody, Sendable {
}

/// A shared protocol for all markdown-like draft types sent to the omg.lol API.
///
/// Types conforming to `MDDraft` include a content body and are safe for concurrent use.
/// Used for posting or updating resources like statuses, profiles, Now entries, pastes, and PURLs.
protocol MDDraft: Draft {
    var content: String { get }
}

public extension Status {
    /// A draft representation of a status update.
    ///
    /// Includes optional `id`, message content, emoji, and external URL.
    struct Draft: MDDraft {
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

public extension Now {
    /// A draft version of a Now entry, used when creating or updating content.
    ///
    /// Includes the content body and a flag indicating whether the entry should be listed publicly.
    struct Draft: MDDraft {
        public let content: String
        public let listed: Bool
        
        public init(content: String, listed: Bool) {
            self.content = content
            self.listed = listed
        }
    }
}

public extension Paste {
    /// A draft representation of a Pastebin entry.
    ///
    /// Includes the title, content body, and listing visibility.
    struct Draft: MDDraft {
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

public extension PURL {
    /// A draft representation of a PURL record.
    ///
    /// Includes the PURL name, target URL, and listing visibility.
    struct Draft: MDDraft {
        public let name: String
        public let content: String
        public let listed: Bool
        
        enum CodingKeys: String, CodingKey {
            case name
            case content = "url"
            case listed
        }
        
        public init(name: String, content: String, listed: Bool) {
            self.name = name
            self.content = content
            self.listed = listed
        }
    }
}

public extension Profile {
    /// A draft profile used for updating omg.lol profile content.
    ///
    /// Includes the content body and a flag indicating whether it should be published.
    struct Draft: MDDraft {
        public let content: String
        public let publish: Bool
    }
}

public extension StatusLog.Bio {
    /// A draft representation of a statuslog bio.
    ///
    /// Contains only the content string.
    struct Draft: MDDraft {
        public let content: String
    }
}

public extension Pic {
    /// A draft representation of a Pic object.
    ///
    /// Includes a description and tags for the image.
    struct Draft: omgapi.Draft {
        public let description: String
        public let tags: String
    }
}
