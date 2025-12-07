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
}
