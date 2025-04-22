//
//  PathTests.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

// Assuming SwiftTesting is available
@Test func testPathResolvesAbsoluteURL() {
    struct AbsolutePath: Path {
        let string: String
        var baseUrl: URL? { nil }
    }

    let path = AbsolutePath(string: "https://example.com/test")
    #expect(path.url.absoluteString == "https://example.com/test")
}

@Test func testPathResolvesRelativeURL() {
    struct RelativePath: Path {
        let string: String
        var baseUrl: URL? { URL(string: "https://example.com/") }
    }

    let path = RelativePath(string: "subpage")
    #expect(path.url.absoluteString == "https://example.com/subpage")
}

@Test func testWebPathDefaultsBaseURLToNil() {
    struct TestWebPath: WebPath {
        let string: String
    }

    let path = TestWebPath(string: "https://example.com/page")
    #expect(path.baseUrl == nil)
    #expect(path.url.absoluteString == "https://example.com/page")
}

@Test func testAPIPathDefaultsBaseURLToCommonAPI() {
    struct TestAPIPath: APIPath {
        let string: String
    }

    let path = TestAPIPath(string: "service/info/")
    #expect(path.baseUrl == CommonPath.api.url)
    #expect(path.url.absoluteString == "\(CommonPath.api.url.absoluteString)/service/info/")
}
