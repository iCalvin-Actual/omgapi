//
//  NowDraftEncodingTests.swift
//  omgapi
//

@testable import omgapi
import Foundation
import Testing

struct NowDraftEncodingTests {

    private func encodedObject(_ draft: Now.Draft) throws -> [String: Any] {
        let data = try JSONEncoder().encode(draft)
        return try #require(try JSONSerialization.jsonObject(with: data) as? [String: Any])
    }

    /// The documented body is `{"content": "...", "listed": "1"}` — a string
    /// flag, not a JSON boolean.
    @Test func listedEncodesAsStringFlag() throws {
        let object = try encodedObject(.init(content: "hello", listed: true))
        #expect(object["content"] as? String == "hello")
        #expect(object["listed"] as? String == "1")
        #expect(object["listed"] as? Bool == nil)
    }

    @Test func unlistedEncodesAsZero() throws {
        let object = try encodedObject(.init(content: "hello", listed: false))
        #expect(object["listed"] as? String == "0")
    }

    @Test func contentIsPreservedVerbatim() throws {
        let markdown = "# Heading\n\n- item\n\n{profile-picture}"
        let object = try encodedObject(.init(content: markdown, listed: true))
        #expect(object["content"] as? String == markdown)
    }
}
