//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

@testable import omgapi
import Testing

@Test func testNilResponse() {
    let response: APIResponse<None>? = nil
    let error = APIError.create(from: response)
    #expect(error == .inconceivable)
}

@Test func testUnauthenticatedFor401() {
    let response = APIResponse<BasicResponse>(
        request: .init(statusCode: 401, success: false),
        result: BasicResponse(message: "Unauthorized")
    )
    let error = APIError.create(from: response)
    #expect(error == .unauthenticated)
}

@Test func testNotFoundFor404() {
    let response = APIResponse<BasicResponse>(
        request: .init(statusCode: 404, success: false),
        result: BasicResponse(message: "Missing")
    )
    let error = APIError.create(from: response)
    #expect(error == .notFound)
}

@Test func testUnhandledForOtherStatus() {
    var response = APIResponse<BasicResponse>(
        request: .init(statusCode: 500, success: false),
        result: BasicResponse(message: "Internal error")
    )
    var error = APIError.create(from: response)
    #expect(error == .unhandled(500, message: "Internal error"))
    response = APIResponse<BasicResponse>(
        request: .init(statusCode: 200, success: true),
        result: BasicResponse(message: "Internal error")
    )
    error = APIError.create(from: response)
    #expect(error == .none)
}
