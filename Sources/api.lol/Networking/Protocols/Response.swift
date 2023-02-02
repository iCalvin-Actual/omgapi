//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/1/23.
//

import Foundation

struct APIResponse<R: Response>: Decodable {
    struct Request: Decodable {
        let statusCode: Int
        let success: Bool
    }
    let request: Request
    let response: R?
}

protocol Response: Decodable {
}

protocol CommonAPIResponse: Response {
    var message: String? { get }
}

struct BasicResponse: CommonAPIResponse {
    let message: String?
}

extension String: Response { }
