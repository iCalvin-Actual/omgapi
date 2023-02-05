import Combine
import XCTest
@testable import api_core
@testable import api_purl

class APIAccountTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testGetPurls() {
        let manager = OMGAPI()

        manager.getPURLs(for: "calvin")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testCreatePurl() {
        let draft = PURL.Draft(name: "testing", url: "https://daringFireball.com")
        
        let manager = OMGAPI()

        manager.savePurl(draft, for: "calvin", credential: account)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetPurl() {
        let manager = OMGAPI()

        manager.getPURL("async", for: "calvin", credential: account)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testDeletePurl() {
        let manager = OMGAPI()

        manager.deletePurl("testing", from: "calvin", credential: account)
            .sink { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

