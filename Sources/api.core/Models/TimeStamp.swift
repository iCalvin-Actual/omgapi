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
    private let iso8601Time: String?
    private let rfc2822Time: String?
    private let relativeTime: String?
}

public extension TimeStamp {
    var date: Date {
        Date(timeIntervalSince1970: Double(unixEpochTime) ?? 0)
    }
}
