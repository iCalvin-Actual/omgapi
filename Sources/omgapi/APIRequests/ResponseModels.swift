//
//  ResponseModels.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

// MARK: Service

struct ServiceInfoResponse: CommonAPIResponse {
    let message: String?
    let members: String
    let addresses: String
    let profiles: String
}

// MARK: - Account

struct OAuthResponse: Response {
    let accessToken: String?
}

struct AccountInfo: CommonAPIResponse {
    let message: String?
    
    let email: String
    let created: TimeStamp
    let name: String
}

struct AccountOwner: CommonAPIResponse {
    let message: String?
    let name: String?
}

struct AccountAddressResponse: Response {
    let message: String?
    let address: String
    let registration: TimeStamp
}

typealias AddressCollection = [AccountAddressResponse]
extension AddressCollection: Response { }

// MARK: - Addresses

struct AddressDirectoryResponse: CommonAPIResponse {
    let message: String?
    let url: String
    let directory: [String]
}

struct AddressInfoResponse: CommonAPIResponse {
    struct Expiration: CommonAPIResponse {
        let message: String?
        let expired: Bool
        let willExpire: Bool?
        let unixEpochTime: String?
        let relativeTime: String?
    }
    
    struct Verification: CommonAPIResponse {
        let message: String?
        let verified: Bool
    }
    let message: String?
    let address: String
    let owner: String?
    let registration: TimeStamp
    let expiration: Expiration
    let verification: Verification
}

struct AddressAvailabilityResponse: CommonAPIResponse {
    let message: String?
    
    let address: String
    let available: Bool
    
    let availability: String
    
    let punyCode: String?
}

// MARK: - Now

struct NowGardenResponse: CommonAPIResponse {
    struct Now: Response {
        let address: String
        let url: String
        let updated: TimeStamp
    }
    let message: String?
    let garden: [Now]
}

struct AddressNowResponseModel: CommonAPIResponse {
    struct Now: Response {
        let content: String
        let updated: Int
        let listed: Int
        
        var updatedAt: Date {
            let double = Double(updated)
            return Date(timeIntervalSince1970: double)
        }
    }
    let message: String?
    let now: Now
}

// MARK: - PasteBin

struct PasteBinResponseModel: CommonAPIResponse {
    let message: String?
    let pastebin: [PasteResponseModel.Paste]
}

struct PasteResponseModel: CommonAPIResponse {
    struct Paste: Response {
        let title: String
        let content: String
        let modifiedOn: Int
        let listed: Int?
        
        var isPublic: Bool {
            listed?.boolValue ?? true
        }
        
        var updated: Date {
            let double = Double(modifiedOn)
            return Date(timeIntervalSince1970: double)
        }
    }
    let message: String?
    let paste: Paste
}

struct SavePasteResponseModel: CommonAPIResponse {
    let message: String?
    let title: String
}

// MARK: - PURL

struct AddressPURLResponse: Response {
    let name: String
    let url: String
    let counter: Int?
}

struct AddressPURLItemResponse: Response {
    let name: String
    let url: String
    let counter: Int?
    let listed: String?
    
    var isPublic: Bool {
        listed.boolValue
    }
}

typealias AddressPURLsResponse = [AddressPURLItemResponse]

struct GETPURLsResponseModel: CommonAPIResponse {
    let message: String?
    let purls: AddressPURLsResponse
}

struct GETPURLResponseModel: CommonAPIResponse {
    let message: String?
    let purl: AddressPURLResponse
}

// MARK: - Profile

struct ProfileResponseModel: CommonAPIResponse {
    let message: String?
    
    let content: String?
    let html: String?
    
    let type: String?
    let theme: String?
    
    let css: String?
    let head: String?
    
    let verified: Int?
    
    let pfp: String?
    
    let metadata: String?
}

// MARK: - StatusLog

struct AddressStatusModel: Response {
    
    let id: String
    let address: AddressName
    let created: String
    
    let content: String
    let emoji: String?
    let externalURL: URL?
    
    var createdDate: Date {
        Date(timeIntervalSince1970: Double(created) ?? 0)
    }
}

struct StatusLogBioResponseModel: CommonAPIResponse {
    let message: String?
    let bio: String?
    let css: String?
}

struct NewStatusResponseModel: CommonAPIResponse {
    let message: String?
    let id: String
    let status: String
    let url: String
    let externalUrl: String?
}

struct StatusResponseModel: CommonAPIResponse {
    let message: String?
    let status: AddressStatusModel
}

struct StatusLogResponseModel: CommonAPIResponse {
    let message: String?
    let statuses: [AddressStatusModel]?
}

// MARK: - Themes

struct ThemesResponseModel: CommonAPIResponse {
    let message: String?
    let themes: [String: ThemeResponseModel]
}

struct ThemeResponseModel: Response {
    let id: String
    let name: String
    let created: String
    let updated: String
    let author: String
    let authorUrl: String
    let version: String
    let license: String
    let description: String
    let previewCss: String
    let sampleProfile: String
}

