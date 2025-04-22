//
//  Error.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents errors that can occur while interacting with the omg.lol API.
public enum APIError: Error, Equatable {
    /// Placeholder value to indicate no error actually occured
    case none
    
    /// An internal value used only for cases that shouldn't happen in normal usage
    case inconceivable

    /// The request had missing or invalid credentials
    case unauthenticated

    /// The requested resource either does not exist or is not public
    case notFound

    /// The request body was malformed or invalid.
    case badBody

    /// The response could not be decoded from the expected format.
    case badResponseEncoding

    /// A non-specific error with an unhandled HTTP status code and optional message.
    ///
    /// - Parameters:
    ///   - statusCode: The HTTP status code returned by the server.
    ///   - message: An optional error message from the API.
    case unhandled(_ statusCode: Int, message: String?)

    /// Creates an appropriate `APIError` based on an `APIResponse`.
    ///
    /// - Parameter response: The decoded response from the API, if any.
    /// - Returns: A corresponding `APIError` instance.
    static func create<R>(from response: APIResponse<R>?) -> APIError {
        guard let response = response else {
            return .inconceivable
        }

        let status = response.request.statusCode

        switch status {
        case 401:
            return .unauthenticated
        case 404:
            return .notFound
        default:
            if response.request.success {
                return .none
            }
            var message: String?

            if let responseMessage = (response.result as? CommonAPIResponse)?.message {
                message = responseMessage
            }
            
            return .unhandled(status, message: message)
        }
    }
}
