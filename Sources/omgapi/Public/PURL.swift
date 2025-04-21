//
//  PURL.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

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
