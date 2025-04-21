//
//  NowGarden.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A single entry in the omg.lol Now Garden.
///
/// Represents a public Now page listed in the Now Garden.
public struct NowGardenEntry: Sendable {
    /// The omg.lol address associated with this entry.
    public let address: AddressName

    /// The public URL of the Now page.
    public let url: String

    /// The timestamp indicating when the Now page was last updated.
    public let updated: TimeStamp
}

/// A collection of entries in the Now Garden.
public typealias NowGarden = [NowGardenEntry]
