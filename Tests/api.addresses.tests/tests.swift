import Combine
import XCTest
@testable import api_core
@testable import api_addresses

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
//    func testAddresses() {
//        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
//        
//        requests.append(manager.getAddresses()
//            .sink(receiveValue: { result in
//                if let _ = self.receiveValue(result) {
//                    // Check response
//                    self.responseValidation.fulfill()
//                }
//            }))
//        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
//    }
//    
//    func testAddressAvailabilityTrue() {
//        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
//        
//        requests.append(manager.getAddressAvailability("icalvin")
//            .sink(receiveValue: { result in
//                if let response = self.receiveValue(result) {
//                    XCTAssertEqual(response.available, true)
//                    self.responseValidation.fulfill()
//                }
//            }))
//        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
//    }
//    
//    func testAddressAvailabilityFalse() {
//        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
//        
//        requests.append(manager.getAddressAvailability("calvin")
//            .sink(receiveValue: { result in
//                if let response = self.receiveValue(result) {
//                    XCTAssertEqual(response.available, false)
//                    self.responseValidation.fulfill()
//                }
//            }))
//        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
//    }
//    
//    func testAddressExpiration() {
//        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
//        
//        requests.append(manager.getAddressExpiration("calvin")
//            .sink(receiveValue: { result in
//                if let _ = self.receiveValue(result) {
//                    // Check response
//                    self.responseValidation.fulfill()
//                }
//            }))
//        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
//    }
//    
//    func testAddressInfoAuthenticated() {
//        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
//        
//        requests.append(manager.getAddressInfo("calvin")
//            .sink(receiveValue: { result in
//                if let _ = self.receiveValue(result) {
//                    // Check response
//                    self.responseValidation.fulfill()
//                }
//            }))
//        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
//    }
//    
//    func testAddressInfoUnauthenticated() {
//        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
//        
//        requests.append(manager.getPublicAddressInfo("hotdogsladies")
//            .sink(receiveValue: { result in
//                if let _ = self.receiveValue(result) {
//                    // Check response
//                    self.responseValidation.fulfill()
//                }
//            }))
//        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
//    }
}

