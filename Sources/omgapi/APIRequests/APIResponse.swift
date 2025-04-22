//
//  APIResponse.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Combine
import Foundation

/// A marker protocol indicating a type can be decoded as an API response.
protocol Response: Decodable {
}

/// A generic container for decoding omg.lol API responses.
///
/// The top-level object contains a `request` section for metadata and a `response`
/// section with the actual result payload.
struct APIResponse<R: Response>: Decodable {
    
    /// Metadata about the API request.
    struct Request: Decodable {
        /// HTTP status code returned by the API.
        let statusCode: Int
        
        /// Whether the API call was reported as successful.
        let success: Bool
        
        init(statusCode: Int, success: Bool) {
            self.statusCode = statusCode
            self.success = success
        }
    }

    /// Metadata about the request.
    let request: Request

    /// The decoded payload returned from the API.
    let result: R?

    enum CodingKeys: String, CodingKey {
        case request
        case result = "response"
    }
    
    init(request: Request, result: R?) {
        self.request = request
        self.result = result
    }
}

/// A protocol for simple omg.lol API responses that include a message.
protocol CommonAPIResponse: Response {
    /// Optional message returned by the API.
    var message: String? { get }
}

/// A basic response object containing an optional message.
struct BasicResponse: CommonAPIResponse {
    let message: String?
}

/// Conforms `String` to `Response` to allow raw string payloads.
extension String: Response { }
extension Data: Response { }

/// Placeholder extension (empty) for arrays of `Response` values.
extension Array where Element == Response { }

/// A type alias for handling decoded API responses with result or error.
typealias APIResult<T: Response> = Result<T, APIError>

/// A publisher that emits one `APIResult` and completes.
typealias APIResultPublisher<T: Response> = AnyPublisher<APIResult<T>, Never>

/// A generic result-based publisher that emits one `Result` and completes.
typealias ResultPublisher<T> = AnyPublisher<Result<T, APIError>, Never>
