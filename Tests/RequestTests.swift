//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

struct RequestTests {
    @Test
    func testGETServiceInfoAPIRequestURLRequest() {
        let request = GETServiceInfoAPIRequest()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/service/info/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testOAuthRequestURLRequest() {
        let request = OAuthRequest(
            with: "client123",
            and: "secret456",
            redirect: "https://myapp/callback",
            accessCode: "code789"
        )
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.host() == "api.omg.lol")
        #expect(urlRequest.url?.path() == "/oauth/")
        let query = urlRequest.url?.query()
        #expect(query?.contains("client_id=client123") ?? false)
        #expect(query?.contains("client_secret=secret456") ?? false)
        #expect(query?.contains("redirect_uri=https://myapp/callback") ?? false)
        #expect(query?.contains("code=code789") ?? false)
        #expect(query?.contains("scope=everything") ?? false)
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAccountInfoAPIRequestURLRequest() {
        let request = GETAccountInfoAPIRequest(
            for: "user@example.com",
            authorization: "abc123"
        )
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/account/user@example.com/info/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer abc123")
    }
    
    @Test
    func testGETAccountNameAPIRequestURLRequest() {
        let request = GETAccountNameAPIRequest(
            for: "user@example.com",
            authorization: "abc123"
        )
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/account/user@example.com/name/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer abc123")
    }
    
    @Test
    func testSETAccountNameAPIRequestURLRequest() {
        let request = SETAccountNameAPIRequest(
            newValue: "Cool User",
            for: "user@example.com",
            authorization: "abc123"
        )
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/account/user@example.com/name/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer abc123")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: String]
        #expect(body?["name"] == "Cool User")
    }
    
    @Test
    func testGETAddressesRequest() {
        let request = GETAddresses(authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/account/application/addresses/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressesForEmailAPIRequest() {
        let request = GETAddressesForEmailAPIRequest(
            for: "user@example.com",
            authorization: "token"
        )
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/account/user@example.com/addresses/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressDirectoryRequest() {
        let request = GETAddressDirectoryRequest()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/directory/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressAvailabilityRequest() {
        let request = GETAddressAvailabilityRequest(for: "username")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/username/availability/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressInfoRequest() {
        let request = GETAddressInfoRequest(for: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/info/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressExpirationRequest() {
        let request = GETAddressExpirationRequest(for: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/expiration/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETNowGardenRequest() {
        let request = GETNowGardenRequest()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/now/garden/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressNowPageRequest() {
        let request = GETAddressNowPageRequest("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://user.omg.lol/now")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressNowRequest() {
        let request = GETAddressNowRequest(for: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/now/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testSETAddressNowRequest() {
        let draft = Now.Draft(content: "My status", listed: true)
        let request = SETAddressNowRequest(for: "user", draft: draft, authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/now/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["content"] as? String == "My status")
        #expect(body?["listed"] as? Bool == true)
    }
    
    @Test
    func testGETAddressPasteBin() {
        let request = GETAddressPasteBin("user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pastebin/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressPaste() {
        let request = GETAddressPaste("note-title", from: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pastebin/note-title/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testDELETEAddressPasteContent() {
        let request = DELETEAddressPasteContent(paste: "draft", address: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "DELETE")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pastebin/draft")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testSETAddressPaste() {
        let draft = Paste.Draft(title: "Hello", content: "Hello World", listed: true)
        let request = SETAddressPaste(draft, to: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pastebin/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["title"] as? String == "Hello")
        #expect(body?["content"] as? String == "Hello World")
        #expect(body?["listed"] as? Bool == true)
    }
    
    @Test
    func testGETAddressPURLsRequest() {
        let request = GETAddressPURLs("user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/purls/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressPURLRequest() {
        let request = GETAddressPURL("link", address: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/purl/link")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressPURLContentRequest() {
        let request = GETAddressPURLContent(purl: "link", address: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://user.url.lol/link")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testDELETEAddressPURLContentRequest() {
        let request = DELETEAddressPURLContent(purl: "link", address: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "DELETE")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/purl/link")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testSETAddressPURLRequest() {
        let draft = PURL.Draft(name: "link", content: "https://example.com", listed: true)
        let request = SETAddressPURL(draft, address: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/purl/link")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["url"] as? String == "https://example.com")
        #expect(body?["listed"] as? Bool == true)
    }
    
    
    @Test
    func testGETPublicProfileRequest() {
        let request = GETPublicProfile("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://user.omg.lol")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETProfileRequest() {
        let request = GETProfile("user", with: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/web")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testSETProfileRequest() {
        let draft = Profile.Draft(content: "<h1>Hello</h1>", publish: true)
        let request = SETProfile(draft, from: "user", with: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/web")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["content"] as? String == "<h1>Hello</h1>")
        #expect(body?["publish"] as? Int == 1)
    }
    
    @Test
    func testGETCompleteStatusLogRequest() {
        let request = GETCompleteStatusLog()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/statuslog/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETLatestStatusLogsRequest() {
        let request = GETLatestStatusLogs()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/statuslog/latest/")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressStatusesRequest() {
        let request = GETAddressStatuses("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressStatusBioRequest() {
        let request = GETAddressStatusBio("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses/bio")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressFollowingRequest() {
        let request = GETAddressFollowing("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses/following")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testGETAddressFollowersRequest() {
        let request = GETAddressFollowers("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses/followers")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testSETAddressFollowingRequest() {
        let request = SETAddressFollowing("user", "target", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses/follow/target")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testDELETEAddressFollowingRequest() {
        let request = DELETEAddressFollowing("user", "target", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "DELETE")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses/follow/target")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }
    
    @Test
    func testGETAddressStatusRequest() {
        let request = GETAddressStatus("abc123", from: "user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses/abc123")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }
    
    @Test
    func testDELETEAddressStatusRequest() {
        let draft = Status.Draft(content: "goodbye", emoji: nil, externalUrl: nil)
        let request = DELETEAddressStatus(draft, from: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "DELETE")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["content"] as? String == "goodbye")
    }
    
    @Test
    func testSETAddressStatusRequest() {
        let draft = Status.Draft(content: "I'm back", emoji: "👋", externalUrl: "https://home.omg.lol")
        let request = SETAddressStatus(draft, with: "user", authorization: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)
        
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/statuses")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        
        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["content"] as? String == "I'm back")
        #expect(body?["emoji"] as? String == "👋")
        #expect(body?["externalUrl"] as? String == "https://home.omg.lol")
    }
    
    @Test
    func testGETThemesRequest() {
        let request = GETThemes()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/theme/list")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test
    func testGETPicsFeedRequest() {
        let request = GETPicsFeed()
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/pics")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test
    func testGETAddressPicsRequest() {
        let request = GETAddressPics("user")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pics")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test
    func testGETAddressPicRequest() {
        let request = GETAddressPic("user", target: "photo.jpg")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pics/photo.jpg")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test
    func testPATCHAddressPicRequest() {
        let draft = Pic.Draft(description: "Updated pic", tags: ["update", "sample"].joined(separator: ","))
        let request = PATCHAddressPic(draft: draft, "user", target: "pic.jpg", credential: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "PATCH")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pics/pic.jpg")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")

        let body = try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data()) as? [String: Any]
        #expect(body?["description"] as? String == "Updated pic")
        #expect((body?["tags"] as? String)?.split(separator: ",").contains("update") == true)
    }

    @Test
    func testPOSTAddressPicRequest() throws {
        let imageData = Data([0xFF, 0xD8, 0xFF]) // mock JPEG header
        let encodedData = try APIRequestConstructor.encoder.encode(imageData)
        let request = POSTAddressPic(image: imageData, "user", credential: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pics/upload")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
        #expect(urlRequest.httpBody == encodedData)
    }

    @Test
    func testDELETEAddressPicRequest() {
        let request = DELETEAddressPic("user", target: "pic.jpg", credential: "token")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "DELETE")
        #expect(urlRequest.url?.absoluteString == "https://api.omg.lol/address/user/pics/pic.jpg")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token")
    }

    @Test
    func testGETPicDataRequest() {
        let request = GETPicData("user", target: "pic", ext: "png")
        let urlRequest = APIRequestConstructor.urlRequest(from: request)

        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.absoluteString == "https://cdn.some.pics/user/pic%7Bextension%7D")
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == nil)
    }

}
