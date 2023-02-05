//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

extension OMGAPI {
    func getCompleteStatusLog() -> APIResultPublisher<StatusLogResponseModel> {
        let request = requestConstructor.getStatusLog()
        return requestPublisher(request)
    }
    
    func getLatestStatusLog() -> APIResultPublisher<StatusLogResponseModel> {
        let request = requestConstructor.getStatusLog()
        return requestPublisher(request)
    }
    
    func getStatuses(for address: String) -> APIResultPublisher<StatusLogResponseModel> {
        let request = requestConstructor.getStatuses(for: address)
        return requestPublisher(request)
    }
    
    func getStatus(_ status: String, for address: String) -> APIResultPublisher<StatusResponseModel> {
        let request = requestConstructor.getStatus(status, from: address)
        return requestPublisher(request)
    }
    
    func postStatus(_ draft: DraftStatus, for address: String) -> APIResultPublisher<NewStatusResponseModel> {
        let request = requestConstructor.newStatus(from: address, content: draft.content, emoji: draft.emoji, externalUrl: draft.externalUrl)
        return requestPublisher(request)
    }
    
    func editStatus(_ status: String, for address: String, with newValue: DraftStatus) -> APIResultPublisher<NewStatusResponseModel> {
        let request = requestConstructor.editStatus(status, address: address, content: newValue.content, emoji: newValue.emoji, externalUrl: newValue.externalUrl)
        return requestPublisher(request)
    }
    
    func deleteStatus(_ status: String, for address: String) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.deleteStatus(status, address: address)
        return requestPublisher(request)
    }
    
    func statusLogBio(for address: String) -> APIResultPublisher<StatusLogBioResponseModel> {
        let request = requestConstructor.getBio(for: address)
        return requestPublisher(request)
    }
    
    func updateStatusLogBio(for address: String, newValue: String?, css: String?) -> APIResultPublisher<StatusLogBioResponseModel> {
        let request = requestConstructor.updateBio(for: address, with: newValue, css: css)
        return requestPublisher(request)
    }
}
