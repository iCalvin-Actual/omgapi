//
//  Pic.swift
//  omgapi
//
//  Created by Calvin Chestnut on 10/24/24.
//

import Foundation

public struct Pic: Sendable {
    let id: String
    
    let address: String
    
    let created: Date
    
    let size: Double
    let mime: String
    let exif: [String: String]
    let description: String
    
    init(id: String, address: String, created: Date, size: Double, mime: String, exif: [String : String], description: String) {
        self.id = id
        self.address = address
        self.created = created
        self.size = size
        self.mime = mime
        self.exif = exif
        self.description = description
    }
}
