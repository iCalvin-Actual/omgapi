//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/23/25.
//

import Foundation

public extension api {
    /// Retrieves high-level information about the omg.lol service (member count, profile count, etc.).
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
    
    /// Retrieves the full list of available omg.lol themes.
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
