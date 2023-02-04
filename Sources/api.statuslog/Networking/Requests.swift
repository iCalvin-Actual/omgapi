//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension APIRequestConstructor {
    private struct StatusParameter: Encodable {
        let id: String?
        let content: String
        let emoji: String?
        let externalUrl: String?
    }
    
    public func getStatusLog() -> URLRequest {
        request(with: urlConstructor.completeStatusLog())
    }
    
    public func getLatestStatusLog() -> URLRequest {
        request(with: urlConstructor.statusLogLatest())
    }
    
    public func getStatus(_ status: String, from address: String) -> URLRequest {
        request(with: urlConstructor.status(status, from: address))
    }
    
    public func getStatuses(for address: String) -> URLRequest {
        request(with: urlConstructor.statuses(for: address))
    }
    
    public func newStatus(from address: String, content: String, emoji: String? = nil, externalUrl: String? = nil) -> URLRequest {
        let parameters = StatusParameter(id: nil, content: content, emoji: emoji, externalUrl: externalUrl)
        return request(method: .POST, with: urlConstructor.statuses(for: address), bodyParameters: parameters)
    }
    
    public func editStatus(_ status: String, address: String, content: String, emoji: String? = nil, externalUrl: String? = nil) -> URLRequest {
        let parameters = StatusParameter(id: status, content: content, emoji: emoji, externalUrl: externalUrl)
        return request(method: .PATCH, with: urlConstructor.statuses(for: address), bodyParameters: parameters)
    }
    
    public func deleteStatus(_ status: String, address: String) -> URLRequest {
        request(method: .DELETE, with: urlConstructor.status(status, from: address))
    }
    
    public func getBio(for address: String) -> URLRequest {
        request(with: urlConstructor.bio(for: address))
    }
    
    public func updateBio(for address: String, with newValue: String?, css: String?) -> URLRequest {
        request(method: .POST, with: urlConstructor.bio(for: address), bodyParameters: ["content": newValue, "css": css])
    }
}
