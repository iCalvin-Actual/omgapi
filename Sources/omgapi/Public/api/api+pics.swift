//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    
    /// Retrieves the global public omg.lol Pics feed.
    /// - Returns: An array of `Pic` objects.
    func getPicsFeed() async throws -> PicReel {
        let request = GETPicsFeed()
        let response = try await apiResponse(for: request)
        let pics = response.pics.map({ model in
            Pic(
                id: model.id,
                address: model.address,
                created: .init(timeIntervalSince1970: model.created),
                size: Double(model.size),
                mime: model.mime,
                exif: model.exif,
                description: model.description
            )
        })
        return pics
    }
    
    /// Retrieves all Pics uploaded by a specific address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of `Pic` objects.
    func getAddressPics(_ address: AddressName) async throws -> PicReel {
        let request = GETAddressPics(address)
        let response = try await apiResponse(for: request)
        let pics = response.pics.map({ model in
            Pic(
                id: model.id,
                address: model.address,
                created: .init(timeIntervalSince1970: model.created),
                size: Double(model.size),
                mime: model.mime,
                exif: model.exif,
                description: model.description
            )
        })
        return pics
    }
    
    /// Retrieves a specific Pic by ID from an address.
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - id: The Pic identifier.
    /// - Returns: A `Pic` object.
    func getAddressPic(_ address: AddressName, id: String) async throws -> Pic {
        let request = GETAddressPic(address, target: id)
        let response = try await apiResponse(for: request)
        let pic = Pic(
            id: response.pic.id,
            address: response.pic.address,
            created: .init(timeIntervalSince1970: response.pic.created),
            size: Double(response.pic.size),
            mime: response.pic.mime,
            exif: response.pic.exif,
            description: response.pic.description
        )
        return pic
    }
    
    /// Uploads a new Pic and applies metadata.
    /// - Parameters:
    ///   - data: Raw image data.
    ///   - info: Metadata including description and tags.
    ///   - address: The omg.lol address to upload to.
    ///   - credential: API credential with permission to upload.
    /// - Returns: A fully populated `Pic` object.
    func uploadPic(_ data: Data, info: Pic.Draft, _ address: AddressName, credential: APICredential) async throws -> Pic {
        let request = POSTAddressPic(image: data, address, credential: credential)
        let response = try await apiResponse(for: request)
        let id = response.pic.id
        return try await updatePicDetails(draft: info, address, id: id, credential: credential)
    }
    
    /// Updates metadata for an existing Pic.
    /// - Parameters:
    ///   - draft: New metadata values.
    ///   - address: The omg.lol address that owns the Pic.
    ///   - id: The Pic identifier.
    ///   - credential: API credential for edit permissions.
    /// - Returns: The updated `Pic` object.
    func updatePicDetails(draft: Pic.Draft, _ address: AddressName, id: String, credential: APICredential) async throws -> Pic {
        let request = PATCHAddressPic(draft: draft, address, target: id, credential: credential)
        let _ = try await apiResponse(for: request)
        return try await getAddressPic(address, id: id)
    }
    
    /// Downloads raw image data for a Pic.
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - id: The Pic identifier.
    ///   - ext: The file extension (e.g., jpg, png).
    /// - Returns: The image data.
    func getPicData(_ address: AddressName, id: String, ext: String) async throws -> Data {
        let request = GETPicData(address, target: id, ext: ext)
        let response = try await apiResponse(for: request)
        return response
    }
}
