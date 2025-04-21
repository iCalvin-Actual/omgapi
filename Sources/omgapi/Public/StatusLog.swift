//
//  StatusLog.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A collection of public status entries from one or more omg.lol users.
public struct PublicLog: Sendable {
    /// The list of public status entries.
    public let statuses: [Status]
}

/// Represents the full status log for a specific omg.lol address,
/// including bio and associated status posts.
public struct StatusLog: Sendable {

    /// A short bio associated with the omg.lol address.
    public struct Bio: Sendable {
        /// The textual content of the bio.
        public let content: String
    }

    /// The omg.lol address associated with this log.
    public let address: AddressName

    /// The bio for the address owner.
    public let bio: Bio

    /// The list of status entries for the address.
    public let statuses: [Status]
}
