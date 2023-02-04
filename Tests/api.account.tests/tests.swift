import Combine
import XCTest
@testable import api_core
@testable import api_account

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testAccountInfo() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.getAccountInfo()
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testAccountName() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.getAccountName()
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testSetAccountName() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.setAccountName("")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 10.0)
    }
    
    func testAccountSettings() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.getAccountSettings()
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.responseValidation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testSetAccountSettings() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        let newSettings: AccountSettings =  .init(
            communication: .email_ok
        )
        
        requests.append(manager.setAccountSettings(newSettings)
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.responseValidation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

