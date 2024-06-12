//
//  Account.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Account: Sendable {
    private let info: AccountInfo
    
    internal init(info: AccountInfo) {
        self.info = info
    }
}

extension Account {
    public var emailAddress: String                         { info.email }
    public var name: String                                 { info.name }
    public var created: Date                                { info.created.date }
}
