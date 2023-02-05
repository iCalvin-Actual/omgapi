import Combine
import XCTest
@testable import api_core
@testable import api_account

class APIAccountTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testAccountInfo() {
        let manager = OMGAPI()
        
        manager.getAccount(for: account)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
    
    func testSetName() {
        let manager = OMGAPI()
        let existingName: String = "Calvin"
        let newName: String = "a stranger"
        
        manager.setName(newName, with: self.account)
            .flatMap({ result in
                if case let .success(response) = result {
                    XCTAssertEqual(newName, response.name)
                }
                return manager.setName(existingName, with: self.account)
            })
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
    
    func testSetPreference() {
        let manager = OMGAPI()
        
        manager.setCommunication(.yesPlease, with: account)
            .flatMap({ result in
                if case let .success(response) = result {
                    XCTAssertEqual(CommunicationPreference.yesPlease, response.communicationChoice)
                }
                return manager.setCommunication(.noThankYou, with: self.account)
            })
            .sink(receiveValue: { result in
                if let response = self.receiveValue(result) {
                    XCTAssertEqual(CommunicationPreference.noThankYou, response.communicationChoice)
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 15.0)
    }
}

