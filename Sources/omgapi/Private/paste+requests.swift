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
class GETAddressPasteBin: APIRequest<None, PasteBinResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.pastes(address)
        )
    }
}

/// Retrieves pastebin contents.
class GETAddressPaste: APIRequest<None, AddressPasteResponseModel> {
    /// - Parameters:
    ///   - title: Description for `title`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ title: String, from address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.paste(title, address: address)
        )
    }
}

/// Deletes a resource related to `DELETEAddressPasteContent`.
class DELETEAddressPasteContent: APIRequest<None, BasicResponse> {
    /// - Parameters:
    ///   - paste: Description for `paste`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(paste: String, address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: PasteBinPath.managePaste(paste, address: address)
        )
    }
}

/// Creates or updates data for `SETAddressPaste`.
class SETAddressPaste: APIRequest<Paste.Draft, SavePasteResponseModel> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: Paste.Draft, to address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: PasteBinPath.pastes(address),
            body: draft
        )
    }
}

