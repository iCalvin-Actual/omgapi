//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import Foundation

struct DNSRecord {
    
    struct New {
        let id: Int?
        let type: String?
        let ttl: Int?
        let name: String?
        let content: String?
    }
    
    
    let id: Int
    let name: String
    let content: String
    let tty: Int
    let type: String
    let createdAt: String
    let updatedAt: String
}

struct EditDNSResponse {
    struct Data {
        let data: DNSRecord
    }
    let message: String?
    let dataSent: DNSRecord.New
    let responseReceived: Data
}
