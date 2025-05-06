//
//  Pic.swift
//  omgapi
//
//  Created by Calvin Chestnut on 10/24/24.
//


import Foundation

/// A collection of published ``Pic`` instances
public typealias PicReel = [Pic]

/// An image file hosted by an `Address` on omg.lol.
///
/// `Pics` give an extra view into the life behind an `Address`, images are accessible with a description text by default, and include other metadata about the photo, so be careful what you share.
public struct Pic: Sendable {
    /// Unique identifier for the `Pic`.
    public let id: String
    
    /// The accessability description that accompanies the image.
    public let description: String
    
    /// The omg.lol `Address` that published the image
    public let address: AddressName
    
    /// The date and time the image was created.
    public let created: Date
    
    /// The size of the image in bytes.
    public let size: Double
    /// The MIME type of the Pic (e.g., "image/png").
    public let mime: String
    /// EXIF metadata extracted from the image.
    public let exif: [String: String]
    
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
