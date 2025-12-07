//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `AddressPicResponse`.
struct AddressPicResponse: Response {
    /// Unique identifier for the Pic.
    let id: String
    /// The omg.lol address associated with the Pic.
    let address: String
    /// The timestamp when the Pic was uploaded.
    let created: TimeInterval
    /// The URL where the image can be viewed
    let url: URL?
    /// MIME type of the uploaded image (e.g., "image/jpeg").
    let mime: String
    /// File size as a human-readable string (e.g., "512 KB").
    let size: Int
    /// Optional description provided by the uploader.
    let description: String
    /// Dictionary of EXIF metadata extracted from the image.
    let exif: [String: String]?
}

/// Response model for `GETPicsFeed` and `GETAddressPics`.
struct PicsResponseModel: CommonAPIResponse {
    let message: String?
    let pics: [AddressPicResponse]
}

/// Response model for `GETAddressPic` and `POSTAddressPic`.
struct PicResponseModel: CommonAPIResponse {
    let message: String?
    let pic: AddressPicResponse
}

// MARK: Requests

/// Retrieves the global omg.lol Pics feed.
class GETPicsFeed: APIRequest<None, PicsResponseModel> {
    init() {
        super.init(path: PicsPath.picsFeed)
    }
}

/// Retrieves all Pics for the specified omg.lol address.
/// - Parameter address: The address whose Pics should be fetched.
class GETAddressPics: APIRequest<None, PicsResponseModel> {
    init(_ address: String) {
        super.init(path: PicsPath.addressPics(address))
    }
}

/// Retrieves a specific Pic by name for the given address.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic's filename or identifier.
class GETAddressPic: APIRequest<None, PicResponseModel> {
    init(_ address: String, target: String) {
        super.init(path: PicsPath.addressPic(address, target))
    }
}

/// Updates the metadata for an existing Pic.
/// - Parameters:
///   - draft: The updated description and tags.
///   - address: The address that owns the Pic.
///   - target: The Pic identifier to update.
///   - credential: API credential with permission to modify the Pic.
class PATCHAddressPic: APIRequest<Pic.Draft, BasicResponse> {
    init(draft: Pic.Draft, _ address: String, target: String, credential: APICredential) {
        super.init(
            authorization: credential,
            method: .PATCH,
            path: PicsPath.addressPic(address, target),
            body: draft
        )
    }
}

/// Uploads a new Pic to the specified address.
/// - Parameters:
///   - image: The raw image data to upload.
///   - address: The address to associate the Pic with.
///   - credential: API credential for authorization.
class POSTAddressPic: APIRequest<Data, PicResponseModel> {
    init(image: Data, _ address: String, credential: APICredential) {
        super.init(
            authorization: credential,
            method: .POST,
            path: PicsPath.upload(address),
            body: image,
            multipartBody: true
        )
    }
}

/// Deletes a Pic from the specified address.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic to delete.
///   - credential: API credential with deletion rights.
class DELETEAddressPic: APIRequest<None, BasicResponse> {
    init(_ address: String, target: String, credential: APICredential) {
        super.init(
            authorization: credential,
            method: .DELETE,
            path: PicsPath.addressPic(address, target)
        )
    }
}

/// Retrieves raw image data for a specific Pic.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic identifier.
///   - ext: The image file extension (e.g. "jpg", "png").
class GETPicData: APIRequest<None, Data> {
    init(_ address: String, target: String, ext: String) {
        super.init(path: CDNPath.pic(address, target, ext))
    }
}
