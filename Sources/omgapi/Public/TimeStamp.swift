//
//  Models.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct TimeStamp: Codable, Sendable {
    public let message: String?
    public let date: Date
    
    private enum CodingKeys: String, CodingKey {
        case message
        case epoch = "unixEpochTime"
    }
    
    public init(_ date: Date) {
        self.message = nil
        self.date = date
    }
    
    public static var now: TimeStamp { .init(.now) }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        
        let epochString: String?
        do {
            epochString = try container.decode(String.self, forKey: .epoch)
        } catch {
            epochString = "\(try container.decode(Int.self, forKey: .epoch))"
        }
        if let epochString = epochString {
            self.date = Date(timeIntervalSince1970: Double(epochString) ?? 0)
        } else {
            self.date = Date()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        let epoch = date.timeIntervalSince1970
        try container.encode("\(epoch)", forKey: .epoch)
    }
}

