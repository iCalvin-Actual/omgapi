//
//  ResponseModels.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

// MARK: Service

/// Response model for `ServiceInfoResponse`.
struct ServiceInfoResponse: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Endpoint for members resource.
    let members: String
    /// Endpoint for addresses resource.
    let addresses: String
    /// Endpoint for profiles resource.
    let profiles: String
}

// MARK: - Account

/// Response model for `OAuthResponse`.
struct OAuthResponse: Response {
    /// OAuth access token string.
    let accessToken: String?
}

/// Response model for `AccountInfo`.
struct AccountInfo: CommonAPIResponse, Sendable {
    /// Optional response message string.
    let message: String?
    
    /// User's email address.
    let email: String
    /// Account creation timestamp.
    let created: TimeStamp
    /// Display name or username.
    let name: String
}

/// Response model for `AccountOwner`.
struct AccountOwner: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Display name or username.
    let name: String?
}

/// Response model for `AccountAddressResponse`.
struct AccountAddressResponse: Response {
    /// Optional response message string.
    let message: String?
    /// The omg.lol address this relates to.
    let address: String
    /// Timestamp when the address was registered.
    let registration: TimeStamp
}

typealias AddressCollection = [AccountAddressResponse]
extension AddressCollection: Response { }

// MARK: - Addresses

/// Response model for `AddressDirectoryResponse`.
struct AddressDirectoryResponse: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Associated URL.
    let url: String
    /// List of known addresses.
    let directory: [String]
}

/// Response model for `AddressInfoResponse`.
struct AddressInfoResponse: CommonAPIResponse {
/// Response model for `Expiration`.
    struct Expiration: CommonAPIResponse {
    /// Optional response message string.
        let message: String?
    /// Property `expired` of type `Bool`.
        let expired: Bool
    /// Property `willExpire` of type `Bool?`.
        let willExpire: Bool?
    /// Property `unixEpochTime` of type `String?`.
        let unixEpochTime: String?
    /// Property `relativeTime` of type `String?`.
        let relativeTime: String?
    }
    
/// Response model for `Verification`.
    struct Verification: CommonAPIResponse {
    /// Optional response message string.
        let message: String?
    /// Whether the item is verified.
        let verified: Bool
    }
    /// Optional response message string.
    let message: String?
    /// The omg.lol address this relates to.
    let address: String
    /// Property `owner` of type `String?`.
    let owner: String?
    /// Timestamp when the address was registered.
    let registration: TimeStamp
    /// Expiration info for the address.
    let expiration: Expiration
    /// Verification state for the address.
    let verification: Verification
}

/// Response model for `AddressAvailabilityResponse`.
struct AddressAvailabilityResponse: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    
    /// The omg.lol address this relates to.
    let address: String
    /// Whether the address is available.
    let available: Bool
    
    /// Availability status string.
    let availability: String
    
    /// Punycode-encoded version of the address.
    let punyCode: String?
}

// MARK: - Now

/// Response model for `NowGardenResponse`.
struct NowGardenResponse: CommonAPIResponse {
/// Response model for `Now`.
    struct Now: Response {
    /// The omg.lol address this relates to.
        let address: String
    /// Associated URL.
        let url: String
    /// Property `updated` of type `TimeStamp`.
        let updated: TimeStamp
    }
    /// Optional response message string.
    let message: String?
    /// Collection of Now entries.
    let garden: [Now]
}

/// Response model for `AddressNowResponseModel`.
struct AddressNowResponseModel: CommonAPIResponse {
/// Response model for `Now`.
    struct Now: Response {
    /// Raw text or HTML content.
        let content: String
    /// Property `updated` of type `Int`.
        let updated: Int
    /// Visibility flag or status.
        let listed: Int
        
        var updatedAt: Date {
            let double = Double(updated)
            return Date(timeIntervalSince1970: double)
        }
    }
    /// Optional response message string.
    let message: String?
    /// Property `now` of type `Now`.
    let now: Now
}

// MARK: - PasteBin

/// Response model for `PasteBinResponseModel`.
struct PasteBinResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of saved pastes.
    let pastebin: [PasteResponseModel.Paste]
}

/// Response model for `PasteResponseModel`.
struct PasteResponseModel: CommonAPIResponse {
/// Response model for `Paste`.
    struct Paste: Response {
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
    let paste: Paste
}

/// Response model for `SavePasteResponseModel`.
struct SavePasteResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Title or identifier.
    let title: String
}

// MARK: - PURL

/// Response model for `AddressPURLResponse`.
struct AddressPURLResponse: Response {
    /// Display name or username.
    let name: String
    /// Associated URL.
    let url: String
    /// Access or hit count.
    let counter: Int?
}

/// Response model for `AddressPURLItemResponse`.
struct AddressPURLItemResponse: Response {
    /// Display name or username.
    let name: String
    /// Associated URL.
    let url: String
    /// Access or hit count.
    let counter: Int?
    /// Visibility flag or status.
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}

typealias AddressPURLsResponse = [AddressPURLItemResponse]

/// Response model for `GETPURLsResponseModel`.
struct PURLsResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of PURL records.
    let purls: AddressPURLsResponse
}

/// Response model for `GETPURLResponseModel`.
struct PURLResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Single PURL record.
    let purl: AddressPURLResponse
}

// MARK: - Profile

/// Response model for `ProfileResponseModel`.
struct ProfileResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    
    /// Raw text or HTML content.
    let content: String?
    /// Rendered HTML version of the content.
    let html: String?
    
    /// Theme or profile type.
    let type: String?
    /// Theme name or identifier.
    let theme: String?
    
    /// Custom stylesheet applied.
    let css: String?
    /// Injected <head> HTML content.
    let head: String?
    
    /// Whether the item is verified.
    let verified: Int?
    
    /// Profile picture URL or identifier.
    let pfp: String?
    
    /// Raw profile metadata as string.
    let metadata: String?
}

// MARK: - StatusLog

/// Response model for `AddressStatusModel`.
struct AddressStatusModel: Response {
    
    /// Property `id` of type `String`.
    let id: String
    /// The omg.lol address this relates to.
    let address: AddressName
    /// Account creation timestamp.
    let created: String
    
    /// Raw text or HTML content.
    let content: String
    /// Property `emoji` of type `String?`.
    let emoji: String?
    /// Property `externalURL` of type `URL?`.
    let externalURL: URL?
    
    var createdDate: Date {
        Date(timeIntervalSince1970: Double(created) ?? 0)
    }
}

/// Response model for `AddressBioResponseModel`.
struct StatusLogBioResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `bio` of type `String?`.
    let bio: String?
    /// Custom stylesheet applied.
    let css: String?
}

/// Response model for `AddressFollowersModel`.
struct StatusLogFollowersModel: CommonAPIResponse {
    let message: String?
    let followers: [AddressName]
    let followersCount: Int
}

/// Response model for `AddressFollowingModel`.
struct StatusLogFollowingModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// List of addresses the user is following.
    let following: [AddressName]
    /// Count of followed addresses.
    let followingCount: Int
}

/// Response model for `NewStatusResponseModel`.
struct NewStatusResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `id` of type `String`.
    let id: String
    /// Property `status` of type `String`.
    let status: String
    /// Associated URL.
    let url: String
    /// Property `externalUrl` of type `String?`.
    let externalUrl: String?
}

/// Response model for `StatusResponseModel`.
struct StatusResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `status` of type `AddressStatusModel`.
    let status: AddressStatusModel
}

/// Response model for `StatusLogResponseModel`.
struct StatusLogResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `statuses` of type `[AddressStatusModel]?`.
    let statuses: [AddressStatusModel]?
}

// MARK: - Themes

/// Response model for `ThemesResponseModel`.
struct ThemesResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Property `themes` of type `[String`.
    let themes: [String: ThemeResponseModel]
}

/// Response model for `ThemeResponseModel`.
struct ThemeResponseModel: Response {
    /// Property `id` of type `String`.
    let id: String
    /// Display name or username.
    let name: String
    /// Account creation timestamp.
    let created: String
    /// Property `updated` of type `String`.
    let updated: String
    /// Property `author` of type `String`.
    let author: String
    /// Property `authorUrl` of type `String`.
    let authorUrl: String
    /// Property `version` of type `String`.
    let version: String
    /// Property `license` of type `String`.
    let license: String
    /// Property `description` of type `String`.
    let description: String
    /// Property `previewCss` of type `String`.
    let previewCss: String
    /// Property `sampleProfile` of type `String`.
    let sampleProfile: String
}

// MARK: - Pics

/// Response model for `PicResponse`.
struct PicResposne: Response {
    /// Unique identifier for the Pic.
    let id: String
    /// The omg.lol address associated with the Pic.
    let address: String
    /// The timestamp when the Pic was uploaded.
    let created: String
    /// MIME type of the uploaded image (e.g., "image/jpeg").
    let mime: String
    /// File size as a human-readable string (e.g., "512 KB").
    let size: String
    /// Optional description provided by the uploader.
    let description: String
    /// Dictionary of EXIF metadata extracted from the image.
    let exif: [String: String]
}

/// Response model for `GETPicsFeed` and `GETAddressPics`.
struct PicsResponseModel: CommonAPIResponse {
    let message: String?
    let pics: [PicResposne]
}

/// Response model for `GETAddressPic` and `POSTAddressPic`.
struct PicResponseModel: CommonAPIResponse {
    let message: String?
    let pic: PicResposne
}
