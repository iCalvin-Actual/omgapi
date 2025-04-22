//
//  TypeAliases.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A type alias representing an omg.lol address.
public typealias AddressName = String

/// A type alias representing an API credential, typically a bearer token.
public typealias APICredential = String


public extension AddressName {
    /// Helper method of AddressName to prepare Address for display in the UI
    ///
    /// If self begins with the character `"@"` it will return self,
    /// otherwise it will prepend `"@"` to the beginning of self.
    ///
    /// ```swift
    /// print("calvin".addressDisplayString)
    /// // prints "@calvin"
    /// ```
    var addressDisplayString: String {
        guard self.prefix(1) != "@" else { return self }
        
        return "@\(self)"
    }
}
