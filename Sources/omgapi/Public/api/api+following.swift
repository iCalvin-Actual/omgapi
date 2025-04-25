//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Fetches the list of addresses following a given omg.lol address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of follower addresses.
    func followers(for address: AddressName) async throws -> AddressDirectory {
        let request = GETAddressFollowers(address)
        let response = try await apiResponse(for: request)
        return response.followers
    }
    
    /// Fetches the list of addresses followed by a given omg.lol address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of followed addresses.
    func following(from address: AddressName) async throws -> AddressDirectory {
        let request = GETAddressFollowing(address)
        let response = try await apiResponse(for: request)
        return response.following
    }
    
    /// Submits a request for one omg.lol address to follow another.
    /// - Parameters:
    ///   - target: The address to follow.
    ///   - address: The address initiating the follow.
    ///   - credential: API credential with permission.
    func follow(_ target: AddressName, from address: AddressName, credential: APICredential) async throws {
        let request = SETAddressFollowing(address, target, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Unfollows a target address on behalf of another.
    /// - Parameters:
    ///   - target: The address to unfollow.
    ///   - address: The address initiating the unfollow.
    ///   - credential: API credential with permission.
    func unfollow(_ target: AddressName, from address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressFollowing(address, target, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
}
