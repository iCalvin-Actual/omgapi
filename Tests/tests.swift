import Combine
import XCTest
@testable import api_core
@testable import api_account
@testable import api_profile
@testable import api_statuslog
@testable import api_now
@testable import api_purl
@testable import api_pastebin

protocol APITest {
    
    var requests: [AnyCancellable] { get }
    
    var successfulResponse: XCTestExpectation { get }
    var responseValidation: XCTestExpectation { get }
}

extension APITest {
    func receiveValue<R>(_ result: Result<R, omg_api.APIError>) -> R? {
        switch result {
        case .success(let response):
            successfulResponse.fulfill()
            return response
        case .failure(let error):
            XCTFail("Failed \(error)")
            return nil
        }
    }
}

class APIManagerTest: XCTestCase, APITest {
    public var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testAccountInfo() async throws {
        let manager = omg_api()
        let account = try await manager.purls(from: "calvin", credential: nil)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
}
