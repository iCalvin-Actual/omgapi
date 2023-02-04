import Combine
import XCTest
@testable import api_core
@testable import api_addresses

class APIManagerTests: XCTestCase, ObservableObject {
    
    var cancellationToken: AnyCancellable?
    
    let standardExpectation: XCTestExpectation = .init(description: "")
    
    func testAddresses() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAddresses()
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testAddressAvailabilityTrue() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAddressAvailability("icalvin")
            .sink(receiveValue: { result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.available, true)
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testAddressAvailabilityFalse() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAddressAvailability("calvin")
            .sink(receiveValue: { result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.available, false)
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testAddressExpiration() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAddressExpiration("calvin")
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testAddressInfoAuthenticated() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getAddressInfo("calvin")
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testAddressInfoUnauthenticated() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getPublicAddressInfo("hotdogsladies")
            .sink(receiveValue: { result in
                switch result {
                case .success:
                    self.standardExpectation.fulfill()
                case .failure(let error):
                    XCTFail("received error \(error)")
                }
            })
        wait(for: [standardExpectation], timeout: 5.0)
    }
}

