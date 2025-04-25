//
//  Account.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A type alias representing an API credential, typically a bearer token.
public typealias APICredential = String

/// A user account wrapper that provides access to account details.
public struct Account: Sendable {
    /// Creates an `Account` from a decoded `AccountInfo`.
    ///
    /// - Parameter info: The backing account info model.
    init(info: AccountInfoResponseModel) {
        self.emailAddress = info.email
        self.name = info.name
        self.created = info.created.date
    }
    
    /// User's email address.
    public let emailAddress: String
    /// Account creation timestamp.
    public let created: Date
    /// Display name or username.
    public let name: String
}
