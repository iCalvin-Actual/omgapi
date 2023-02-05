import Combine
import XCTest
@testable import api_core
@testable import api_pastebin

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testGetPastes() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.getPasteBin(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testCreatePaste() {
        let draft = DraftPaste(title: "Testing", content: "Drafted Content")
        
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.postPaste(draft: draft, with: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
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
    
    func testDeletePaste() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.deletePaste(title: "Testing", from: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

