//
//  Account.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Account {
    public struct Address {
        public let name: AddressName
        public let registered: TimeStamp
    }
    
    private let owner: AccountOwner
    private let info: AccountInfo
    private let addresses: [Address]
    
    internal init(owner: AccountOwner, info: AccountInfo, addresses: [Address]) {
        self.owner = owner
        self.info = info
        self.addresses = addresses
    }
}

extension Account {
    public var emailAddress: String                         { info.email }
    public var name: String                                 { owner.name ?? "" }
    public var created: Date                                { info.created.date }
    public var registered: [Address]                        { addresses }
}
