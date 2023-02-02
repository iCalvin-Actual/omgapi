//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Combine
import Foundation

typealias APIResult<T: Response> = Result<T, APIManager.APIError>
typealias APIResultPublisher<T: Response> = AnyPublisher<APIResult<T>, Never>

enum APIConfiguration {
    case anonymous
    case registered(email: String, apiKey: String)
    
    static let developRegistered: APIConfiguration = .registered(email: "accounts@icalvin.dev", apiKey: "09f5b7cc519758e4809851dfc98cecf5")
}

class APIManager {
    
    enum APIError: Error {
        case inconceivable
        
        case unauthenticated
        
        case badBody
        case badResponseEncoding
        
        case unhandled(_ statusCode: Int, message: String?)
    }
    
    static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    let requestConstructor = APIRequestConstructor()
    let urlSession: URLSession = .shared
    
    func set(configuration: APIConfiguration) {
        requestConstructor.updateConfiguration(configuration)
    }
    
    func requestPublisher<T: Response>(_ request: URLRequest) -> APIResultPublisher<T> {
        urlSession.dataTaskPublisher(for: request)
            .map { data, response in
                print("In 'perform request")
                do {
                    let result: APIResponse<T> = try APIManager.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        var message: String?
                        if let responseMessage = (result.response as? CommonAPIResponse)?.message {
                            message = responseMessage
                        }
                        return .failure(.unhandled(result.request.statusCode, message: message))
                    }
                    
                    guard let response = result.response else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? APIManager.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.unhandled(errorMessageResponse.request.statusCode, message: errorMessageResponse.response?.message))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
}
