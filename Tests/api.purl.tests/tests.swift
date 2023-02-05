import Combine
import XCTest
@testable import api_core
@testable import api_purl

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testGetPurls() {
        let manager = OMGAPI()

        requests.append(manager.getPURLs(from: "hotdogsladies").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testCreatePurl() {
        let draft = DraftPURL(name: "testing", url: "https://daringFireball.com")
        
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.createPurl(for: "calvin", draft: draft).sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetPurl() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.getPurl(purl: "async", for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testDeletePurl() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.deletePurl(purl: "testing", from: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

