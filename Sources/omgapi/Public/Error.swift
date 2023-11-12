//
//  Error.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public enum APIError: Error, Equatable {
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
