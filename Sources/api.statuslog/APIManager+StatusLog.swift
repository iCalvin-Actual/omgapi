//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

public extension omg_api {
    
    func completeStatusLog() async throws -> PublicLog {
        let request = GETCompleteStatusLog()
        let response = try await apiResponse(for: request)
        return PublicLog(statuses: response.statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        })
    }
    
    func latestStatusLog() async throws -> PublicLog {
        let request = GETLatestStatusLogs()
        let response = try await apiResponse(for: request)
        return PublicLog(statuses: response.statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        })
    }
    
    func statusLog(from address: AddressName) async throws -> StatusLog {
        async let logs = try logs(for: address)
        async let bio = try bio(for: address)
        
        return await StatusLog(
            address: address,
            bio: try bio,
            statuses: try logs
        )
    }
    
    func logs(for address: String) async throws -> [Status] {
        let request = GETAddressStatuses(address)
        let response = try await apiResponse(for: request)
        return response.statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        }
    }
    
    func bio(for address: String) async throws -> StatusLog.Bio {
        let request = GETAddressStatusBio(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            if let response = try? omg_api.decoder.decode(APIResponse<StatusLogBioResponseModel>.self, from: data) {
                if response.response?.message?.lowercased().hasPrefix("couldn’t find a statuslog bio for") ?? false {
                    return response.response
                }
            }
            return nil
        })
        return .init(content: response.bio ?? "")
    }
    
    func save(draft: StatusLog.Bio.Draft, for address: AddressName, credential: APICredentials) async throws -> StatusLog.Bio {
        let request = SETAddressStatusBio(draft, for: address, authorization: credential.authKey)
        let _ = try await apiResponse(for: request)
        return try await bio(for: address)
    }
    
    func status(_ status: String, from address: AddressName) async throws -> Status {
        let request = GETAddressStatus(status, from: address)
        let response = try await apiResponse(for: request)
        return Status(
            id: response.status.id,
            address: response.status.address,
            created: response.status.createdDate,
            content: response.status.content,
            emoji: response.status.emoji,
            externalURL: response.status.externalURL
        )
    }
    
    func save(_ draft: Status.Draft, to address: AddressName, with credentials: APICredentials) async throws -> Status {
        let request = SETAddressStatus(draft, from: address, with: credentials.authKey)
        let response = try await apiResponse(for: request)
        return try await status(response.id, from: address)
    }
    
    func delete(_ status: String, from address: AddressName, with credentials: APICredentials) async throws {
        let request = DELETEAddressStatus(status, from: address, with: credentials.authKey)
        let _ = try await apiResponse(for: request)
    }
}
