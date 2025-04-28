//
//  Account.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Typealias around `String` used for server authorization
public typealias APICredential = String

/// A user account wrapper that provides access to account details.
///
/// Only available via authenticated requests, Account gives you meta fields about the Account owner, distinct from any individual address.
public struct Account: Sendable {
    /// Creates an `Account` from a decoded `AccountInfo`.
    ///
    /// - Parameter info: The backing account info model.
    init(info: AccountInfoResponseModel) {
        self.emailAddress = info.email
        self.name = info.name
        self.created = info.created.date
    }
    
    /// The email address associated to the account and which is used for login.
    public let emailAddress: String
    /// The `Date` when the omg.lol account was originally created
    public let created: Date
    /// A display name to use to reference a registered omg.lol member
    public let name: String
}

extension APICredential {
    /// Helper value to quickly create a Bearer string to inject into a request header, assuming `self` is a valid ``APICredential``.
    var headerValue: String {
        "Bearer \(self)"
    }
}
