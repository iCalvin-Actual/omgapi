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
