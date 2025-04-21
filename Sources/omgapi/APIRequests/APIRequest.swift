//
//  APIRequests.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A marker protocol for types that can be encoded as the body of an API request.
protocol RequestBody: Encodable {
}

/// Allows raw `Data` to be used as a request body type.
extension Data: RequestBody { }

/// A singleton placeholder for requests or responses that require no body or data.
struct None: RequestBody, Response {
    /// Shared static instance of `None`.
    static let instance: None = { None() }()
    
    private init() { }
}

/// A generic API request model that includes authorization, method, path, and optional body.
///
/// - Parameters:
///   - B: The type of the request body, conforming to `RequestBody`.
///   - R: The type of the expected response, conforming to `Response`.
class APIRequest<B: RequestBody, R: Response> {
    
    /// Optional API credentials to include with the request.
    let authorization: APICredential?

    /// The HTTP method to use for the request (e.g. GET, POST).
    let method: HTTPMethod

    /// The target path of the API request.
    let path: Path

    /// Optional request body, encoded to JSON if present.
    let body: B?

    /// Whether the body should be encoded as multipart form data.
    let multipartBody: Bool
    
    /// Initializes a new APIRequest instance.
    ///
    /// - Parameters:
    ///   - authorization: Optional API credentials.
    ///   - method: The HTTP method for the request.
    ///   - path: The endpoint path for the request.
    ///   - body: Optional request body.
    ///   - multipartBody: Set to `true` for multipart/form-data encoding.
    init(
        authorization: APICredential? = nil,
        method: HTTPMethod = .GET,
        path: Path,
        body: B? = nil,
        multipartBody: Bool = false
    ) {
        self.authorization = authorization
        self.method = method
        self.path = path
        self.body = body
        self.multipartBody = multipartBody
    }
}
