//
//  Account.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A user account wrapper that provides access to account details.
public struct Account: Sendable {
    /// Internal account metadata from the API.
    private let info: AccountInfo

    /// Creates an `Account` from a decoded `AccountInfo`.
    ///
    /// - Parameter info: The backing account info model.
    internal init(info: AccountInfo) {
        self.info = info
    }
}

extension Account {
    /// The email address associated with the account.
    public var emailAddress: String                         { info.email }

    /// The given display name of the account holder.
    public var name: String                                 { info.name }

    /// The date when the account was created.
    public var created: Date                                { info.created.date }
}
