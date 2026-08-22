//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `PasteBinResponseModel`.
struct PasteBinResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of saved pastes.
    let pastebin: [AddressPasteResponseModel.PasteResponseModel]
}

/// Response model for `PasteResponseModel`.
struct AddressPasteResponseModel: CommonAPIResponse {
/// Response model for `Paste`.
    struct PasteResponseModel: Response {
    /// Title or identifier.
        let title: String
    /// Raw text or HTML content.
        let content: String
    /// Last update timestamp.
        let modifiedOn: Int
    /// Visibility flag or status.
        let listed: Int?
        
        var isPublic: Bool {
            listed?.boolValue ?? true
        }
        
        var updated: Date {
            let double = Double(modifiedOn)
            return Date(timeIntervalSince1970: double)
        }
    }
    /// Optional response message string.
    let message: String?
    /// Single paste entry.
    let paste: PasteResponseModel
}

/// Response model for `SavePasteResponseModel`.
struct SavePasteResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Title or identifier.
    let title: String
}

// MARK: Requests

/// Retrieves pastebin contents.
/// - Parameters:
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressPasteBin(_ address: AddressName, authorization: APICredential? = nil) -> APIRequest<None, PasteBinResponseModel> {
    .init(
        authorization: authorization,
        path: PasteBinPath.pastes(address)
    )
}

/// Retrieves pastebin contents.
/// - Parameters:
///   - title: Description for `title`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func GETAddressPaste(_ title: String, from address: AddressName, authorization: APICredential? = nil) -> APIRequest<None, AddressPasteResponseModel> {
    .init(
        authorization: authorization,
        path: PasteBinPath.paste(title, address: address)
    )
}

/// Deletes a resource related to `DELETEAddressPasteContent`.
/// - Parameters:
///   - paste: Description for `paste`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func DELETEAddressPasteContent(paste: String, address: AddressName, authorization: APICredential) -> APIRequest<None, BasicResponse> {
    .init(
        authorization: authorization,
        method: .DELETE,
        path: PasteBinPath.managePaste(paste, address: address)
    )
}

/// Creates or updates data for `SETAddressPaste`.
/// - Parameters:
///   - draft: Description for `draft`.
///   - address: Description for `address`.
///   - authorization: Description for `authorization`.
func SETAddressPaste(_ draft: Paste.Draft, to address: AddressName, authorization: APICredential) -> APIRequest<Paste.Draft, SavePasteResponseModel> {
    .init(
        authorization: authorization,
        method: .POST,
        path: PasteBinPath.pastes(address),
        body: draft
    )
}

