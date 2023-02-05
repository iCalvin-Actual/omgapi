//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Combine
import Foundation

public typealias APIResult<T: Response> = Result<T, OMGAPI.APIError>
public typealias APIResultPublisher<T: Response> = AnyPublisher<APIResult<T>, Never>

public typealias ResultPublisher<T> = AnyPublisher<Result<T, OMGAPI.APIError>, Never>

public enum APIConfiguration {
    case anonymous
    case registered(email: String, apiKey: String)
    
    static let developRegistered: APIConfiguration = .registered(email: "accounts@icalvin.dev", apiKey: "09f5b7cc519758e4809851dfc98cecf5")
}

public class OMGAPI {
    
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
    
    public func publisher<B, R>(forMultiPart apiRequest: APIRequest<B, R>) -> APIResultPublisher<R> {
        let dataTask = urlSession.dataTaskPublisher(for: APIRequestConstructor.multipartUrlRequest(from: apiRequest))
        return publisher(for: dataTask)
    }
    
    public func publisher<B, R>(for request: APIRequest<B, R>) -> APIResultPublisher<R> {
        let dataTask = urlSession.dataTaskPublisher(for: APIRequestConstructor.urlRequest(from: request))
        return publisher(for: dataTask)
    }
    
    private func publisher<R>(for task: URLSession.DataTaskPublisher) -> APIResultPublisher<R> {
        task
            .map { data, response in
                do {
                    let result: APIResponse<R> = try OMGAPI.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        return .failure(.create(from: result))
                    }
                    
                    guard let response = result.response else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? OMGAPI.decoder.decode(APIResponse.self, from: data) {
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
                    let result: APIResponse<T> = try OMGAPI.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        return .failure(.create(from: result))
                    }
                    
                    guard let response = result.response else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? OMGAPI.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.create(from: errorMessageResponse))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
    
    public func getServiceInfo() -> ResultPublisher<String> {
        let request = GETServiceInfoAPIRequest()
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response.message ?? "")
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
