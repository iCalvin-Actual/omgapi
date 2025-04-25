//
//  Pic.swift
//  omgapi
//
//  Created by Calvin Chestnut on 10/24/24.
//


import Foundation

public typealias PicReel = [Pic]

/// Represents a Pic uploaded to omg.lol, including metadata and ownership information.
public struct Pic: Sendable {
    /// Unique identifier for the Pic.
    let id: String
    
    /// The omg.lol address that owns the Pic.
    let address: AddressName
    
    /// The date and time the Pic was created.
    let created: Date
    
    /// The size of the Pic in bytes.
    let size: Double
    /// The MIME type of the Pic (e.g., "image/png").
    let mime: String
    /// EXIF metadata extracted from the image.
    let exif: [String: String]
    /// The description associated with the Pic.
    let description: String
    
    /// Creates a new `Pic` instance from its metadata components.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Pic.
    ///   - address: The address that owns the Pic.
    ///   - created: The creation date of the Pic.
    ///   - size: The image size in bytes.
    ///   - mime: The MIME type of the image.
    ///   - exif: EXIF metadata from the image.
    ///   - description: A user-provided description of the Pic.
    init(id: String, address: AddressName, created: Date, size: Double, mime: String, exif: [String : String], description: String) {
        self.id = id
        self.address = address
        self.created = created
        self.size = size
        self.mime = mime
        self.exif = exif
        self.description = description
    }
}

extension Pic {
    /// A draft representation of a Pic object.
    ///
    /// Includes a description and tags for the image.
    public struct Draft: omgapi.Draft {
        public let description: String
        public let tags: String
    }
}
