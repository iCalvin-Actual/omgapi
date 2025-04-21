//
//  Now.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents a "now" status entry for an omg.lol address.
public struct Now: Sendable {
    /// The omg.lol address associated with this now entry.
    public let address: AddressName

    /// The content of the now entry (typically plain text or markdown).
    public let content: String

    /// Whether the entry is publicly listed.
    public let listed: Bool

    /// The last updated time of the now entry.
    public let updated: Date
}

/// Represents the rendered Now page for an omg.lol address.
public struct NowPage: Sendable {
    /// The omg.lol address for which this page is rendered.
    public let address: AddressName

    /// The HTML or rendered content of the Now page.
    public let content: String
}
