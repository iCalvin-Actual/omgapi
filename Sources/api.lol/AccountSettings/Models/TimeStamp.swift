//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import Foundation

enum DateFormat: String, Codable {
    case iso_8601
    case dmy
    case mdy
}

struct TimeStamp: Codable {
    let message: String?
    let unixEpochTime: String
    let iso8601Time: String?
    let rfc2822Time: String?
    let relativeTime: String?
}
