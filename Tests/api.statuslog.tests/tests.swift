import Combine
import XCTest
@testable import api_core
@testable import api_statuslog

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testGetStatusLog() {
        let manager = OMGAPI()

        requests.append(manager.getCompleteStatusLog().sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetLatestStatusLog() {
        let manager = OMGAPI()

        requests.append(manager.getLatestStatusLog().sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetStatuses() {
        let manager = OMGAPI()

        requests.append(manager.getStatuses(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetStatus() {
        let manager = OMGAPI()

        requests.append(manager.getStatus("63dd17bbb25fd", for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testPostStatus() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        let draft = DraftStatus(content: "Test Status", emoji: "🤔", externalUrl: "https://www.daringfireball.com")
        
        requests.append(manager.postStatus(draft, for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testEditPost() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        let draft = DraftStatus(content: "Not Testing anymore", emoji: "🎉", externalUrl: "https://www.daringfireball.com")
        
        requests.append(manager.editStatus("63ddfdaf7ab49", for: "calvin", with: draft).sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testDeletePost() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.deleteStatus("63de04183522b", for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetBio() {
        let manager = OMGAPI()

        requests.append(manager.statusLogBio(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateBio() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.updateStatusLogBio(for: "calvin", newValue: "Some Bio", css: "cssString").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}
