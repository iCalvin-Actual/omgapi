import Combine
import XCTest
@testable import api_core
@testable import api_profile

class APIManagerTests: XCTestCase, APITest {
    
    var requests: [AnyCancellable] = []
    
    let successfulResponse: XCTestExpectation = .init(description: "")
    let responseValidation: XCTestExpectation = .init(description: "")
    
    func testProfile() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.getProfile("hotdogsladies").sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateProfile() {
        let manager = APIManager()
        manager.set(configuration: .developRegistered)
        
        requests.append(manager.updateProfile("calvin", newContent: """
{profile-picture}

# Calvin C

| Pronouns: He/They
| Gender: Non-Binary {venus-mars}
| Occupation: Engineer
| Location: Salem, MA
""", publish: false).sink(receiveValue: { result in
            if let _ = self.receiveValue(result) {
                // Check response
                self.responseValidation.fulfill()
            }
        }))
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

