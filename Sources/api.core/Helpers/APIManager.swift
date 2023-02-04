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

public typealias ResultPublisher<T> = AnyPublisher<Result<T, APIManager.APIError>, Never>

public enum APIConfiguration {
    case anonymous
    case registered(email: String, apiKey: String)
    
    static let developRegistered: APIConfiguration = .registered(email: "accounts@icalvin.dev", apiKey: "09f5b7cc519758e4809851dfc98cecf5")
}

public class APIManager {
    
    public enum APIError: Error {
        case inconceivable
        
        case unauthenticated
        
        case notFound
        
        case badBody
        case badResponseEncoding
        
        case unhandled(_ statusCode: Int, message: String?)
        
        static func create<R>(from response: APIResponse<R>) -> APIError {
            let status = response.request.statusCode
            var message: String?
            if let responseMessage = (response.response as? CommonAPIResponse)?.message {
                message = responseMessage
            }
            switch status {
            case 401:
                return .unauthenticated
            case 404:
                return .notFound
            default:
                return .unhandled(status, message: message)
            }
        }
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
    
    public func publisher<B, R>(for request: APIRequest<B, R>) -> APIResultPublisher<R> {
        urlSession.dataTaskPublisher(for: APIRequestConstructor.urlRequest(from: request))
            .map { data, response in
                do {
                    let result: APIResponse<R> = try APIManager.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        return .failure(.create(from: result))
                    }
                    
                    guard let response = result.response else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? APIManager.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.create(from: errorMessageResponse))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
    
    public func requestPublisher<T: Response>(_ request: URLRequest) -> APIResultPublisher<T> {
        urlSession.dataTaskPublisher(for: request)
            .map { data, response in
                do {
                    let result: APIResponse<T> = try APIManager.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        return .failure(.create(from: result))
                    }
                    
                    guard let response = result.response else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? APIManager.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.create(from: errorMessageResponse))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
}
