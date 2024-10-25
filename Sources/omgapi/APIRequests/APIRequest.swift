//
//  APIRequests.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

protocol RequestBody: Encodable {
}

extension Data: RequestBody { }

struct None: RequestBody, Response {
    static let instance: None = { None() }()
    
    private init() { }
}

class APIRequest<B: RequestBody, R: Response> {
    
    let authorization: APICredential?
    let method: HTTPMethod
    let path: Path
    let body: B?
    let multipartBody: Bool
    
    init(authorization: APICredential? = nil, method: HTTPMethod = .GET, path: Path, body: B? = nil, multipartBody: Bool = false) {
        self.authorization = authorization
        self.method = method
        self.path = path
        self.body = body
        self.multipartBody = multipartBody
    }
}
