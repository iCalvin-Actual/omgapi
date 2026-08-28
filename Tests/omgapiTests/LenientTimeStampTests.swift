//
//  LenientTimeStampTests.swift
//  omgapi
//

import Foundation
@testable import omgapi
import Testing

/// omg.lol doesn't reliably send `unix_epoch_time`, and a strict decode of one
/// missing epoch used to fail the whole account address list — which read as a
/// signed-out app. These cover the shapes that have to survive.
struct LenientTimeStampTests {
    private static func addressList(_ registration: String?) -> Data {
        let entry: String
        if let registration {
            entry = #"{"address":"calvin","message":"m","registration":\#(registration)}"#
        } else {
            entry = #"{"address":"calvin","message":"m"}"#
        }
        return Data("[\(entry)]".utf8)
    }

    @Test func decodesUsableEpoch() throws {
        let decoded = try api.decoder.decode(
            AddressCollectionResponseModel.self,
            from: Self.addressList(#"{"message":"m","unix_epoch_time":1707744362}"#)
        )
        #expect(decoded.first?.registration?.date == Date(timeIntervalSince1970: 1707744362))
    }

    @Test func decodesStringEpoch() throws {
        let decoded = try api.decoder.decode(
            AddressCollectionResponseModel.self,
            from: Self.addressList(#"{"message":"m","unix_epoch_time":"1707744362"}"#)
        )
        #expect(decoded.first?.registration?.date == Date(timeIntervalSince1970: 1707744362))
    }

    @Test(arguments: [
        #"{"message":"m"}"#,                             // key absent
        #"{"message":"m","unix_epoch_time":null}"#,      // key null
        #"{"message":"m","unix_epoch_time":""}"#,        // present but unparseable
        #"{"message":"m","unix_epoch_time":"forever"}"#,
        "null",                                          // whole object null
    ])
    func survivesUnusableRegistration(_ registration: String) throws {
        let decoded = try api.decoder.decode(
            AddressCollectionResponseModel.self,
            from: Self.addressList(registration)
        )
        #expect(decoded.count == 1)
        #expect(decoded.first?.address == "calvin")
        #expect(decoded.first?.registration?.date == nil)
    }

    @Test func survivesAbsentRegistration() throws {
        let decoded = try api.decoder.decode(
            AddressCollectionResponseModel.self,
            from: Self.addressList(nil)
        )
        #expect(decoded.count == 1)
        #expect(decoded.first?.registration == nil)
    }

    /// The regression itself: one bad address must not take the others with it.
    @Test func oneBadAddressKeepsTheRest() throws {
        let json = Data("""
        [
            {"address":"good","message":"m","registration":{"unix_epoch_time":1707744362}},
            {"address":"bad","message":"m","registration":{"unix_epoch_time":null}},
            {"address":"alsogood","message":"m","registration":{"unix_epoch_time":"1675715550"}}
        ]
        """.utf8)
        let decoded = try api.decoder.decode(AddressCollectionResponseModel.self, from: json)
        #expect(decoded.map(\.address) == ["good", "bad", "alsogood"])
        #expect(decoded[1].registration?.date == nil)
    }

    @Test func accountInfoSurvivesUnusableCreatedDate() throws {
        let json = Data(#"{"message":"m","email":"me@example.com","name":"Calvin","created":{"message":"m"}}"#.utf8)
        let decoded = try api.decoder.decode(AccountInfoResponseModel.self, from: json)
        #expect(Account(info: decoded).created == nil)
    }

    @Test func addressInfoSurvivesUnusableRegistration() throws {
        let json = Data("""
        {
            "message": "m",
            "address": "calvin",
            "owner": "calvin",
            "registration": {"message": "m", "unix_epoch_time": null},
            "expiration": {"message": "m", "expired": false},
            "verification": {"message": "m", "verified": true}
        }
        """.utf8)
        let decoded = try api.decoder.decode(AddressInfoResponseModel.self, from: json)
        #expect(decoded.registration?.date == nil)
    }
}
