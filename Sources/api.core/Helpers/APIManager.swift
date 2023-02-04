//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Combine
import Foundation

public typealias APIResult<T: Response> = Result<T, APIManager.APIError>
public typealias APIResultPublisher<T: Response> = AnyPublisher<APIResult<T>, Never>

public enum APIConfiguration {
    case anonymous
    case registered(email: String, apiKey: String)
    
    static let developRegistered: APIConfiguration = .registered(email: "accounts@icalvin.dev", apiKey: "09f5b7cc519758e4809851dfc98cecf5")
}

public class APIManager {
    
    public enum APIError: Error {
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
    
    public let requestConstructor = APIRequestConstructor()
    
    let urlSession: URLSession = .shared
    
    public init() {
    }
    
    public func set(configuration: APIConfiguration) {
        requestConstructor.updateConfiguration(configuration)
    }
    
    public func requestPublisher<T: Response>(_ request: URLRequest) -> APIResultPublisher<T> {
        urlSession.dataTaskPublisher(for: request)
            .map { data, response in
                do {
                    let result: APIResponse<T> = try APIManager.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        let status = result.request.statusCode
                        var message: String?
                        if let responseMessage = (result.response as? CommonAPIResponse)?.message {
                            message = responseMessage
                        }
                        switch status {
                        case 401:
                            return .failure(.unauthenticated)
                        default:
                            return .failure(.unhandled(result.request.statusCode, message: message))
                        }
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
