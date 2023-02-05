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
        
        manager.set(configuration: .developRegistered)
            .flatMap { result in
                switch result {
                case .success(let response):
                    existingNow = response.content
                    return manager.updateNow(draft, for: "calvin", credentials: self.account)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            }
            .flatMap({ _ in
                manager.updateNow(.init(content: existingNow ?? "", listed: true), for: "calvin", credentials: self.account)
                    .eraseToAnyPublisher()
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
