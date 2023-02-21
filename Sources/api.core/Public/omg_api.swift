//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Combine
import Foundation

public typealias APIResult<T: Response> = Result<T, omg_api.APIError>
public typealias APIResultPublisher<T: Response> = AnyPublisher<APIResult<T>, Never>

public typealias ResultPublisher<T> = AnyPublisher<Result<T, omg_api.APIError>, Never>

public class omg_api {
    
    public enum APIError: Error {
        case inconceivable
        
        case unauthenticated
        
        case notFound
        
        case badBody
        case badResponseEncoding
        
        case unhandled(_ statusCode: Int, message: String?)
        
        static func create<R>(from response: APIResponse<R>?) -> APIError {
            guard let response = response else {
                return .inconceivable
            }
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
    
    public static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    public let requestConstructor = APIRequestConstructor()
    
    let urlSession: URLSession = .shared
    
    public var requests: [AnyCancellable] = []
    
    public init() {
    }
    
    public func apiResponse<B, R>(for request: APIRequest<B, R>, fallbackDecoding: ((Data) -> R?)? = nil) async throws -> R {
        let urlRequest: URLRequest
        switch request.multipartBody {
        case true:
            urlRequest = APIRequestConstructor.multipartUrlRequest(from: request)
        case false:
            urlRequest = APIRequestConstructor.urlRequest(from: request)
        }
        
        let task = urlSession.dataTaskPublisher(for: urlRequest)
        let publisher: APIResultPublisher<R> = publisher(for: task, fallbackDecoding: fallbackDecoding)
        
        return try await withCheckedThrowingContinuation({ continuation in
            publisher
                .sink { result in
                    switch result {
                    case .success(let log):
                        continuation.resume(returning: log)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
                .store(in: &self.requests)
        })
    }
    
    public func multipartPublisher<B, R>(for request: APIRequest<B, R>) -> APIResultPublisher<R> {
        let dataTask = urlSession.dataTaskPublisher(for: APIRequestConstructor.multipartUrlRequest(from: request))
        return publisher(for: dataTask, fallbackDecoding: nil)
    }
    
    public func publisher<B, R>(for request: APIRequest<B, R>, fallbackDecoding: ((Data) -> R?)? = nil) -> APIResultPublisher<R> {
        let dataTask = urlSession.dataTaskPublisher(for: APIRequestConstructor.urlRequest(from: request))
        return publisher(for: dataTask, fallbackDecoding: fallbackDecoding)
    }
    
    private func publisher<R>(for task: URLSession.DataTaskPublisher, fallbackDecoding: ((Data) -> R?)?) -> APIResultPublisher<R> {
        task
            .map { data, response in
                do {
                    if R.self is String.Type, let rawResponse = String(data: data, encoding: .utf8) {
                        return .success(rawResponse as! R)
                    } else {
                        let apiResponse = try omg_api.decoder.decode(APIResponse<R>.self, from: data)
                        guard apiResponse.request.success else {
                            return .failure(.create(from: apiResponse))
                        }
                        
                        guard let response = apiResponse.response else {
                            return .failure(.badResponseEncoding)
                        }
                        
                        return .success(response)
                    }
                }
                catch {
                    if let result = fallbackDecoding?(data) {
                        return .success(result)
                    } else if let errorMessageResponse: APIResponse<BasicResponse> = try? omg_api.decoder.decode(APIResponse.self, from: data) {
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
                    let result: APIResponse<T> = try omg_api.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        return .failure(.create(from: result))
                    }
                    
                    guard let response = result.response else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? omg_api.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.create(from: errorMessageResponse))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
}
