//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing



@Test func testTimeStampEncodesEpochCorrectly() throws {
    let date = Date(timeIntervalSince1970: 123456789)
    let timestamp = TimeStamp(date)
    let data = try JSONEncoder().encode(timestamp)
    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
    let epochString = json?["unixEpochTime"] as? String

    #expect(epochString?.starts(with: "123456789") == true)
}

@Test func testTimeStampDecodesFromStringEpoch() throws {
    let json = """
    {
        "unixEpochTime": "123456789",
        "message": "Sample"
    }
    """.data(using: .utf8)!

    let decoded = try JSONDecoder().decode(TimeStamp.self, from: json)
    #expect(decoded.date == Date(timeIntervalSince1970: 123456789))
    #expect(decoded.message == "Sample")
}

@Test func testTimeStampDecodesFromIntEpoch() throws {
    let json = """
    {
        "unixEpochTime": 123456789,
        "message": null
    }
    """.data(using: .utf8)!

    let decoded = try JSONDecoder().decode(TimeStamp.self, from: json)
    #expect(decoded.date == Date(timeIntervalSince1970: 123456789))
    #expect(decoded.message == nil)
}

@Test func testTimeStampDecodesFallbackOnInvalidEpoch() throws {
    let json = """
    {
        "unixEpochTime": "invalid"
    }
    """.data(using: .utf8)!

    let decoded = try JSONDecoder().decode(TimeStamp.self, from: json)
    let delta = abs(decoded.date.timeIntervalSinceNow)
    #expect(delta < 2)
}

@Test func testNowTimeStamp() throws {
    let nowDate = Date()
    let nowStamp = TimeStamp.now
    
    #expect(nowStamp.date.timeIntervalSince(nowDate) < 2)
}
