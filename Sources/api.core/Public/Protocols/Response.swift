//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import Foundation

public struct APIResponse<R: Response>: Decodable {
    struct Request: Decodable {
        let statusCode: Int
        let success: Bool
    }
    let request: Request
    public let response: R?
}

public protocol Response: Decodable {
}

public protocol CommonAPIResponse: Response {
    var message: String? { get }
}

public struct BasicResponse: CommonAPIResponse {
    public let message: String?
}

extension String: Response { }

extension Array where Element == Response { }
