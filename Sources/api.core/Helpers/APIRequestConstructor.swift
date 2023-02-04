//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

public class APIRequestConstructor {
    
    static let encoder: JSONEncoder = {
        var encoder = JSONEncoder()
        
        return encoder
    }()
    
    public let urlConstructor = APIURLConstructor()
    
    private var config: APIConfiguration?
    
    public var emailAddress: String? {
        if case let .registered(email, _) = config {
            return email
        }
        return nil
    }
    
    init(config: APIConfiguration = .anonymous) {
        updateConfiguration(config)
    }
    
    public func updateConfiguration(_ config: APIConfiguration) {
        self.config = config
    }
    
    public func request(method: HTTPMethod = .GET, with url: URL, bodyParameters: Encodable? = nil) -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        
        if case let .registered(_, key) = config {
            request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        }
        
        if let bodyParameters = bodyParameters {
            do {
                let bodyData = try Self.encoder.encode(bodyParameters)
                request.httpBody = bodyData
            } catch {
                // Do nothing, body won't be included and will return error
            }
        }
        
        return request
    }
}

public enum HTTPMethod: String {
    case GET
    case PATCH
    case POST
    case DELETE
}
