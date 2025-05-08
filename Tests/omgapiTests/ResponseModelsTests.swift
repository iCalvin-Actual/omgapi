//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

struct LogicTests {
    @Test func testPasteIsPublicDefaultsTrueWhenListedIsNil() {
        let paste = AddressPasteResponseModel.PasteResponseModel(
            title: "Test",
            content: "Content",
            modifiedOn: 123456789,
            listed: nil
        )
        #expect(paste.isPublic == true)
    }
    
    @Test func testPasteUpdatedTimestamp() {
        let ts = 123456789
        let paste = AddressPasteResponseModel.PasteResponseModel(
            title: "Test",
            content: "Content",
            modifiedOn: ts,
            listed: 1
        )
        #expect(paste.updated == Date(timeIntervalSince1970: Double(ts)))
    }
    
    @Test func testNowUpdatedAtConversion() {
        let raw = 123456789
        let now = AddressNowResponseModel.NowResponseModel(content: "text", updated: raw, listed: 1)
        #expect(now.updatedAt == Date(timeIntervalSince1970: Double(raw)))
    }
    
    @Test func testPURLItemIsPublicFromString() {
        let purl = AddressPURLItemResponseModel(
            name: "my-link",
            url: "https://example.com",
            counter: 1,
            listed: "false"
        )
        #expect(purl.isPublic == false)
    }
    
    @Test func testStatusModelCreatedDate() {
        let status = AddressStatusResponseModel(
            id: "abc",
            address: "someone",
            created: "123456789",
            content: "hello",
            emoji: nil,
            externalURL: nil
        )
        #expect(status.createdDate == Date(timeIntervalSince1970: 123456789))
    }
}
