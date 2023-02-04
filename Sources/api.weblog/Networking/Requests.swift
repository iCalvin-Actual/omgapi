//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension APIRequestConstructor {
    public func blogConfiguration(for address: String) -> URLRequest {
        request(with: urlConstructor.blogConfiguration(for: address))
    }
    
    public func updateBlogConfiguration(for address: String, with newValue: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.blogConfiguration(for: address), bodyParameters: newValue)
    }
    
    public func blogTemplate(for address: String) -> URLRequest {
        request(with: urlConstructor.blogTemplate(for: address))
    }
    
    public func updateBlogTemplate(for address: String, with newValue: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.blogTemplate(for: address), bodyParameters: newValue)
    }
    
    public func blogEntries(for address: String) -> URLRequest {
        request(with: urlConstructor.blogEntries(for: address))
    }
    
    public func latestBlogEntry(for address: String) -> URLRequest {
        request(with: urlConstructor.latestBlogEntry(for: address))
    }
    
    public func getBlogEntry(_ entry: String, from address: String) -> URLRequest {
        request(with: urlConstructor.manageEntry(entry, for: address))
    }
    
    public func setBlogEntry(_ entry: String, from address: String, content: String) -> URLRequest {
        request(method: .POST, with: urlConstructor.manageEntry(entry, for: address), bodyParameters: content)
    }
    
    public func deleteBlogEntry(_ entry: String, from address: String) -> URLRequest {
        request(method: .DELETE, with: urlConstructor.manageEntry(entry, for: address))
    }
}
