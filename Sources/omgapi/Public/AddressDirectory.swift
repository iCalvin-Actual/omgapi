//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation

/// A type alias representing a partial or complete set of Addresses on omg.lol
public typealias AddressDirectory = [AddressName]
/// A type alias representing an omg.lol address.
public typealias AddressName = String


/// Represents an address registered on omg.lol
public struct AddressInfo: Sendable {
    
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
    public let registered: Date

    /// Whether the address is currently expired.
    public let expired: Bool

    /// Whether the address has been verified.
    public let verified: Bool
}

extension AddressName {
    /// Allows quick `@address` formatting for any string when used as an address.
    ///
    /// If self begins with the character `"@"` it will return self,
    /// otherwise it will prepend `"@"` to the beginning of self.
    ///
    /// ```swift
    /// print("calvin".addressDisplayString)
    /// // prints "@calvin"
    /// ```
    public var addressDisplayString: String {
        guard self.prefix(1) != "@" else { return self }
        
        return "@\(self)"
    }
}
