//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

// MARK: Models

/// Response model for `ServiceInfoResponse`.
struct ServiceInfoResponseModel: CommonAPIResponse {
    /// Optional response message string.
    let message: String?
    /// Endpoint for members resource.
    let members: String
    /// Endpoint for addresses resource.
    let addresses: String
    /// Endpoint for profiles resource.
    let profiles: String
}

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

// MARK: Requests

/// Retrieves serviceinfo information.
class GETServiceInfoAPIRequest: APIRequest<None, ServiceInfoResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: CommonPath.service)
    }
}

/// Fetches available themes.
class GETThemes: APIRequest<None, ThemesResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: ThemePath.themes)
    }
}
