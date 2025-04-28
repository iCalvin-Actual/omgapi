//
//  File.swift
//  omgapi
//
//  Created by Calvin Chestnut on 4/24/25.
//

import Foundation
import Punycode

/// A collection of `AddressName` instances
public typealias Directory = [AddressName]
/// Typealias around `String` represents a regestered Address on the omg.lol service.
public typealias AddressName = String


/// Structure contains public meta-data about a particular `AddressName` registered on omg.lol
///
/// Account info is protected by an authentication code, but expiration status, verification status, and registration date are all public properties of an active ``AddressName``and can be fetched for any address.
public struct AddressInfo: Sendable {

    /// The registered omg.lol address.
    public let name: AddressName

    /// The timestamp when the address was registered.
    public let registered: Date

    /// Indicates whether the Address is currently expired.
    public let expired: Bool

    /// Whether the address's owner has been email verified.
    public let verified: Bool
}

/// Indicates availability of any `AddressName` on omg.lol
///
/// Since Addresses on omg.lol must be unique, before one may register an address you first need to validate it's availability. This model contains the result of that request.
public struct AddressAvailability: Sendable {
    /// The address being requested.
    public let address: AddressName

    /// Whether the address is available for registration.
    public let available: Bool

    /// The Punycode-encoded version of the address, if applicable.
    public let punyCode: String?
}

extension AddressName {
    /// Allows quick `@address` formatting for any string when used as an address.
    ///
    /// If self begins with the character `"@"` it will return self,
    /// otherwise it will prepend `"@"` to the beginning of self.
    ///
    /// If `self` is a punycode string it will instead return the correctly decoded value.
    ///
    /// ```swift
    /// print("calvin".addressDisplayString)
    /// // prints "@calvin"
    /// ```
    public var addressDisplayString: String {
        guard self.prefix(1) != "@" else { return self }
        
        let address: AddressName = {
            guard let upperIndex = range(of: "xn--")?.upperBound else { return self }
            return String(suffix(from: upperIndex)).punycodeDecoded ?? self
        }()
        
        return "@\(address)"
    }
    
    /// The presumed avatar icon reference, assuming a valid omg.lol ``AddressName``
    ///
    /// Drops `self` into a URL formatted for the omg.lol avatar cache.
    ///
    /// `https://profiles.cache.lol/\(self)/picture`
    ///
    /// ```swift
    /// let avatarURL = someAddress.addressIconURL
    /// ```
    ///
    /// Or you can just fetch the icon data directly.
    /// ```swift
    /// async let avatar = try client.avatar(someAddress)
    /// ```
    public var addressIconURL: URL? {
        URL(string: "https://profiles.cache.lol/\(self)/picture")
    }
}
