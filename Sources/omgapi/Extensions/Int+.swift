//
//  Int+.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Useful extensions to `Int`
extension Int {
    /// Collapses any value into a `Bool`.
    /// `0` will return `false`, any other value returns `true`
    var boolValue: Bool {
        switch self {
        case 0:
            return false
        default:
            return true
        }
    }
}

/// Useful extensions to optional `Int`
extension Int? {
    /// Optional compatible implemetation of `Int.boolValue`
    /// Will return `false` when `nil`
    var boolValue: Bool {
        self?.boolValue ?? false
    }
}
