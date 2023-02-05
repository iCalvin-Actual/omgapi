import Combine
import XCTest
@testable import api_core
@testable import api_pastebin

class APIAccountTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testGetPastes() {
        let manager = OMGAPI()

        manager.getPasteBin(for: "calvin")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetPaste() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.getPaste(title: "async", from: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testCreatePaste() {
        let draft = Paste.Draft(title: "Testing", content: "Drafted Content")
        
        let manager = OMGAPI()
        
        manager.savePaste(draft, to: "calvin", credential: account)
            .sink { result in
                if let _ = self.receiveValue(result) {
                    self.responseValidation.fulfill()
                }
            }
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testDeletePaste() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.deletePaste("Testing", from: "calvin", with: account).sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

