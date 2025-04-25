//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `AddressFollowersModel`.
struct StatusLogFollowersResponseModel: CommonAPIResponse {
    let message: String?
    let followers: AddressDirectory
    let followersCount: Int
}

/// Response model for `AddressFollowingModel`.
struct StatusLogFollowingResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of addresses the user is following.
    let following: AddressDirectory
    /// Count of followed addresses.
    let followingCount: Int
}

// MARK: Requests

/// Retrieves the list of addresses followed by the given address.
/// - Parameter address: The omg.lol address whose follow list should be fetched.
class GETAddressFollowing: APIRequest<None, StatusLogFollowingResponseModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressFollowing(address))
    }
}

/// Retrieves the list of followers for the given address.
/// - Parameter address: The omg.lol address whose followers should be fetched.
class GETAddressFollowers: APIRequest<None, StatusLogFollowersResponseModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressFollowers(address))
    }
}

/// Submits a request for an address to follow another address.
/// - Parameters:
///   - address: The address initiating the follow.
///   - target: The address to follow.
///   - authorization: API credential of the follower.
class SETAddressFollowing: APIRequest<None, BasicResponse> {
    init(_ address: AddressName, _ target: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressFollow(address, target)
        )
    }
}

/// Unfollows a target address on behalf of another.
/// - Parameters:
///   - address: The address initiating the unfollow.
///   - target: The address to unfollow.
///   - authorization: API credential of the unfollower.
class DELETEAddressFollowing: APIRequest<None, BasicResponse> {
    init(_ address: AddressName, _ target: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: StatusPath.addressFollow(address, target)
        )
    }
}
