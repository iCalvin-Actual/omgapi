import Combine
import XCTest
@testable import api_core
@testable import api_profile

class APIAccountTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testPublicProfile() {
        let manager = OMGAPI()
        
        manager.getPublicProfile("hotdogsladies")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testProfile() {
        let manager = OMGAPI()
        
        manager.getProfile("calvin", with: account)
            .sink(receiveValue: { result in
                self.responseValidation.fulfill()
            })
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateProfile() {
        let manager = OMGAPI()
        let draft = PublicProfile.Draft(content: "New profile content")
        
        manager.updateProfile(draft, for: "calvin", with: account)
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testProfilePhoto() {
        let manager = OMGAPI()
        
        manager.getAddressPhoto("calvin", with: account)
            .sink(receiveValue: { result in
                self.responseValidation.fulfill()
            })
            .store(in: &requests)
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}

