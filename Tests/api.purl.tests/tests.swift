import Combine
import XCTest
@testable import api_core
@testable import api_purl

class APIManagerTests: XCTestCase, ObservableObject {
    
    var cancellationToken: AnyCancellable?
    
    let standardExpectation: XCTestExpectation = .init(description: "")
    
    func testGetPurls() {
        let manager = APIManager()
//        manager.set(configuration: .developRegistered)

        cancellationToken = manager.getPURLs(from: "hotdogsladies").sink(receiveValue: { result in
            switch result {
            case .success:
                self.standardExpectation.fulfill()
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testCreatePurl() {
        let draft = DraftPURL(name: "testing", url: "https://daringFireball.com")
        
        let manager = APIManager()
        manager.set(configuration: .developRegistered)

        cancellationToken = manager.createPurl(for: "calvin", draft: draft).sink(receiveValue: { result in
            switch result {
            case .success:
                self.standardExpectation.fulfill()
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testGetPurl() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)

        cancellationToken = manager.getPurl(purl: "async", for: "calvin").sink(receiveValue: { result in
            switch result {
            case .success:
                self.standardExpectation.fulfill()
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testDeletePurl() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)

        cancellationToken = manager.deletePurl(purl: "testing", from: "calvin").sink(receiveValue: { result in
            switch result {
            case .success:
                self.standardExpectation.fulfill()
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        })
        wait(for: [standardExpectation], timeout: 5.0)
    }
}

