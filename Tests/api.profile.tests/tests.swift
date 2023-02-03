import Combine
import XCTest
@testable import api_core
@testable import api_profile

class APIManagerTests: XCTestCase, ObservableObject {
    
    var cancellationToken: AnyCancellable?
    
    let standardExpectation: XCTestExpectation = .init(description: "")
    
    func testProfile() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.getProfile("hotdogsladies").sink(receiveValue: { result in
            switch result {
            case .success:
                self.standardExpectation.fulfill()
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        })
        wait(for: [standardExpectation], timeout: 5.0)
    }
    
    func testUpdateProfile() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        cancellationToken = manager.updateProfile("calvin", newContent: """
{profile-picture}

# Calvin C

| Pronouns: He/They
| Gender: Non-Binary {venus-mars}
| Occupation: Engineer
| Location: Salem, MA
""", publish: false).sink(receiveValue: { result in
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

