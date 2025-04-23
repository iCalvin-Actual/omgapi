//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

struct DecodingTests {
    @Test func testDecodeServiceInfoResponse() throws {
        let json = """
    {
        "message": "OK",
        "members": "https://api.omg.lol/address/members",
        "addresses": "https://api.omg.lol/address/",
        "profiles": "https://api.omg.lol/profile/"
    }
    """.data(using: .utf8)!
        
        let decoded = try JSONDecoder().decode(ServiceInfoResponse.self, from: json)
        #expect(decoded.message == "OK")
        #expect(decoded.members == "https://api.omg.lol/address/members")
        #expect(decoded.addresses == "https://api.omg.lol/address/")
        #expect(decoded.profiles == "https://api.omg.lol/profile/")
    }
    
    @Test func testDecodeOAuthResponse() throws {
        let json = """
        {
            "accessToken": "abcd1234"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(OAuthResponse.self, from: json)
        #expect(decoded.accessToken == "abcd1234")
    }
    
    @Test func testDecodeAccountInfo() throws {
        let json = """
        {
            "message": "Account loaded",
            "email": "user@example.com",
            "created": {
                "message": "created",
                "unixEpochTime": "123456789"
            },
            "name": "User"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AccountInfo.self, from: json)
        #expect(decoded.message == "Account loaded")
        #expect(decoded.email == "user@example.com")
        #expect(decoded.name == "User")
        #expect(decoded.created.date == Date(timeIntervalSince1970: 123456789))
    }

    @Test func testDecodeAccountOwner() throws {
        let json = """
        {
            "message": "Owner loaded",
            "name": "Owner Name"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AccountOwner.self, from: json)
        #expect(decoded.message == "Owner loaded")
        #expect(decoded.name == "Owner Name")
    }

    @Test func testDecodeAccountAddressResponse() throws {
        let json = """
        {
            "message": "Registered",
            "address": "name.omg.lol",
            "registration": {
                "message": "when",
                "unixEpochTime": "987654321"
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AccountAddressResponse.self, from: json)
        #expect(decoded.message == "Registered")
        #expect(decoded.address == "name.omg.lol")
        #expect(decoded.registration.date == Date(timeIntervalSince1970: 987654321))
    }
    
    @Test func testDecodeAddressCollection() throws {
        let json = """
        [
            {
                "message": "Address 1",
                "address": "user1.omg.lol",
                "registration": {
                    "message": "created",
                    "unixEpochTime": "1000"
                }
            },
            {
                "message": "Address 2",
                "address": "user2.omg.lol",
                "registration": {
                    "message": "created",
                    "unixEpochTime": "2000"
                }
            }
        ]
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressCollection.self, from: json)
        #expect(decoded.count == 2)
        #expect(decoded[0].address == "user1.omg.lol")
        #expect(decoded[1].address == "user2.omg.lol")
        #expect(decoded[0].registration.date == Date(timeIntervalSince1970: 1000))
        #expect(decoded[1].registration.date == Date(timeIntervalSince1970: 2000))
    }
    
    @Test func testDecodeAddressDirectoryResponse() throws {
        let json = """
        {
            "message": "Directory loaded",
            "url": "https://omg.lol/directory",
            "directory": ["a", "b", "c"]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressDirectoryResponse.self, from: json)
        #expect(decoded.url == "https://omg.lol/directory")
        #expect(decoded.directory == ["a", "b", "c"])
    }

    @Test func testDecodeAddressInfoResponse() throws {
        let json = """
        {
            "message": "Info loaded",
            "address": "user.omg.lol",
            "owner": "user",
            "registration": {
                "message": "created",
                "unixEpochTime": "123"
            },
            "expiration": {
                "message": "expires",
                "expired": false,
                "willExpire": true,
                "unixEpochTime": "456",
                "relativeTime": "in 1 year"
            },
            "verification": {
                "message": "verified",
                "verified": true
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressInfoResponse.self, from: json)
        #expect(decoded.address == "user.omg.lol")
        #expect(decoded.owner == "user")
        #expect(decoded.registration.date == Date(timeIntervalSince1970: 123))
        #expect(decoded.expiration.expired == false)
        #expect(decoded.expiration.willExpire == true)
        #expect(decoded.expiration.unixEpochTime == "456")
        #expect(decoded.verification.verified == true)
    }

    @Test func testDecodeAddressAvailabilityResponse() throws {
        let json = """
        {
            "message": "Checked",
            "address": "check.omg.lol",
            "available": true,
            "availability": "Available",
            "punyCode": "check"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressAvailabilityResponse.self, from: json)
        #expect(decoded.available == true)
        #expect(decoded.availability == "Available")
        #expect(decoded.punyCode == "check")
    }

    @Test func testDecodeNowGardenResponse() throws {
        let json = """
        {
            "message": "Garden loaded",
            "garden": [
                {
                    "address": "user1",
                    "url": "https://omg.lol/now/user1",
                    "updated": {
                        "message": "updated",
                        "unixEpochTime": "1111111111"
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(NowGardenResponse.self, from: json)
        #expect(decoded.message == "Garden loaded")
        #expect(decoded.garden.count == 1)
        #expect(decoded.garden[0].address == "user1")
        #expect(decoded.garden[0].url == "https://omg.lol/now/user1")
        #expect(decoded.garden[0].updated.date == Date(timeIntervalSince1970: 1111111111))
    }

    @Test func testDecodeAddressNowResponseModel() throws {
        let json = """
        {
            "message": "Loaded",
            "now": {
                "content": "Working on something cool",
                "updated": 1713800000,
                "listed": 1
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressNowResponseModel.self, from: json)
        #expect(decoded.message == "Loaded")
        #expect(decoded.now.content == "Working on something cool")
        #expect(decoded.now.listed == 1)
        #expect(decoded.now.updatedAt == Date(timeIntervalSince1970: 1713800000))
    }

    @Test func testDecodePasteBinResponseModel() throws {
        let json = """
        {
            "message": "Pastebin loaded",
            "pastebin": [
                {
                    "title": "A",
                    "content": "Alpha",
                    "modifiedOn": 100000,
                    "listed": 1
                },
                {
                    "title": "B",
                    "content": "Beta",
                    "modifiedOn": 200000,
                    "listed": 0
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PasteBinResponseModel.self, from: json)
        #expect(decoded.message == "Pastebin loaded")
        #expect(decoded.pastebin.count == 2)
        #expect(decoded.pastebin[0].title == "A")
        #expect(decoded.pastebin[1].content == "Beta")
    }
    
    @Test func testDecodePasteResponseModel() throws {
        let json = """
        {
            "message": "Loaded",
            "paste": {
                "title": "Snippet",
                "content": "Some code",
                "modifiedOn": 12345,
                "listed": 1
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PasteResponseModel.self, from: json)
        #expect(decoded.message == "Loaded")
        #expect(decoded.paste.title == "Snippet")
        #expect(decoded.paste.content == "Some code")
        #expect(decoded.paste.updated == Date(timeIntervalSince1970: 12345))
        #expect(decoded.paste.isPublic == true)
    }
    
    @Test func testDecodeSavePasteResponseModel() throws {
        let json = """
        {
            "message": "Saved",
            "title": "Update"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(SavePasteResponseModel.self, from: json)
        #expect(decoded.message == "Saved")
        #expect(decoded.title == "Update")
    }
    
    @Test func testDecodeAddressPURLResponse() throws {
        let json = """
        {
            "name": "cool",
            "url": "https://omg.lol/cool",
            "counter": 123
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressPURLResponse.self, from: json)
        #expect(decoded.name == "cool")
        #expect(decoded.url == "https://omg.lol/cool")
        #expect(decoded.counter == 123)
    }
    
    @Test func testDecodeAddressPURLItemResponse() throws {
        let json = """
        {
            "name": "link",
            "url": "https://omg.lol/forward",
            "counter": 99,
            "listed": "true"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressPURLItemResponse.self, from: json)
        #expect(decoded.name == "link")
        #expect(decoded.url == "https://omg.lol/forward")
        #expect(decoded.counter == 99)
        #expect(decoded.isPublic == true)
    }
    
    @Test func testDecodeAddressPURLsResponse() throws {
        let json = """
        [
            {
                "name": "hello",
                "url": "https://omg.lol/hello",
                "counter": 42,
                "listed": "true"
            },
            {
                "name": "hidden",
                "url": "https://omg.lol/hidden",
                "counter": 7,
                "listed": "false"
            }
        ]
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressPURLsResponse.self, from: json)
        #expect(decoded.count == 2)
        #expect(decoded[0].name == "hello")
        #expect(decoded[0].isPublic == true)
        #expect(decoded[1].name == "hidden")
        #expect(decoded[1].isPublic == false)
    }

    @Test func testDecodePURLsResponseModel() throws {
        let json = """
        {
            "message": "Loaded",
            "purls": [
                {
                    "name": "hello",
                    "url": "https://omg.lol/hello",
                    "counter": 42,
                    "listed": "true"
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PURLsResponseModel.self, from: json)
        #expect(decoded.message == "Loaded")
        #expect(decoded.purls.count == 1)
        #expect(decoded.purls[0].name == "hello")
        #expect(decoded.purls[0].url == "https://omg.lol/hello")
        #expect(decoded.purls[0].isPublic == true)
    }

    @Test func testDecodePURLResponseModel() throws {
        let json = """
        {
            "message": "Loaded",
            "purl": {
                "name": "link",
                "url": "https://omg.lol/forward",
                "counter": 99
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PURLResponseModel.self, from: json)
        #expect(decoded.message == "Loaded")
        #expect(decoded.purl.name == "link")
        #expect(decoded.purl.url == "https://omg.lol/forward")
        #expect(decoded.purl.counter == 99)
    }

    @Test func testDecodeProfileResponseModel() throws {
        let json = """
        {
            "message": "Loaded",
            "content": "This is the markdown",
            "html": "<p>This is the markdown</p>",
            "type": "custom",
            "theme": "void",
            "css": "body { color: white; }",
            "head": "<meta />",
            "verified": 1,
            "pfp": "pic.jpg",
            "metadata": "{}"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(ProfileResponseModel.self, from: json)
        #expect(decoded.message == "Loaded")
        #expect(decoded.content == "This is the markdown")
        #expect(decoded.verified == 1)
    }
    
    @Test func testDecodeAddressStatusModel() throws {
        let json = """
        {
            "id": "abc123",
            "address": "test.omg.lol",
            "created": "1234567890",
            "content": "Hello from omg.lol",
            "emoji": "👋",
            "externalURL": "https://example.com"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AddressStatusModel.self, from: json)
        #expect(decoded.id == "abc123")
        #expect(decoded.address == "test.omg.lol")
        #expect(decoded.content == "Hello from omg.lol")
        #expect(decoded.emoji == "👋")
        #expect(decoded.externalURL?.absoluteString == "https://example.com")
        #expect(decoded.createdDate == Date(timeIntervalSince1970: 1234567890))
    }

    @Test func testDecodeStatusLogBioResponseModel() throws {
        let json = """
        {
            "message": "Fetched",
            "bio": "This is a status log bio",
            "css": "body { color: #fff; }"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(StatusLogBioResponseModel.self, from: json)
        #expect(decoded.message == "Fetched")
        #expect(decoded.bio == "This is a status log bio")
        #expect(decoded.css == "body { color: #fff; }")
    }

    @Test func testDecodeStatusLogFollowersModel() throws {
        let json = """
        {
            "message": "Followers listed",
            "followers": ["user1", "user2"],
            "followersCount": 2
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(StatusLogFollowersModel.self, from: json)
        #expect(decoded.message == "Followers listed")
        #expect(decoded.followers == ["user1", "user2"])
        #expect(decoded.followersCount == 2)
    }

    @Test func testDecodeStatusLogFollowingModel() throws {
        let json = """
        {
            "message": "Following listed",
            "following": ["other1", "other2"],
            "followingCount": 2
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(StatusLogFollowingModel.self, from: json)
        #expect(decoded.message == "Following listed")
        #expect(decoded.following == ["other1", "other2"])
        #expect(decoded.followingCount == 2)
    }
    
    @Test func testDecodeNewStatusResponseModel() throws {
        let json = """
        {
            "message": "Created",
            "id": "new123",
            "status": "Just posted this",
            "url": "https://omg.lol/status/new123",
            "externalUrl": "https://external.site"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(NewStatusResponseModel.self, from: json)
        #expect(decoded.message == "Created")
        #expect(decoded.id == "new123")
        #expect(decoded.status == "Just posted this")
        #expect(decoded.url == "https://omg.lol/status/new123")
        #expect(decoded.externalUrl == "https://external.site")
    }

    @Test func testDecodeStatusResponseModel() throws {
        let json = """
        {
            "message": "Fetched",
            "status": {
                "id": "stat456",
                "address": "user.omg.lol",
                "created": "1714000000",
                "content": "Hello world",
                "emoji": "👋",
                "externalURL": "https://example.com"
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(StatusResponseModel.self, from: json)
        #expect(decoded.message == "Fetched")
        #expect(decoded.status.id == "stat456")
        #expect(decoded.status.createdDate == Date(timeIntervalSince1970: 1714000000))
        #expect(decoded.status.content == "Hello world")
        #expect(decoded.status.emoji == "👋")
    }

    @Test func testDecodeStatusLogResponseModel() throws {
        let json = """
        {
            "message": "Log loaded",
            "statuses": [
                {
                    "id": "s1",
                    "address": "a.omg.lol",
                    "created": "1111111111",
                    "content": "First status",
                    "emoji": null,
                    "externalURL": null
                },
                {
                    "id": "s2",
                    "address": "b.omg.lol",
                    "created": "1111112222",
                    "content": "Second status",
                    "emoji": "🔥",
                    "externalURL": "https://link"
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(StatusLogResponseModel.self, from: json)
        #expect(decoded.message == "Log loaded")
        #expect(decoded.statuses?.count == 2)
        #expect(decoded.statuses?[0].id == "s1")
        #expect(decoded.statuses?[1].emoji == "🔥")
        #expect(decoded.statuses?[1].externalURL?.absoluteString == "https://link")
    }
    @Test func testDecodeThemesResponseModel() throws {
        let json = """
        {
            "message": "Themes loaded",
            "themes": {
                "void": {
                    "id": "void",
                    "name": "Void",
                    "created": "2023-01-01",
                    "updated": "2023-06-01",
                    "author": "Calvin",
                    "authorUrl": "https://omg.lol/calvin",
                    "version": "1.0",
                    "license": "MIT",
                    "description": "A dark minimalist theme.",
                    "previewCss": "body { background: black; }",
                    "sampleProfile": "# Hello World"
                }
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(ThemesResponseModel.self, from: json)
        #expect(decoded.message == "Themes loaded")
        #expect(decoded.themes["void"]?.name == "Void")
        #expect(decoded.themes["void"]?.author == "Calvin")
    }

    @Test func testDecodeThemeResponseModelDirectly() throws {
        let json = """
        {
            "id": "classic",
            "name": "Classic",
            "created": "2022-01-01",
            "updated": "2022-05-01",
            "author": "Admin",
            "authorUrl": "https://omg.lol/admin",
            "version": "2.1",
            "license": "CC-BY",
            "description": "A classic look.",
            "previewCss": "body { font-family: serif; }",
            "sampleProfile": "# Classic!"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(ThemeResponseModel.self, from: json)
        #expect(decoded.id == "classic")
        #expect(decoded.name == "Classic")
        #expect(decoded.author == "Admin")
        #expect(decoded.sampleProfile == "# Classic!")
    }

    @Test func testDecodePicResponse() throws {
        let json = """
        {
            "id": "pic123",
            "address": "user.omg.lol",
            "created": 1745410733,
            "mime": "image/jpeg",
            "size": 512,
            "description": "A lovely sunset",
            "exif": {
                "Camera": "Canon EOS",
                "ISO": "100"
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PicResposne.self, from: json)
        #expect(decoded.id == "pic123")
        #expect(decoded.address == "user.omg.lol")
        #expect(decoded.mime == "image/jpeg")
        #expect(decoded.size == 512)
        #expect(decoded.description == "A lovely sunset")
        #expect(decoded.exif["Camera"] == "Canon EOS")
    }

    @Test func testDecodePicsResponseModel() throws {
        let json = """
        {
            "message": "Pics fetched",
            "pics": [
                {
                    "id": "pic001",
                    "address": "user1",
                    "created": 1745410733,
                    "mime": "image/png",
                    "size": 256,
                    "description": "A beach photo",
                    "exif": { "Exposure": "1/100s" }
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PicsResponseModel.self, from: json)
        #expect(decoded.message == "Pics fetched")
        #expect(decoded.pics.count == 1)
        #expect(decoded.pics[0].id == "pic001")
        #expect(decoded.pics[0].mime == "image/png")
    }

    @Test func testDecodePicResponseModel() throws {
        let json = """
        {
            "message": "Single pic loaded",
            "pic": {
                "id": "pic999",
                "address": "someone.omg.lol",
                "created": 1745410733,
                "mime": "image/gif",
                "size": 128,
                "description": "Funny loop",
                "exif": { "Loop": "Forever" }
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PicResponseModel.self, from: json)
        #expect(decoded.message == "Single pic loaded")
        #expect(decoded.pic.id == "pic999")
        #expect(decoded.pic.mime == "image/gif")
        #expect(decoded.pic.exif["Loop"] == "Forever")
    }
}
