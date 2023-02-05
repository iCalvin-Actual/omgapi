import Combine
import XCTest
@testable import api_core
@testable import api_weblog

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testBlogConfiguration() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.blogConfiguration(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateBlogConfiguration() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.updateConfiguration(for: "calvin", newValue: "New Config String").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testBlogTemplate() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.blogTemplate(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateBlogTemplate() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.updateTemplate(for: "calvin", newValue: "New Blog Template").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testBlogEntries() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.getBlogEntries(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testLatestBlogEntry() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.getLatestBlogEntry(for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testGetEntry() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.getBlogEntry("63d958739578c", for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testNewEntry() {
        let draft = DraftBlogEntry(entryName: "testEntry", content: "Blog Content")
        
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.createBlogEntry(draft, for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateEntry() {
        let draft = DraftBlogEntry(entryName: "AnotherTestEntry", content: "Different Content")
        
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.updateBlogEntry(entry: "testEntry", for: "calvin", newValue: draft).sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testDeleteEntry() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)

        requests.append(manager.deleteBlogEntry("testentry", for: "calvin").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
}
