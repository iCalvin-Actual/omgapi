//
//  APIRequestConstructorTests.swift
//  
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

@Test func testCreateBodyDataEncodesCorrectly() throws {
    struct Payload: Encodable { let name: String }
    let data = try APIRequestConstructor.createBodyData(for: Payload(name: "test"))
    let json = try JSONSerialization.jsonObject(with: data) as? [String: String]
    #expect(json?["name"] == "test")
}

@Test func testCreateMultipartDataIncludesJSON() throws {
    struct Payload: Encodable { let field: String }
    let data = try APIRequestConstructor.createMultipartData(for: Payload(field: "value"))
    let string = String(data: data, encoding: .utf8)!

    #expect(string.contains("Content-Disposition: form-data; name=\"multipartData\""))
    #expect(string.contains("Content-Type: application/json"))
    #expect(string.contains("value"))
    #expect(string.contains("--Boundary-")) // boundary prefix
}

@Test func testStandardRequestAddsAuthHeader() {
    struct Dummy: WebPath { let string = "https://example.com" }
    let request = APIRequest<None, BasicResponse>(
        authorization: "test-token",
        method: .GET,
        path: Dummy()
    )

    let urlRequest = APIRequestConstructor.urlRequest(from: request)
    #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer test-token")
    #expect(urlRequest.httpMethod == "GET")
    #expect(urlRequest.url?.absoluteString == "https://example.com")
}
