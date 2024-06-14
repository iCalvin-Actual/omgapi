//
//  Drafts.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

protocol MDDraft: RequestBody, Sendable {
    var content: String { get }
}

public extension Status {
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
    struct Draft: MDDraft {
        public let name: String
        public let content: String
        public let listed: Bool
        
        public init(name: String, content: String, listed: Bool) {
            self.name = name
            self.content = content
            self.listed = listed
        }
    }
}

public extension Profile {
    struct Draft: MDDraft {
        public let content: String
        public let publish: Bool
    }
}

public extension StatusLog.Bio {
    struct Draft: MDDraft {
        public let content: String
    }
}
