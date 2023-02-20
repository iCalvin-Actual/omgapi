//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Combine
import Foundation

public extension omg_api {
    
    func publicProfile(_ address: AddressName) async throws -> PublicProfile {
        let request = GETAddressProfile(address)
        let response = try await apiResponse(for: request)
        return PublicProfile(
            address: address,
            content: response
        )
    }
    
    // Circle back after authentication. Only works for 'my' profilesbiwreqyes
//    func profile(_ address: AddressName, with credential: APICredentials) async throws -> Profile {
//        let request = GETAddressProfile(address)
//        let response = try await apiResponse(for: request)
//        return Profile(
//            address: address,
//            content: response.content ?? "",
//            theme: response.theme ?? "",
//            head: response.head,
//            css: response.css
//        )
//    }
    
    func save(_ draft: PublicProfile.Draft, for address: AddressName, credential: APICredentials) async throws -> PublicProfile {
        let request = SETAddressProfile(draft, for: address, with: credential.authKey)
        let _ = try await apiResponse(for: request)
        return try await publicProfile(address)
    }
    
    func photo(for address: AddressName) async throws -> ProfilePhoto? {
        let profile = try await publicProfile(address)
        guard profile.content?.contains("SPECIFIC STRING") ?? false else {
            return nil
        }
        // Pull the URL from the HTML content
        // Fetch the image data
        return nil
    }
    
    func save(_ photo: ProfilePhoto, for address: AddressName, credential: APICredentials) async throws {
        let request = SETAddressPhoto(photo, for: address, with: credential.authKey)
        let _ = try await apiResponse(for: request)
    }
}
