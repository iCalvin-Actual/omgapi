//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Retrieves the complete public ``StatusLog`` feed from omg.lol from the beginning of time.
    /// - Returns: A ``StatusLog`` containing all  statuses posted to omg.lol.
    func completeStatuslog() async throws -> StatusLog {
        let request = GETCompleteStatusLog()
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return statuses.map { status in
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
    
    /// Retrieves the latest ``Status`` entry from each ``AddressName`` in a sequential array
    /// - Returns: A `StatusLog` of recent statuses.
    func latestStatuslog() async throws -> StatusLog {
        let request = GETLatestStatusLogs()
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return statuses.map { status in
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
    
    /// Retrieves every ``Status`` posted by a specific omg.lol ``AddressName``.
    /// 
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of `Status` entries.
    func logs(for address: AddressName) async throws -> StatusLog {
        guard !address.isEmpty else {
            return []
        }
        let request = GETAddressStatuses(address)
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return statuses.map { status in
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
    
    /// Returns the biography text set by the Address owner to appear alongside the user's ``StatusLog``.
    ///
    /// - Parameter address: The omg.lol address.
    /// - Returns: A `StatusLog.Bio` object.
    func bio(for address: AddressName) async throws -> Bio {
        let request = GETAddressStatusBio(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            if let response = try? api.decoder.decode(APIResponse<StatusLogBioResponseModel>.self, from: data) {
                if response.result?.message?.lowercased().hasPrefix("couldn’t find a statuslog bio for") ?? false {
                    return response.result
                }
            }
            return nil
        })
        return .init(content: response.bio ?? "")
    }
    
    /// Updates the biography for the given `AddressName`
    ///
    /// - Parameters:
    ///   - draft: The model that contains the updated markdown text.
    ///   - address: The `AddressName` to apply the update to
    ///   - credential: An appropriate APICredential for the given `AddressName`
    func saveBio(_ draft: Bio.Draft, for address: AddressName, credential: APICredential) async throws -> Bio {
        let request = SETAddressStatusBio(draft, for: address, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await bio(for: address)
    }
    
    /// Fetches a specific ``Status`` entry by ID.
    /// - Parameters:
    ///   - status: The status ID.
    ///   - address: The omg.lol address that owns the status.
    /// - Returns: A `Status` object.
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
    
    /// Deletes a specific ``Status`` and returns the removed content.
    /// - Parameters:
    ///   - status: A draft containing the ID of the status to delete.
    ///   - address: The omg.lol address that owns the status.
    ///   - credential: API credential with permission to delete.
    /// - Returns: The deleted `Status` for reference.
    func deleteStatus(_ status: Status.Draft, from address: AddressName, credential: APICredential) async throws -> Status? {
        guard let id = status.id else {
            return nil
        }
        let request = DELETEAddressStatus(status, from: address, authorization: credential)
        let backup = try await self.status(id, from: address)
        let _ = try await apiResponse(for: request)
        return backup
    }
    
    /// Creates or updates a ``Status`` entry.
    /// - Parameters:
    ///   - draft: The status content and optional metadata.
    ///   - address: The omg.lol address to post to.
    ///   - credential: API credential for write access.
    /// - Returns: The newly created or updated `Status`.
    func saveStatus(_ draft: Status.Draft, to address: AddressName, credential: APICredential) async throws -> Status {
        let request = SETAddressStatus(draft, with: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return try await status(response.id, from: address)
    }
}
