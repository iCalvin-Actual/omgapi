//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

@testable import omgapi
import Testing

struct AccountTests {
    @Test func testPopulateFromInfo() async {
        let infoOne = AccountInfo(
            message: "Sample account A",
            email: "user@domain.com",
            created: .init(.init(timeIntervalSince1970: 0)),
            name: "User"
        )
        let infoTwo = AccountInfo(
            message: "Sample account B",
            email: "client@business.com",
            created: .init(.now),
            name: "Client"
        )
        var account = Account(info: infoOne)
        #expect(account.name == "User")
        #expect(account.emailAddress == "user@domain.com")
        #expect(account.created.timeIntervalSince1970 == 0)
        
        account = Account(info: infoTwo)
        #expect(account.name == "Client")
        #expect(account.emailAddress == "client@business.com")
        #expect(account.created.timeIntervalSinceNow < 2)
    }
}
