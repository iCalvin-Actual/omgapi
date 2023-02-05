import Combine
import XCTest
@testable import api_core
@testable import api_addresses

class APIAccountTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testDirectory() {
        let manager = APIManager()
        
        manager.getAddressDirectory()
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
    
    func testAvailability() {
        let manager = APIManager()
        
        let expectation = XCTestExpectation(description: "Not available")
        let availableExpectation = XCTestExpectation(description: "Not available")
        let emojiExpectation = XCTestExpectation(description: "Not available")
        
        manager.getAvailability(for: "calvin")
            .sink { result in
                switch result {
                case .success(let available):
                    XCTAssertEqual(available.available, false)
                    expectation.fulfill()
                case .failure:
                    XCTFail("Failed")
                }
            }
            .store(in: &requests)
        
        manager.getAvailability(for: "abcdtytyty")
            .sink { result in
                switch result {
                case .success(let available):
                    XCTAssertEqual(available.available, true)
                    availableExpectation.fulfill()
                case .failure:
                    XCTFail("Failed")
                }
            }
            .store(in: &requests)
        manager.getAvailability(for: "😏")
            .sink { result in
                switch result {
                case .success(let available):
                    XCTAssertEqual(available.available, true)
                    XCTAssertNotNil(available.punyCode)
                    expectation.fulfill()
                case .failure:
                    XCTFail("Failed")
                }
            }
            .store(in: &requests)
        
        wait(for: [expectation, availableExpectation, emojiExpectation], timeout: 15.0)
    }
    
    func testDetails() {
        let manager = APIManager()
        
        manager.getDetails(for: "calvin")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
    
    func testExpirationDate() {
        let manager = APIManager()
        
        manager.getExpirationDate(for: "calvin", with: account)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
}

