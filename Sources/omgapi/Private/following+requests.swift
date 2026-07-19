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
    let followers: Directory
    let followersCount: Int
}

/// Response model for `AddressFollowingModel`.
struct StatusLogFollowingResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of addresses the user is following.
    let following: Directory
    /// Count of followed addresses.
    let followingCount: Int
}

// MARK: Requests

/// Retrieves the list of addresses followed by the given address.
/// - Parameter address: The omg.lol address whose follow list should be fetched.
func GETAddressFollowing(_ address: AddressName) -> APIRequest<None, StatusLogFollowingResponseModel> {
    .init(path: StatusPath.addressFollowing(address))
}

/// Retrieves the list of followers for the given address.
/// - Parameter address: The omg.lol address whose followers should be fetched.
func GETAddressFollowers(_ address: AddressName) -> APIRequest<None, StatusLogFollowersResponseModel> {
    .init(path: StatusPath.addressFollowers(address))
}

/// Submits a request for an address to follow another address.
/// - Parameters:
///   - address: The address initiating the follow.
///   - target: The address to follow.
///   - authorization: API credential of the follower.
func SETAddressFollowing(_ address: AddressName, _ target: AddressName, authorization: APICredential) -> APIRequest<None, BasicResponse> {
    .init(
        authorization: authorization,
        method: .POST,
        path: StatusPath.addressFollow(address, target)
    )
}

/// Unfollows a target address on behalf of another.
/// - Parameters:
///   - address: The address initiating the unfollow.
///   - target: The address to unfollow.
///   - authorization: API credential of the unfollower.
func DELETEAddressFollowing(_ address: AddressName, _ target: AddressName, authorization: APICredential) -> APIRequest<None, BasicResponse> {
    .init(
        authorization: authorization,
        method: .DELETE,
        path: StatusPath.addressFollow(address, target)
    )
}
