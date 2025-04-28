//
//  Paste.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// An typealias for an array collection of `Paste` instances.
public typealias PasteBin = [Paste]

/// A piece of plain text content exposed behind a short title
///
/// Addresses post Paste to share large or repeating chunks of text, to reference changing data, and many other things.
///
/// Pastes consist of a title and content, alongside other metadata.
public struct Paste: Sendable {
    /// The title of the post and path the the public URL
    public let title: String

    /// The Address that published the `Paste`
    public let author: String

    /// The longform text content shared by the author..
    public let content: String

    /// The date the paste was last modified.
    public let modifiedOn: Date

    /// Whether the paste is publicly listed.
    public let listed: Bool
}

extension Paste {
    /// A draft representation of a ``Paste``.
    public struct Draft: MDDraft {
        
        /// Unique identifier for this `Paste`.
        ///
        /// Pass an existing value to update, or pass a new value to create.
        public let title: String
        
        /// The text content to store under the given title
        public let content: String
        
        /// Indicates whether to  the server should return this `Paste` without a valid `APICredential`.
        public let listed: Bool
        
        public init(title: String, content: String, listed: Bool) {
            self.title = title
            self.content = content
            self.listed = listed
        }
    }
}
