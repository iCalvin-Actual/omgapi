//
//  APIRequestConstructor.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A helper class to construct `URLRequest` instances from `APIRequest` definitions.
final class APIRequestConstructor: Sendable {
    
    /// Shared JSON encoder used for encoding request bodies.
    ///
    /// Encodes keys as snake_case to mirror `api.decoder`'s snake_case
    /// conversion — the omg.lol API uses snake_case in both directions
    /// (e.g. `Status.Draft.externalUrl` must be sent as `external_url`).
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    /// Constructs a standard application/json `URLRequest` from an `APIRequest`.
    ///
    /// - Parameter apiRequest: The `APIRequest` describing the endpoint and body.
    /// - Returns: A configured `URLRequest` with a JSON body, if applicable.
    /// - Throws: `api.Error.badBody` if the body fails to encode, rather than
    ///   silently sending the request without a body.
    static func urlRequest<O, I>(from apiRequest: APIRequest<O, I>) throws -> URLRequest {
        var request = standardURLRequest(from: apiRequest)

        if let bodyParameters = apiRequest.body, O.Type.self != None.Type.self {
            do {
                request.httpBody = try createBodyData(for: bodyParameters)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw api.Error.badBody
            }
        }

        return request
    }
    
    /// Creates a base `URLRequest` from the properties of an `APIRequest`.
    ///
    /// - Parameter apiRequest: The request data including method, path, and authorization.
    /// - Returns: A base `URLRequest` without an HTTP body.
    static func standardURLRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = URLRequest(url: apiRequest.path.url)
        request.httpMethod = apiRequest.method.rawValue
        
        if let key = apiRequest.authorization {
            request.addValue(key.headerValue, forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    /// Encodes an `Encodable` body using the shared JSON encoder.
    ///
    /// - Parameter body: The request body to encode.
    /// - Returns: Encoded `Data` for JSON.
    /// - Throws: An error if encoding fails.
    static func createBodyData<T: Encodable>(for body: T) throws -> Data {
        try Self.encoder.encode(body)
    }
}
