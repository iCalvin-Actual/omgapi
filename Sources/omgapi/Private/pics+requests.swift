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

/// Response model for `GETAddressPic`.
struct PicResponseModel: CommonAPIResponse {
    let message: String?
    let pic: AddressPicResponse
}

/// Response model for `POSTAddressPic`.
///
/// The upload endpoint returns the new pic's fields directly in `response`
/// rather than nested under a `pic` key, so both shapes are accepted here.
struct PicUploadResponseModel: CommonAPIResponse {
    let message: String?
    let id: String?
    let pic: AddressPicResponse?
}

// MARK: Requests

/// Retrieves the global omg.lol Pics feed.
func GETPicsFeed() -> APIRequest<None, PicsResponseModel> {
    .init(path: PicsPath.picsFeed)
}

/// Retrieves all Pics for the specified omg.lol address.
/// - Parameter address: The address whose Pics should be fetched.
func GETAddressPics(_ address: String) -> APIRequest<None, PicsResponseModel> {
    .init(path: PicsPath.addressPics(address))
}

/// Retrieves a specific Pic by name for the given address.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic's filename or identifier.
func GETAddressPic(_ address: String, target: String) -> APIRequest<None, PicResponseModel> {
    .init(path: PicsPath.addressPic(address, target))
}

/// Updates the metadata for an existing Pic.
/// - Parameters:
///   - draft: The updated description and tags.
///   - address: The address that owns the Pic.
///   - target: The Pic identifier to update.
///   - credential: API credential with permission to modify the Pic.
func PATCHAddressPic(draft: Pic.Draft, _ address: String, target: String, credential: APICredential) -> APIRequest<Pic.Draft, BasicResponse> {
    .init(
        authorization: credential,
        method: .PATCH,
        path: PicsPath.addressPic(address, target),
        body: draft
    )
}

/// Request body for `POSTAddressPic`: the image bytes as a base64 string
/// under the `pic` key, which is the JSON payload the upload endpoint expects.
struct PicUploadRequestBody: RequestBody {
    let pic: String
}

/// Uploads a new Pic to the specified address.
/// - Parameters:
///   - image: The raw image data to upload.
///   - address: The address to associate the Pic with.
///   - credential: API credential for authorization.
func POSTAddressPic(image: Data, _ address: String, credential: APICredential) -> APIRequest<PicUploadRequestBody, PicUploadResponseModel> {
    .init(
        authorization: credential,
        method: .POST,
        path: PicsPath.upload(address),
        body: PicUploadRequestBody(pic: image.base64EncodedString())
    )
}

/// Deletes a Pic from the specified address.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic to delete.
///   - credential: API credential with deletion rights.
func DELETEAddressPic(_ address: String, target: String, credential: APICredential) -> APIRequest<None, BasicResponse> {
    .init(
        authorization: credential,
        method: .DELETE,
        path: PicsPath.addressPic(address, target)
    )
}

/// Retrieves raw image data for a specific Pic.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic identifier.
///   - ext: The image file extension (e.g. "jpg", "png").
func GETPicData(_ address: String, target: String, ext: String) -> APIRequest<None, Data> {
    .init(path: CDNPath.pic(address, target, ext))
}
