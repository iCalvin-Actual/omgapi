import Combine
import XCTest
@testable import api_core
@testable import api_account

class APIManagerTests: XCTestCase, ObservableObject {
    
    var cancellationToken: AnyCancellable?
    
    let standardExpectation: XCTestExpectation = .init(description: "")
    
    func testAccountInfo() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAccountInfo()
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testAccountName() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAccountName()
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testSetAccountName() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.setAccountName("")
            .sink(receiveValue: { result in
                switch result {
                case .success(let owner):
                    XCTAssertEqual(owner.name, "")
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 10.0)
    }
    
    func testAccountSettings() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAccountSettings()
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testSetAccountSettings() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        let newSettings: AccountSettings =  .init(
            communication: .email_ok
        )
        
        cancellationToken = manager.setAccountSettings(newSettings)
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
}

