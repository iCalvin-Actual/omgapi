//
//  Status.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

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
