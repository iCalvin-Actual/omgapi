//
//  PURL.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// An typealias for an array collection of `PURL` instances. 
public typealias PURLs = [PURL]

/// A Persistent URL (PURL) hosted by an omg.lol address.
///
/// PURLs are helpful little things. Similar to how the /now page is a predictable /url where you may expect to see updated content, a purl allows you to specify any path name, and redirect a HTTPRequest to that URL.
///
/// The `PURL` model exposes data about the PURL itself, including meta-data about how many times the redirect has been followed.
public struct PURL: Sendable {
    /// The omg.lol address that owns the PURL.
    public let address: AddressName

    /// The identifier of the PURL, unique to this `AddressName`
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
    public struct Draft: MDDraft {
        /// Unique identifier for this `PURL`.
        ///
        /// Pass an existing value to update, or pass a new value to create.
        public let name: String
        
        /// The target URL to direct to, as a `String`
        public let content: String
        
        /// Indicates whether to  the server should return this `PURL` without a valid `APICredential`.
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
