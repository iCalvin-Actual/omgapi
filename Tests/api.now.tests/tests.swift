import Combine
import XCTest
@testable import api_core
@testable import api_now

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testFetchNow() {
        let manager = OMGAPI()
//        manager.set(configuration: .developRegistered)
        
        requests.append(manager.getNow("calvin")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateNow() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.updateNow(for: "calvin", content: "Now Now, Hope I have a backup!", listed: true)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testNowGarden() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.getNowGarden()
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}
