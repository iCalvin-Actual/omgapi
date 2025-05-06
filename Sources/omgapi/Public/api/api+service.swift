//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    /// Returns information about the omg.lol service, specifically the number of Addresses and Profiles
    /// - Returns: ``ServiceInfo`` model containing counts of members, addresses, and profiles on the omg.lol service
    func serviceInfo() async throws -> ServiceInfo {
        let request = GETServiceInfoAPIRequest()
        let response = try await apiResponse(for: request)
        
        let info = ServiceInfo(
            summary: response.message ?? "",
            members: Int(response.members) ?? 0,
            addresses: Int(response.addresses) ?? 0,
            profiles: Int(response.profiles) ?? 0
        )
        
        return info
    }
    
    /// Retrieves the full list of every available omg.lol Profile ``Theme``.
    ///
    /// - Returns: An array of `Theme` objects.
    func themes() async throws -> [Theme] {
        let request = GETThemes()
        let response = try await apiResponse(for: request)
        let themes = response.themes.values.map({ model in
            Theme(
                id: model.id,
                name: model.name,
                created: model.created,
                updated: model.updated,
                author: model.author,
                authorUrl: model.authorUrl,
                version: model.version,
                license: model.license,
                description: model.description,
                previewCss: model.previewCss
            )
        })
        return themes
    }
}
