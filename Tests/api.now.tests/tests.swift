import Combine
import XCTest
@testable import api_core
@testable import api_now

class APIManagerTests: XCTestCase, ObservableObject {
    
    var cancellationToken: AnyCancellable?
    
    let standardExpectation: XCTestExpectation = .init(description: "")
    
    func testFetchNow() {
        let manager = APIManager()
//        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getNow("calvin")
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
    
    func testUpdateNow() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.updateNow(for: "calvin", content: "Now Now, Hope I have a backup!", listed: true)
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
    
    func testNowGarden() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getNowGarden()
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
