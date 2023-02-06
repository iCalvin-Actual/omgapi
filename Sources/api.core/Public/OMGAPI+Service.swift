//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import Foundation

extension omg_api {
    public func serviceInfo() async throws -> ServiceInfo {
        let request = GETServiceInfoAPIRequest()
        let response = try await apiResponse(for: request)
        
        let info = ServiceInfo(summary: response.message ?? "", members: Int(response.members) ?? 0, addresses: Int(response.addresses) ?? 0, profiles: Int(response.profiles) ?? 0)
        
        return info
    }
}
