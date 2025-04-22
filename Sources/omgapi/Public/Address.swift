//
//  Address.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents an address registered on omg.lol
public struct Address: Sendable {
    
    /// Encapsulates availability details for an address.
    public struct Availability: Sendable {
        /// The address being checked.
        public let address: AddressName

        /// Whether the address is available for registration.
        public let available: Bool

        /// The Punycode-encoded version of the address, if applicable.
        public let punyCode: String?
    }

    /// The registered omg.lol address.
    public let name: AddressName

    /// The timestamp when the address was registered.
    public let registered: TimeStamp

    /// Whether the address is currently expired.
    public let expired: Bool

    /// Whether the address has been verified.
    public let verified: Bool
}
