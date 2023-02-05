import Combine
import XCTest
@testable import api_core
@testable import api_now

class APINowTests: APIManagerTest {
    
    let account: APICredentials = .init(emailAddress: "accounts@icalvin.dev", authKey: "09f5b7cc519758e4809851dfc98cecf5")
    
    func testFetchNow() {
        let manager = OMGAPI()
        
        manager.getNow(for: "calvin")
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
    
    func testUpdateNow() {
        let manager = OMGAPI()
        let draft = Now.Draft(content: "Some New Content", listed: false)
        var existingNow: String?
        
        manager.updateNow(draft, for: "calvin", credentials: account)
            .flatMap { result in
                switch result {
                case .success(let response):
                    existingNow = response.content
                    return manager.updateNow(draft, for: "calvin", credentials: self.account)
                case .failure(let error):
                    return AnyPublisher(Just(.failure(error)))
                }
            }
            .flatMap({ _ -> ResultPublisher<Now> in
                let newDraft = Now.Draft(content: existingNow ?? "", listed: true)
                return manager.updateNow(newDraft, for: "calvin", credentials: self.account)
            })
            .sink(receiveValue: { result in
                if case .success = result {
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [responseValidation], timeout: 5.0)
    }
    
    func testNowGarden() {
        let manager = OMGAPI()
        manager.set(configuration: .developRegistered)
        
        manager.getNowGarden()
            .sink(receiveValue: { result in
                if let _ = self.receiveValue(result) {
                    // Check response
                    self.responseValidation.fulfill()
                }
            })
            .store(in: &requests)
        
        wait(for: [successfulResponse, responseValidation], timeout: 5.0)
    }
}
