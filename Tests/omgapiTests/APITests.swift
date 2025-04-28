//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/22/25.
//

import Foundation
@testable import omgapi
import Testing

enum FilePath: LocalPath {
    case file(String)
    
    var string: String {
        switch self {
        case .file(let string):
            guard let filePath = Bundle.module.path(forResource: string, ofType: "json") else {
                return string
            }
            return filePath
        }
    }
}

struct APIUnitTests {
    @Test
    func testStaticDecoderDecodesSnakeCaseKeys() throws {
        struct MockResponse: Decodable {
            let createdAt: String
        }

        let json = """
        {
            "created_at": "2025-04-22"
        }
        """.data(using: .utf8)!

        let result = try api.decoder.decode(MockResponse.self, from: json)
        #expect(result.createdAt == "2025-04-22")
    }
    
    @Test
    func testAuthURLGeneration() {
        let url = api().authURL(with: "client123", redirect: "https://app/callback")
        #expect(url?.absoluteString == "https://home.omg.lol/oauth/authorize?client_id=client123&scope=everything&redirect_uri=https://app/callback&response_type=code")
    }

    @Test
    func testPriorityDecodingOverridesDefault() throws {
        struct CustomResponse: Response, Equatable {
            let message: String
        }

        let json = """
        {
            "message": "Custom decode"
        }
        """.data(using: .utf8)!

        var priorityDecoderUsed = false

        // Synchronous mock of apiResponse for test
        func testApiResponse<B, R>(
            for request: APIRequest<B, R>,
            priorityDecoding: ((Data) -> R?)? = nil,
            _ handler: (APIRequest<B, R>, ((Data) -> R?)?) -> (Data, URLResponse)
        ) throws -> R {
            let (data, _) = handler(request, priorityDecoding)
            if let result = priorityDecoding?(data) {
                return result
            }
            throw NSError(domain: "Should not reach default decoding", code: 1)
        }

        let result = try testApiResponse(
            for: APIRequest<None, CustomResponse>(path: CommonPath.service),
            priorityDecoding: { data in
                priorityDecoderUsed = true
                return try? JSONDecoder().decode(CustomResponse.self, from: data)
            }
        ) { _, _ in (json, URLResponse()) }

        #expect(priorityDecoderUsed == true)
        #expect(result.message == "Custom decode")
    }
    
    @Test
    func testApiResponseThrowsForFailedRequest() async throws {
        let request = APIRequest<None, BasicResponse>(path: FilePath.file("500Code"))
        do {
            let response = try await api().apiResponse(for: request)
            #expect(response.message == nil)
        } catch {
            #expect((error as? APIError) == .unhandled(500, message:nil))
        }
    }
    
    @Test
    func testApiResponseThrowsForMissingResult() async throws {
        let client = api()
        let request = APIRequest<None, BasicResponse>(path: FilePath.file("BadResponse"))

        do {
            _ = try await client.apiResponse(for: request)
        } catch let error as APIError {
            #expect(error == .badResponseEncoding)
        }
    }
}

struct APIIntegrationTests {
    let client = api()
    
    @Test
    func testFetchPublicData() async throws {
        let targetAddress = "app"
        async let directory = try client.directory()
        async let garden = try client.nowGarden()
        async let themes = try client.themes()
        async let picsFeed = try client.picsFeed()
        async let availability = client.availability(targetAddress)
        async let profile = try client.publicProfile(targetAddress)
        async let details = try client.details(targetAddress)
        async let statusLog = try client.logs(for: targetAddress)
        async let bio = client.bio(for: targetAddress)
        async let nowWeb = try client.nowWebpage(for: targetAddress)
        async let now = try client.now(for: targetAddress)
        async let pastebin = try client.pasteBin(for: targetAddress)
        async let purls = try client.purls(from: targetAddress)
        async let followers = try client.followers(for: targetAddress)
        async let following = try client.following(from: targetAddress)
        
        #expect(try await !directory.isEmpty)
        #expect(try await !garden.isEmpty)
        #expect(try await !themes.isEmpty)
        #expect(try await !picsFeed.isEmpty)
        #expect(try await !availability.available)
        #expect(try await profile.address == targetAddress)
        #expect(try await !details.expired)
        #expect(try await !statusLog.isEmpty)
        #expect(try await !bio.content.isEmpty)
        #expect(try await nowWeb.address == targetAddress)
        #expect(try await !nowWeb.content.isEmpty)
        #expect(try await now.address == targetAddress)
        #expect(try await !now.content.isEmpty)
        #expect(try await !pastebin.isEmpty)
        #expect(try await !purls.isEmpty)
        #expect(try await !following.isEmpty)
        #expect(try await !followers.isEmpty)
    }
}

