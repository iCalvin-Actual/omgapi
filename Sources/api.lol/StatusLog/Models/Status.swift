//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

protocol Status {
    var content: String { get }
    var emoji: String? { get }
    var externalUrl: String? { get }
}

struct AddressStatus: Status {
    let id: Int
    let address: String
    let created: Int
    
    let content: String
    let emoji: String?
    let externalUrl: String?
}

struct DraftStatus: Status {
    let content: String
    let emoji: String?
    let externalUrl: String?
}
