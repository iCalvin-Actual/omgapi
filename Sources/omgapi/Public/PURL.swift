//
//  PURL.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A collection of PURL instances
public typealias PURLs = [PURL]

/// Represents a Persistent URL (PURL) associated with an omg.lol address.
public struct PURL: Sendable {
    /// The omg.lol address that owns the PURL.
    public let address: AddressName

    /// The name or identifier of the PURL.
    public let name: String

    /// The destination URL the PURL redirects to.
    public let url: String

    /// The number of times the PURL has been accessed.
    public let counter: Int

    /// Whether the PURL is publicly listed.
    public let listed: Bool
}

extension PURL {
    /// A draft representation of a PURL record.
    ///
    /// Includes the PURL name, target URL, and listing visibility.
    public struct Draft: MDDraft {
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
