//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

extension APIManager {
    public func blogConfiguration(for address: String) -> APIResultPublisher<BlogConfigurationResponse> {
        let request = requestConstructor.blogConfiguration(for: address)
        return requestPublisher(request)
    }
    
    public func updateConfiguration(for address: String, newValue: String) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.updateBlogConfiguration(for: address, with: newValue)
        return requestPublisher(request)
    }
    
    public func blogTemplate(for address: String) -> APIResultPublisher<BlogTemplateResponse> {
        let request = requestConstructor.blogTemplate(for: address)
        return requestPublisher(request)
    }
    
    public func updateTemplate(for address: String, newValue: String) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.updateBlogTemplate(for: address, with: newValue)
        return requestPublisher(request)
    }
    
    public func getBlogEntries(for address: String) -> APIResultPublisher<BlogEntriesResponse> {
        let request = requestConstructor.blogEntries(for: address)
        return requestPublisher(request)
    }
    
    public func getLatestBlogEntry(for address: String) -> APIResultPublisher<BlogEntryResponse> {
        let request = requestConstructor.latestBlogEntry(for: address)
        return requestPublisher(request)
    }
    
    public func getBlogEntry(_ entry: String, for address: String) -> APIResultPublisher<BlogEntryResponse> {
        let request = requestConstructor.getBlogEntry(entry, from: address)
        return requestPublisher(request)
    }
    
    public func createBlogEntry(_ draft: DraftBlogEntry, for address: String) -> APIResultPublisher<BlogEntryResponse> {
        let request = requestConstructor.setBlogEntry(draft.entryName, from: address, content: draft.content)
        return requestPublisher(request)
    }
    
    public func updateBlogEntry(entry: String, for address: String, newValue draft: DraftBlogEntry) -> APIResultPublisher<BlogEntryResponse> {
        let request = requestConstructor.setBlogEntry(entry, from: address, content: draft.content)
        return requestPublisher(request)
    }
    
    public func deleteBlogEntry(_ entry: String, for address: String) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.deleteBlogEntry(entry, from: address)
        return requestPublisher(request)
    }
}
