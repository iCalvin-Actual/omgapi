//
//  APIResponse.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Combine
import Foundation

protocol Response: Decodable {
}

struct APIResponse<R: Response>: Decodable {
    struct Request: Decodable {
        let statusCode: Int
        let success: Bool
    }
    let request: Request
    let response: R?
}

protocol CommonAPIResponse: Response {
    var message: String? { get }
}

struct BasicResponse: CommonAPIResponse {
    let message: String?
}

extension String: Response { }

extension Array where Element == Response { }

typealias APIResult<T: Response> = Result<T, APIError>
typealias APIResultPublisher<T: Response> = AnyPublisher<APIResult<T>, Never>
typealias ResultPublisher<T> = AnyPublisher<Result<T, APIError>, Never>

