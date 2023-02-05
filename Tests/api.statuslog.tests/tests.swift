import Combine
import XCTest
@testable import api_core
@testable import api_statuslog

class APIAccountTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testGetStatusLog() {
        let manager = OMGAPI()
        
        manager.getCompleteStatusLog()
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetLatestStatusLog() {
        let manager = OMGAPI()
        
        manager.getLatestStatusLog()
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetAddressStatusLog() {
        let manager = OMGAPI()
        
        manager.getAddressStatusLog("calvin")
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetAddressStatus() {
        OMGAPI().getAddressStatus("63dd17bbb25fd", for: "calvin")
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testPostAddressStatus() {
        let draft = Status.Draft(content: "Some Status Update", emoji: "🦖", externalUrl: "https://daringfireball.com")
        OMGAPI().postAddressStatus(draft, for: "calvin", with: account)
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testDeleteAddressStatus() {
        OMGAPI().deleteAddressStatus("63e00cab93815", for: "calvin", with: account)
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetAddressBio() {
        let manager = OMGAPI()
        
        manager.getStatusLogBio("calvin")
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateAddressBio() {
        let manager = OMGAPI()
        
        manager.updateStatusLogBio(.init(content: "New content"), for: "calvin", with: account)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}
