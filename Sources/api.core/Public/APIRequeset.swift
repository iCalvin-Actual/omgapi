//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

open class APIRequest<B: RequestBody, R: Response> {
    
    let authorization: String?
    let method: HTTPMethod
    let path: APIPath
    let body: B?
    let multipartBody: Bool
    
    public init(authorization: String? = nil, method: HTTPMethod = .GET, path: APIPath, body: B? = nil, multipartBody: Bool = false) {
        self.authorization = authorization
        self.method = method
        self.path = path
        self.body = body
        self.multipartBody = multipartBody
    }
}
