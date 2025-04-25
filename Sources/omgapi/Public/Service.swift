//
//  ServiceInfo.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents high-level metadata about the omg.lol service.
public struct ServiceInfo: Sendable {
    /// A human-readable summary of the service status or state.
    public let summary: String

    /// The total number of registered omg.lol members.
    public let members: Int

    /// The total number of omg.lol addresses.
    public let addresses: Int

    /// The total number of created omg.lol profiles.
    public let profiles: Int
}

/// Represents a visual theme available for omg.lol profiles.
public struct Theme: Sendable {
    /// A unique identifier for the theme.
    public let id: String

    /// The display name of the theme.
    public let name: String

    /// ISO 8601 date string representing when the theme was created.
    public let created: String

    /// ISO 8601 date string representing when the theme was last updated.
    public let updated: String

    /// The name of the theme’s author.
    public let author: String

    /// A URL linking to the author’s website or profile.
    public let authorUrl: String

    /// The version of the theme.
    public let version: String

    /// The license under which the theme is distributed.
    public let license: String

    /// A short description of the theme.
    public let description: String

    /// The theme's CSS used for preview purposes.
    public let previewCss: String
}
