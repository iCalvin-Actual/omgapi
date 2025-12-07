//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

@testable import omgapi
import Testing

struct AddressNameTests {
    @Test func testAddressDisplayString() {
        var name = "app"
        #expect(name.addressDisplayString == "@app")
        name = "@app"
        #expect(name.addressDisplayString == "@app")
    }

    @Test func testPunycodeDisplayString() {
        // "xn--d1acpjx3f" is punycode for "пример" ("example" in Russian)
        let puny = "xn--e1afmkfd" // punycode for "пример"
        let result = puny.addressDisplayString
        #expect(result.hasPrefix("@"))
        #expect(!result.contains("xn--"))
    }

    @Test func testEmptyStringDisplayString() {
        let empty = ""
        #expect(empty.addressDisplayString == "@")
    }

    @Test func testWhitespaceDisplayString() {
        let spaced = " user "
        #expect(spaced.addressDisplayString == "@ user ")
    }

    @Test func testIconURL() {
        let name = "calvin"
        let expected = "https://profiles.cache.lol/calvin/picture"
        #expect(name.addressIconURL?.absoluteString == expected)
        let spaced = " user "
        let expectedSpaced = "https://profiles.cache.lol/%20user%20/picture"
        #expect(spaced.addressIconURL?.absoluteString == expectedSpaced)
    }
}
