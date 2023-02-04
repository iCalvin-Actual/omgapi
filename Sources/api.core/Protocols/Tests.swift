import Combine
import XCTest

protocol APITest {
    
    var requests: [AnyCancellable] { get }
    
    var successfulResponse: XCTestExpectation { get }
    var responseValidation: XCTestExpectation { get }
}

extension APITest {
    func receiveValue<R>(_ result: Result<R, APIManager.APIError>) -> R? {
        switch result {
        case .success(let response):
            successfulResponse.fulfill()
            return response
        case .failure(let error):
            XCTFail("Failed \(error)")
            return nil
        }
    }
}
