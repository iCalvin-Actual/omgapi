//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

open class APIRequest<B: RequestBody, R: Response> {
    
    var authorization: String?
    var method: HTTPMethod
    var path: APIPath
    var body: B?
    
    public init(authorization: String? = nil, method: HTTPMethod = .GET, path: APIPath, body: B? = nil) {
        self.authorization = authorization
        self.method = method
        self.path = path
        self.body = body
    }
}
