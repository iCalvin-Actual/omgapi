//
//  HTTPMethod.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// An enumeration of HTTP methods used in API requests.
enum HTTPMethod: String {
    /// GET requests retrieve data without modifying server state.
    case GET

    /// PATCH requests perform partial updates to resources.
    case PATCH

    /// POST requests submit new data to be processed by the server.
    case POST

    /// DELETE requests remove resources from the server.
    case DELETE
}
