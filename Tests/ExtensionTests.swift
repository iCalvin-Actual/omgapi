//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

@Test func testBoolValues() {
    var int: Int? = nil
    #expect(int.boolValue == false)
    int = 0
    #expect(int.boolValue == false)
    int = -1
    #expect(int.boolValue == true)
    int = 1
    #expect(int.boolValue == true)
    int = 235
    #expect(int.boolValue == true)
    
    var string: String? = nil
    #expect(string.boolValue == false)
    string = ""
    #expect(string.boolValue == false)
    string = "false"
    #expect(string.boolValue == false)
    string = "no"
    #expect(string.boolValue == false)
    string = "0"
    #expect(string.boolValue == false)

    string = "true"
    #expect(string.boolValue == true)
    string = "yes"
    #expect(string.boolValue == true)
    string = "1"
    #expect(string.boolValue == true)
    string = "-1"
    #expect(string.boolValue == true)
    
    string = "unexpected"
    #expect(string.boolValue == false)
}

@Test func testReplacementValues() {
    let base = "https://example.com/{email}/{address}/{paste}/{purl}/{status}/{target}.{ext}"

    let result = base
        .replacingEmail("user@example.com")
        .replacingAddress("my name")
        .replacingPaste("notes")
        .replacingPURL("redirect")
        .replacingStatus("123")
        .replacingTarget("avatar")
        .replacingExtension("png")

    let expectedResult = "https://example.com/user@example.com/my%20name/notes/redirect/123/avatar.png"
    #expect(result == expectedResult)
}
