//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import Foundation

public struct TimeStamp: Codable {
    private let message: String?
    private let unixEpochTime: String
    
    public init(_ date: Date) {
        self.message = nil
        self.unixEpochTime = String(date.timeIntervalSince1970)
    }
    
    public static var now: TimeStamp { .init(.now) }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        
        do {
            self.unixEpochTime = try container.decode(String.self, forKey: .unixEpochTime)
        } catch {
            self.unixEpochTime = "\(try container.decode(Int.self, forKey: .unixEpochTime))"
        }
    }
}

public extension TimeStamp {
    var date: Date {
        Date(timeIntervalSince1970: Double(unixEpochTime) ?? 0)
    }
}
