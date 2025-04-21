//
//  APIRequestConstructor.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A helper class to construct `URLRequest` instances from `APIRequest` definitions.
class APIRequestConstructor {
    
    /// Shared JSON encoder used for encoding request bodies.
    static let encoder: JSONEncoder = {
        var encoder = JSONEncoder()
        return encoder
    }()
    
    /// Constructs a multipart/form-data `URLRequest` from an `APIRequest`.
    ///
    /// - Parameter apiRequest: The `APIRequest` describing the endpoint and body.
    /// - Returns: A configured `URLRequest` with a multipart body, if applicable.
    static func multipartUrlRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = standardURLRequest(from: apiRequest)
        
        if let bodyParameters = apiRequest.body, O.Type.self != None.Type.self {
            do {
                request.httpBody = try createMultipartData(for: bodyParameters)
            } catch {
                // Do nothing, body won't be included and will return error
            }
        }
        
        return request
    }
    
    /// Constructs a standard application/json `URLRequest` from an `APIRequest`.
    ///
    /// - Parameter apiRequest: The `APIRequest` describing the endpoint and body.
    /// - Returns: A configured `URLRequest` with a JSON body, if applicable.
    static func urlRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = standardURLRequest(from: apiRequest)
        
        if let bodyParameters = apiRequest.body, O.Type.self != None.Type.self {
            do {
                request.httpBody = try createBodyData(for: bodyParameters)
            } catch {
                // Do nothing, body won't be included and will return error
            }
        }
        
        return request
    }
    
    /// Creates a base `URLRequest` from the properties of an `APIRequest`.
    ///
    /// - Parameter apiRequest: The request data including method, path, and authorization.
    /// - Returns: A base `URLRequest` without an HTTP body.
    private static func standardURLRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = URLRequest(url: apiRequest.path.url)
        request.httpMethod = apiRequest.method.rawValue
        
        if let key = apiRequest.authorization {
            request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    /// Encodes an `Encodable` body using the shared JSON encoder.
    ///
    /// - Parameter body: The request body to encode.
    /// - Returns: Encoded `Data` for JSON.
    /// - Throws: An error if encoding fails.
    private static func createBodyData<T: Encodable>(for body: T) throws -> Data {
        try Self.encoder.encode(body)
    }
    
    /// Creates a multipart/form-data encoded body wrapping the given `Encodable` as a single JSON part.
    ///
    /// This implementation wraps the JSON-encoded `body` in a multipart structure with a fixed boundary.
    /// The part is labeled `multipartData` and uses `application/json` as its content type.
    ///
    /// - Parameter body: The request body to encode and include in the multipart form.
    /// - Returns: A `Data` object representing the multipart body.
    /// - Throws: An error if encoding the body to JSON fails.
    private static func createMultipartData<T: Encodable>(for body: T) throws -> Data {
        let encoded = try createBodyData(for: body)
        var multipartData = Data()
        
        let lineBreak = "\r\n"
        let boundary: String = "Boundary-\(UUID().uuidString)"
        let file = "multipartData"
        let boundaryPrefix = "--\(boundary)\r\n"
        
        multipartData.append(Data(boundaryPrefix.utf8))
        multipartData.append(Data("Content-Disposition: form-data; name=\"\(file)\"\r\n".utf8))
        multipartData.append(Data("Content-Type: application/json;charset=utf-8\r\n\r\n".utf8))
        multipartData.append(encoded)
        multipartData.append(Data("\r\n".utf8))
        multipartData.append(Data("--\(boundary)--\(lineBreak)".utf8))
        
        return multipartData
    }
}
